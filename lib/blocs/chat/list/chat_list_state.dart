import 'package:child_goods_store_flutter/blocs/abs_bloc_state.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/models/chat/chat_room_model.dart';

class ChatListState extends BlocState {
  final List<ChatRoomModel> chatRooms;

  const ChatListState({
    required this.chatRooms,
    required super.status,
    super.message,
  });

  const ChatListState.init()
      : chatRooms = const [],
        super(
          status: ELoadingStatus.init,
          message: null,
        );

  @override
  ChatListState copyWith({
    List<ChatRoomModel>? chatRooms,
    ELoadingStatus? status,
    String? message,
  }) =>
      ChatListState(
        chatRooms: chatRooms ?? this.chatRooms,
        status: status ?? this.status,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        chatRooms,
        status,
        message,
      ];
}
