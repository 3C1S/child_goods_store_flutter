import 'package:child_goods_store_flutter/blocs/abs_bloc_state.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/models/user/user_model.dart';

class FollowState extends BlocState {
  final List<UserModel> userList;
  final int page;

  const FollowState({
    required this.userList,
    required this.page,
    required super.status,
    super.message,
  });

  FollowState.init()
      : userList = [],
        page = 0,
        super(
          status: ELoadingStatus.init,
          message: null,
        );

  @override
  FollowState copyWith({
    List<UserModel>? userList,
    int? page,
    ELoadingStatus? status,
    String? message,
  }) =>
      FollowState(
        userList: userList ?? this.userList,
        page: page ?? this.page,
        status: status ?? this.status,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        userList,
        page,
        status,
        message,
      ];
}
