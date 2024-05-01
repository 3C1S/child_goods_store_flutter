import 'package:child_goods_store_flutter/blocs/follow/follow_event.dart';
import 'package:child_goods_store_flutter/blocs/follow/follow_state.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/follow_mode.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/models/user/user_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/user_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState>
    with DioExceptionHandlerMixin {
  final IUserRepository userRepository;
  final int userId;
  final EFollowMode mode;

  FollowBloc({
    required this.userRepository,
    required this.userId,
    required this.mode,
  }) : super(FollowState.init()) {
    on<FollowGet>(_followGetHandler);

    add(FollowGet());
  }

  Future<void> _followGetHandler(
    FollowGet event,
    Emitter<FollowState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;

    emit(state.copyWith(status: ELoadingStatus.loading));
    await handleApiRequest(
      () async {
        ResModel<List<UserModel>>? res;
        switch (mode) {
          case EFollowMode.follower:
            res = await userRepository.getUserFollower(
              userId: userId,
              page: state.page,
            );
            break;
          case EFollowMode.following:
            res = await userRepository.getUserFollowing(
              userId: userId,
              page: state.page,
            );
            break;
        }

        // End scroll
        if (res.data?.isNotEmpty == false) {
          emit(state.copyWith(
            status: ELoadingStatus.error,
            message: Strings.endOfPage,
          ));
          return;
        }

        List<UserModel> newList = [];
        newList
          ..addAll(state.userList)
          ..addAll(res.data ?? []);

        emit(state.copyWith(
          status: ELoadingStatus.loaded,
          userList: newList,
          page: state.page + 1,
        ));
      },
      state: state,
      emit: emit,
      initAfterError: false,
    );
  }
}
