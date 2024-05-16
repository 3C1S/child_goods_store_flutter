import 'package:child_goods_store_flutter/blocs/chat/chat_event.dart';
import 'package:child_goods_store_flutter/blocs/chat/chat_state.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/repositories/interface/chat_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState>
    with DioExceptionHandlerMixin {
  final IChatRepository chatRepository;

  ChatBloc({
    required this.chatRepository,
  }) : super(const ChatState.init()) {
    on<ChatGetChatRooms>(_chatGetChatRoomsHandler);

    add(ChatGetChatRooms());
  }

  Future<void> _chatGetChatRoomsHandler(
    ChatGetChatRooms event,
    Emitter<ChatState> emit,
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
