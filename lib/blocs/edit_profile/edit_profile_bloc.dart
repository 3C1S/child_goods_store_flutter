import 'package:child_goods_store_flutter/blocs/auth/auth_bloc_singleton.dart';
import 'package:child_goods_store_flutter/blocs/auth/auth_event.dart';
import 'package:child_goods_store_flutter/blocs/edit_profile/edit_profile_event.dart';
import 'package:child_goods_store_flutter/blocs/edit_profile/edit_profile_state.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/http_method.dart';
import 'package:child_goods_store_flutter/enums/image_category.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/models/user/user_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/image_repository_interface.dart';
import 'package:child_goods_store_flutter/repositories/interface/user_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState>
    with DioExceptionHandlerMixin {
  final IUserRepository userRepository;
  final IImageRepository imageRepository;
  final EHttpMethod httpMethod;

  EditProfileBloc({
    required this.userRepository,
    required this.imageRepository,
    required this.httpMethod,
    UserModel? user,
  }) : super(EditProfileState.init(user: user)) {
    on<EditProfileChangeImage>(_editProfileChangeImageHandler);
    on<EditProfileChangeNickName>(_editProfileChangeNickNameHandler);
    on<EditProfileChangeIntroduce>(_editProfileChangeIntroduceHandler);
    // on<EditProfileChangePhoneNum>(_editProfileChangePhoneNumHandler);
    on<EditProfileChangeRegion>(_editProfileChangeRegionHandler);
    on<EditProfileChangeTown>(_editProfileChangeTownHandler);
    on<EditProfileSubmit>(_editProfileSubmitHandler);
  }

  Future<void> _editProfileChangeImageHandler(
    EditProfileChangeImage event,
    Emitter<EditProfileState> emit,
  ) async {
    if (event.image != null) {
      emit(state.copyWith(
        image: event.image,
        removeImage: false,
      ));
    } else {
      emit(state.copyWith(removeImage: true));
    }
  }

  Future<void> _editProfileChangeNickNameHandler(
    EditProfileChangeNickName event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(
      user: state.user.copyWith(
        nickName: event.nickName,
      ),
    ));
  }

  Future<void> _editProfileChangeIntroduceHandler(
    EditProfileChangeIntroduce event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(
      user: state.user.copyWith(
        introduce: event.introduce,
      ),
    ));
  }

  // Future<void> _editProfileChangePhoneNumHandler(
  //   EditProfileChangePhoneNum event,
  //   Emitter<EditProfileState> emit,
  // ) async {
  //   emit(state.copyWith(
  //     user: state.user.copyWith(
  //       phoneNum: event.phoneNum,
  //     ),
  //   ));
  // }

  Future<void> _editProfileChangeRegionHandler(
    EditProfileChangeRegion event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(
      user: state.user.copyWith(
        region: event.region,
        town: Strings.nullStr,
      ),
    ));
  }

  Future<void> _editProfileChangeTownHandler(
    EditProfileChangeTown event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(state.copyWith(
      user: state.user.copyWith(
        town: event.town,
      ),
    ));
  }

  Future<void> _editProfileSubmitHandler(
    EditProfileSubmit event,
    Emitter<EditProfileState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;

    // Validate
    if (state.user.nickName == null || state.user.nickName == Strings.nullStr) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '닉네임을 입력해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }
    // if (state.user.phoneNum == null || state.user.phoneNum == Strings.nullStr) {
    //   emit(state.copyWith(
    //     status: ELoadingStatus.error,
    //     message: '핸드폰 인증을 진행해주세요.',
    //   ));
    //   emit(state.copyWith(status: ELoadingStatus.init));
    //   return;
    // }
    if (state.user.region == null || state.user.region == Strings.nullStr) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '내 동네를 설정해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }

    await handleApiRequest(
      () async {
        emit(state.copyWith(status: ELoadingStatus.loading));

        if (!state.removeImage && state.image != null) {
          var res = await imageRepository.postImageList(
            category: EImageCategory.profile,
            images: [state.image!],
          );
          emit(state.copyWith(
            user: state.user.copyWith(
              profileImg: res.data?.first,
            ),
          ));
        }
        if (state.removeImage) {
          emit(state.copyWith(
            user: state.user.copyWith(
              profileImg: Strings.nullStr,
            ),
          ));
        }

        ResModel<UserModel>? res;
        switch (httpMethod) {
          case EHttpMethod.post:
            res = await userRepository.postUser(user: state.user);
            break;
          case EHttpMethod.patch:
            res = await userRepository.patchUser(user: state.user);
            break;
          default:
            break;
        }

        if (res?.data == null) {
          emit(state.copyWith(
            status: ELoadingStatus.error,
            message: '저장에 실패했습니다.',
          ));
          emit(state.copyWith(status: ELoadingStatus.init));
          return;
        }

        AuthBlocSingleton.bloc.add(AuthSetUser(res!.data!));

        emit(state.copyWith(status: ELoadingStatus.loaded));
      },
      state: state,
      emit: emit,
    );
  }
}
