import 'package:child_goods_store_flutter/enums/chat_item_type.dart';
import 'package:child_goods_store_flutter/models/chat/chat_model.dart';
import 'package:child_goods_store_flutter/models/chat/chat_room_model.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';

abstract interface class IChatRepository {
  ///
  /// API 301
  Future<ResModel<List<ChatRoomModel>>> getChatting();

  ///
  /// API 302
  Future<ResModel<List<ChatModel>>> getChattingDetail({
    required int chatRoomId,
    required int page,
    int size = 20,
  });

  ///
  /// API 303
  // Stream<void> socketChatting({
  //   required int chatRoomId,
  //   required String message,
  // });

  /// API 304
  Future<ResModel<int>> postChattingRoom({
    required int id,
    required EChatItemType category,
  });
}
