import 'package:child_goods_store_flutter/enums/chat_item_type.dart';
import 'package:child_goods_store_flutter/models/chat/chat_model.dart';
import 'package:child_goods_store_flutter/models/chat/chat_room_model.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/models/review/review_model.dart';
import 'package:child_goods_store_flutter/models/user/user_profile_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/chat_repository_interface.dart';
import 'package:child_goods_store_flutter/utils/mock_dio_exception.dart';

class ChatRepositoryImplDev implements IChatRepository {
  ///
  /// API 301
  @override
  Future<ResModel<List<ChatRoomModel>>> getChatting() async {
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<List<ChatRoomModel>>(
      code: 1000,
      data: [
        for (int i = 0; i < 10; i++) ...[
          ChatRoomModel(
            chatRoomId: 2 * i + 1,
            category: EChatItemType.product,
            id: 2 * i + 1,
            productName: 'Example product',
            participantsNum: 2,
            price: 10000,
            createdAt: DateTime.now(),
          ),
          ChatRoomModel(
            chatRoomId: 2 * i + 2,
            category: EChatItemType.together,
            id: 2 * i + 2,
            productName: 'Example together',
            productImage:
                'https://lh4.googleusercontent.com/on7Yj1rShJRRBy88rTmptLVzMI4gEBDBabmSMv-GGsPIo5umfS5dpSJp3b4EoqKtnxdOYXeHSyct6m2fLYKckaikrUJn91PNWkIYXtkrCljcvdEnGdf_nQM5Qw6bQY4q6jvbWiBcC3WPTIcDS_lizv3R25oVAF_H0PNzvRo7JivPSiZR',
            participantsNum: 5,
            price: 100000,
            unitPrice: 2000,
            endDate: DateTime.now().add(const Duration(days: 10)),
            message: '안녕하세요!',
            createdAt: DateTime.now(),
          ),
        ],
      ],
    ).toJson(
      (chatRooms) => chatRooms.map((chatRoom) => chatRoom.toJson()).toList(),
    );

    var res = ResModel<List<ChatRoomModel>>.fromJson(
      resTmp,
      (json) => (json as List<dynamic>)
          .map((chatRoom) => ChatRoomModel.fromJson(chatRoom))
          .toList(),
    );

    return res;
  }

  ///
  /// API 302
  @override
  Future<ResModel<List<ChatModel>>> getChattingDetail({
    required int chatRoomId,
    required int page,
    int size = 20,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<List<ChatModel>>(
      code: 1000,
      data: [
        for (var id in List.generate(5, (i) => i + 1)) ...[
          for (var chat in List.generate(5, (i) => i + 1))
            ChatModel(
              user: UserProfileModel(
                userId: id,
                nickName: 'User $id',
                profileImg: id % 4 == 0
                    ? null
                    : 'https://lh4.googleusercontent.com/on7Yj1rShJRRBy88rTmptLVzMI4gEBDBabmSMv-GGsPIo5umfS5dpSJp3b4EoqKtnxdOYXeHSyct6m2fLYKckaikrUJn91PNWkIYXtkrCljcvdEnGdf_nQM5Qw6bQY4q6jvbWiBcC3WPTIcDS_lizv3R25oVAF_H0PNzvRo7JivPSiZR',
              ),
              message: "message ${page * 100 + id * 10 + chat}",
              isLeader: id == 2 ? true : false,
              createdAt: DateTime.now().subtract(
                Duration(seconds: (page * 100 + id * 10 + chat) * 10),
              ),
            ),
        ],
      ],
    ).toJson(
      (chatRooms) => chatRooms.map((chatRoom) => chatRoom.toJson()).toList(),
    );

    var res = ResModel<List<ChatModel>>.fromJson(
      resTmp,
      (json) => (json as List<dynamic>)
          .map((chatRoom) => ChatModel.fromJson(chatRoom))
          .toList(),
    );

    return res;
  }

  ///
  /// API 303
  // @override
  // Stream<void> socketChatting({
  //   required int chatRoomId,
  //   required String message,
  // }) async {}

  /// API 304
  @override
  Future<ResModel<int>> postChattingRoom({
    required int id,
    required EChatItemType category,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<int>(
      code: 1000,
      data: 1,
    ).toJson(
      (chatRoomId) => chatRoomId,
    );

    var res = ResModel<int>.fromJson(
      resTmp,
      (json) => json as int,
    );

    return res;
  }

  ///
  /// API 305
  @override
  Future<ResModel<ReviewModel>> getItemByChatRoomId({
    required int chatRoomId,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    var resTmp = ResModel<ReviewModel>(
      code: 1000,
      data: ReviewModel(
        id: chatRoomId,
        type: chatRoomId % 2 == 1
            ? EChatItemType.product
            : EChatItemType.together,
      ),
    ).toJson(
      (chatRoomId) => chatRoomId.toJson(),
    );

    var res = ResModel<ReviewModel>.fromJson(
      resTmp,
      (json) => ReviewModel.fromJson(json),
    );

    return res;
  }
}
