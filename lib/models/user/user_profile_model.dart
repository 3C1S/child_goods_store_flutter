import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

@freezed
class UserProfileModel with _$UserProfileModel {
  factory UserProfileModel({
    int? userId,
    String? nickName,
    String? introduce,
    String? profileImg,
    int? followNum,
    int? followingNum,
    bool? isFollowed,
    double? averageStars,
    DateTime? createdAt,
  }) = _UserProfileModel;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);
}
