import 'package:child_goods_store_flutter/blocs/abs_bloc_state.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/models/chat/chat_room_model.dart';

class ChatState extends BlocState {
  final List<ChatRoomModel> chatRooms;

  const ChatState({
    required this.chatRooms,
    required super.status,
    super.message,
  });

  const ChatState.init()
      : chatRooms = const [],
        super(
          status: ELoadingStatus.init,
          message: null,
        );

  @override
  ChatState copyWith({
    List<ChatRoomModel>? chatRooms,
    ELoadingStatus? status,
    String? message,
  }) =>
      ChatState(
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
