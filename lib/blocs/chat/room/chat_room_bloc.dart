import 'package:child_goods_store_flutter/blocs/chat/room/chat_room_event.dart';
import 'package:child_goods_store_flutter/blocs/chat/room/chat_room_state.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/chat_item_type.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/models/chat/chat_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/chat_repository_interface.dart';
import 'package:child_goods_store_flutter/repositories/interface/product_repository_interfave.dart';
import 'package:child_goods_store_flutter/repositories/interface/together_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState>
    with DioExceptionHandlerMixin {
  final IChatRepository chatRepository;
  final IProductRepository productRepository;
  final ITogetherRepository togetherRepository;
  final int chatRoomId;
  int? id;
  EChatItemType? type;

  ChatRoomBloc({
    required this.chatRepository,
    required this.productRepository,
    required this.togetherRepository,
    required this.chatRoomId,
  }) : super(const ChatRoomState.init()) {
    on<ChatRoomGetItem>(_chatRoomGetItemHandler);
    on<ChatRoomGetChats>(_chatRoomGetChatsHandler);
    on<ChatRoomSendChat>(_chatRoomSendChatHandler);

    add(ChatRoomGetItem());
    add(ChatRoomGetChats());
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
    print('[Chat send] ${event.message}');
  }
}
