import 'package:child_goods_store_flutter/models/user/user_profile_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
class ChatModel with _$ChatModel {
  factory ChatModel({
    UserProfileModel? user,
    String? message,
    bool? isLeader,
    DateTime? createdAt,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}
