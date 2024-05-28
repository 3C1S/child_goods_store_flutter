import 'dart:convert';
import 'dart:io';
import 'package:child_goods_store_flutter/blocs/chat/room/chat_room_event.dart';
import 'package:child_goods_store_flutter/blocs/chat/room/chat_room_state.dart';
import 'package:child_goods_store_flutter/configs/configs.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/chat_item_type.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/models/chat/chat_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/chat_repository_interface.dart';
import 'package:child_goods_store_flutter/repositories/interface/product_repository_interfave.dart';
import 'package:child_goods_store_flutter/repositories/interface/together_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

// Private event
class _StompError extends ChatRoomEvent {
  final String? message;

  _StompError(this.message);
}

class _StompLoaded extends ChatRoomEvent {}

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState>
    with DioExceptionHandlerMixin {
  final IChatRepository chatRepository;
  final IProductRepository productRepository;
  final ITogetherRepository togetherRepository;
  final int chatRoomId;
  int? id;
  EChatItemType? type;

  // Chatting STOPM socket
  late final FlutterSecureStorage _storage;
  late StompClient _stompClient;

  ChatRoomBloc({
    required this.chatRepository,
    required this.productRepository,
    required this.togetherRepository,
    required this.chatRoomId,
  }) : super(const ChatRoomState.init()) {
    _storage = const FlutterSecureStorage();

    on<ChatRoomGetItem>(_chatRoomGetItemHandler);
    on<ChatRoomGetChats>(_chatRoomGetChatsHandler);
    on<ChatRoomSendChat>(_chatRoomSendChatHandler);
    on<ChatRoomInitStomp>(_chatRoomInitStompHandler);
    on<_StompError>(__stompErrorHandler);
    on<_StompLoaded>(__stompLoadedHandler);

    add(ChatRoomGetItem());
    add(ChatRoomGetChats());
    add(ChatRoomInitStomp());
  }

  Future<void> _chatRoomGetItemHandler(
    ChatRoomGetItem event,
    Emitter<ChatRoomState> emit,
  ) async {
    if (state.targetStatus == ELoadingStatus.loading) return;
    emit(state.copyWith(
      status: ELoadingStatus.loading,
      targetStatus: ELoadingStatus.loading,
    ));
    await handleApiRequest(
      () async {
        // Step 1: chatRoomId로 id, type을 알아낸다. -> id, type 초기화
        if (id == null || type == null) {
          var res = await chatRepository.getItemByChatRoomId(
            chatRoomId: chatRoomId,
          );
          if (res.data?.id == null || res.data?.type == null) {
            throw Exception('상품 정보를 조회할 수 없습니다.');
          }
          id = res.data!.id!;
          type = res.data!.type!;
        }
        // Step 2: id, type으로 상품 정보를 알아낸다.
        switch (type!) {
          case EChatItemType.product:
            var res = await productRepository.getProduct(
              productId: id!,
            );
            emit(state.copyWith(
              status: ELoadingStatus.loaded,
              targetStatus: ELoadingStatus.loaded,
              targetProduct: res.data,
            ));
            syncState(state);
            break;
          case EChatItemType.together:
            var res = await togetherRepository.getTogether(
              togetherId: id!,
            );
            emit(state.copyWith(
              status: ELoadingStatus.loaded,
              targetStatus: ELoadingStatus.loaded,
              targetTogether: res.data,
            ));
            syncState(state);
            break;
        }

        if (state.chatStatus == ELoadingStatus.error) {
          add(ChatRoomGetChats());
        }
      },
      state: state,
      emit: emit,
      initAfterError: false,
      finallyCall: () async {
        if (state.status == ELoadingStatus.error) {
          emit(state.copyWith(
            targetStatus: ELoadingStatus.error,
            targetErrMessage: state.message,
          ));
          syncState(state);
        }
      },
    );
  }

  Future<void> _chatRoomGetChatsHandler(
    ChatRoomGetChats event,
    Emitter<ChatRoomState> emit,
  ) async {
    if (state.chatStatus == ELoadingStatus.loading) return;
    emit(state.copyWith(
      status: ELoadingStatus.loading,
      chatStatus: ELoadingStatus.loading,
    ));
    await handleApiRequest(
      () async {
        var res = await chatRepository.getChattingDetail(
          chatRoomId: chatRoomId,
          page: state.page,
        );

        // End scroll
        if (res.data?.isNotEmpty == false) {
          emit(state.copyWith(
            status: ELoadingStatus.error,
            chatStatus: ELoadingStatus.error,
            message: Strings.endOfPage,
          ));
          return;
        }

        List<ChatModel> newList = [];
        newList
          ..addAll(state.chats)
          ..addAll(res.data ?? []);

        emit(state.copyWith(
          status: ELoadingStatus.loaded,
          chatStatus: ELoadingStatus.loaded,
          chats: newList,
          page: state.page + 1,
        ));
        syncState(state);
      },
      state: state,
      emit: emit,
      initAfterError: false,
      finallyCall: () async {
        if (state.status == ELoadingStatus.error) {
          emit(state.copyWith(
            chatStatus: ELoadingStatus.error,
            chatErrMessage: state.message,
          ));
          syncState(state);
        }
      },
    );
  }

  Future<void> _chatRoomSendChatHandler(
    ChatRoomSendChat event,
    Emitter<ChatRoomState> emit,
  ) async {
    if (event.message == Strings.nullStr) return;
    if (!_stompClient.isActive) return;

    _stompClient.send(
      destination: '/pub/chat.talk.$chatRoomId',
      body: json.encode(
        {
          'chatRoomId': chatRoomId,
          "message": event.message,
        },
      ),
    );
  }

  Future<void> _chatRoomInitStompHandler(
    ChatRoomInitStomp event,
    Emitter<ChatRoomState> emit,
  ) async {
    if (state.stompStatus == ELoadingStatus.loading) return;
    emit(state.copyWith(stompStatus: ELoadingStatus.loading));

    // jwt token 불러오기
    final jwt = (await _storage.readAll())[Strings.jwtToken];

    _stompClient = StompClient(
      config: StompConfig(
        url: Configs.instance.wsUrl,
        stompConnectHeaders: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
        webSocketConnectHeaders: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
        },
        beforeConnect: () async {
          print('connect to stomp...');
        },
        onWebSocketError: (e) async {
          print('ws error: $e');
          _stompClient.deactivate();
          add(_StompError('ws error: $e'));
        },
        onStompError: (e) async {
          print('stomp error: $e');
          _stompClient.deactivate();
          add(_StompError('stomp error: ${e.toString()}'));
        },
        onConnect: (stompFrame) async {
          _stompClient.subscribe(
            destination: '/exchange/chat.exchange/room.$chatRoomId',
            callback: (frame) {
              List<dynamic>? result = json.decode(frame.body!);
              print(result);
            },
          );
          add(_StompLoaded());
        },
      ),
    );
    _stompClient.activate();
  }

  Future<void> __stompErrorHandler(
    _StompError event,
    Emitter<ChatRoomState> emit,
  ) async {
    emit(state.copyWith(
      stompStatus: ELoadingStatus.error,
      stompErrMessage: event.message,
    ));
  }

  Future<void> __stompLoadedHandler(
    _StompLoaded event,
    Emitter<ChatRoomState> emit,
  ) async {
    emit(state.copyWith(
      stompStatus: ELoadingStatus.loaded,
    ));
  }
}
