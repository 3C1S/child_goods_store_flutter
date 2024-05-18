abstract class ChatRoomEvent {}

class ChatRoomGetItem extends ChatRoomEvent {}

class ChatRoomGetChats extends ChatRoomEvent {}

class ChatRoomSendChat extends ChatRoomEvent {
  final String message;

  ChatRoomSendChat(this.message);
}
