import 'package:child_goods_store_flutter/blocs/auth/auth_bloc_singleton.dart';
import 'package:child_goods_store_flutter/blocs/profile/profile_event.dart';
import 'package:child_goods_store_flutter/blocs/profile/profile_state.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/models/user/user_profile_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/user_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>
    with DioExceptionHandlerMixin {
  final IUserRepository userRepository;
  final int userId;

  ProfileBloc({
    required this.userRepository,
    required this.userId,
  }) : super(const ProfileState.init()) {
    on<ProfileGet>(_profileGetHandler);
    on<ProfileChangeFollow>(_profileChangeFollowHandler);

    add(ProfileGet());
  }

  Future<void> _profileGetHandler(
    ProfileGet event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading &&
        state.profileStatus == ELoadingStatus.loading) return;

    emit(state.copyWith(
      status: ELoadingStatus.loading,
      profileStatus: ELoadingStatus.loading,
    ));
    await handleApiRequest(
      () async {
        ResModel<UserProfileModel>? res;
        if (userId == AuthBlocSingleton.bloc.state.user?.userId) {
          res = await userRepository.getMyProfile();
        } else {
          res = await userRepository.getUserProfile(userId: userId);
        }

        emit(state.copyWith(
          status: ELoadingStatus.loaded,
          profileStatus: ELoadingStatus.loaded,
          userProfile: res.data,
        ));
      },
      state: state,
      emit: emit,
      initAfterError: false,
    );
  }

  Future<void> _profileChangeFollowHandler(
    ProfileChangeFollow event,
    Emitter<ProfileState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading &&
        state.followStatus == ELoadingStatus.loading) return;

    bool prevState = state.userProfile?.isFollowed ?? false;

    // on event -> change
    emit(state.copyWith(
      userProfile: state.userProfile?.copyWith(
        isFollowed: !prevState,
      ),
      status: ELoadingStatus.loading,
      followStatus: ELoadingStatus.loading,
    ));
    await handleApiRequest(
      () async {
        if (prevState) {
          await userRepository.deleteUserFollow(
            followId: userId,
          );
        } else {
          await userRepository.postUserFollow(
            followId: userId,
          );
        }
        // on success -> keep state
        emit(state.copyWith(
          status: ELoadingStatus.loaded,
          followStatus: ELoadingStatus.loaded,
        ));
      },
      state: state,
      emit: emit,
      initAfterError: false,
      finallyCall: () async {
        // on error -> rollback
        if (state.status == ELoadingStatus.error &&
            state.followStatus == ELoadingStatus.loading) {
          emit(state.copyWith(
            status: ELoadingStatus.init,
            followStatus: ELoadingStatus.init,
            userProfile: state.userProfile?.copyWith(
              isFollowed: prevState,
            ),
          ));
        } else {
          emit(state.copyWith(
            status: ELoadingStatus.init,
            followStatus: ELoadingStatus.init,
          ));
        }
      },
    );
  }
}
