import 'package:child_goods_store_flutter/blocs/chat/list/chat_list_event.dart';
import 'package:child_goods_store_flutter/blocs/chat/list/chat_list_state.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/repositories/interface/chat_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState>
    with DioExceptionHandlerMixin {
  final IChatRepository chatRepository;

  ChatListBloc({
    required this.chatRepository,
  }) : super(const ChatListState.init()) {
    on<ChatListGetChatRooms>(_chatListGetChatRoomsHandler);

    add(ChatListGetChatRooms());
  }

  Future<void> _chatListGetChatRoomsHandler(
    ChatListGetChatRooms event,
    Emitter<ChatListState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;

    emit(state.copyWith(status: ELoadingStatus.loading));
    await handleApiRequest(
      () async {
        var res = await chatRepository.getChatting();

        emit(state.copyWith(
          status: ELoadingStatus.loaded,
          chatRooms: res.data,
        ));
      },
      state: state,
      emit: emit,
      initAfterError: false,
    );
  }
}
