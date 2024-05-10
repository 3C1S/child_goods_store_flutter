import 'package:child_goods_store_flutter/blocs/signup/signup_event.dart';
import 'package:child_goods_store_flutter/blocs/signup/signup_state.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/repositories/interface/auth_repository_interfece.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState>
    with DioExceptionHandlerMixin {
  final IAuthRepository authRepository;

  SignupBloc({
    required this.authRepository,
  }) : super(const SignupState.init()) {
    on<SignupChangeEmail>(_signupChangeEmailHandler);
    on<SignupChangePW>(_signupChangePWHandler);
    on<SignupChangePWCheck>(_signupChangePWCheckHandler);
    on<SignupChangeSendCode>(_signupChangeSendCodeHandler);
    on<SignupChangeVerifyCode>(_signupChangeVerifyCodeHandler);
    // on<SignupChangePhoneNum>(_signupChangePhoneNumHandler);
    on<SignupSubmit>(_signupSubmitHandler);
  }

  Future<void> _signupChangeEmailHandler(
    SignupChangeEmail event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(
      email: event.email,
    ));
  }

  Future<void> _signupChangePWHandler(
    SignupChangePW event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(
      password: event.password,
    ));
  }

  Future<void> _signupChangePWCheckHandler(
    SignupChangePWCheck event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(
      passwordCheck: event.passwordCheck,
    ));
  }

  Future<void> _signupChangeSendCodeHandler(
    SignupChangeSendCode event,
    Emitter<SignupState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;
    // Validate
    if (!_emailValidate(state.email)) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '이메일을 정확히 입력해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }

    emit(state.copyWith(
      status: ELoadingStatus.loading,
      sendStatus: ELoadingStatus.loading,
    ));
    await handleApiRequest(
      () async {
        await authRepository.postEmailSend(
          email: state.email!,
        );

        emit(state.copyWith(
          status: ELoadingStatus.loaded,
          sendStatus: ELoadingStatus.loaded,
        ));
      },
      emit: emit,
      state: state,
      finallyCall: () async {
        emit(state.copyWith(
          status: ELoadingStatus.init,
          sendStatus: ELoadingStatus.init,
        ));
      },
    );
  }

  Future<void> _signupChangeVerifyCodeHandler(
    SignupChangeVerifyCode event,
    Emitter<SignupState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;
    // Validate
    if (event.code == Strings.nullStr) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '인증번호를 입력해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }

    emit(state.copyWith(
      status: ELoadingStatus.loading,
      verifyStatus: ELoadingStatus.loading,
    ));
    await handleApiRequest(
      () async {
        await authRepository.postEmailVerify(
          email: state.email!,
          code: event.code,
        );

        emit(state.copyWith(
          status: ELoadingStatus.loaded,
          verifyStatus: ELoadingStatus.loaded,
          verifiedEmail: state.email,
        ));
        emit(state.copyWith(
          status: ELoadingStatus.init,
          verifyStatus: ELoadingStatus.init,
        ));
      },
      emit: emit,
      state: state,
      finallyCall: () async {
        emit(state.copyWith(
          status: ELoadingStatus.init,
          verifyStatus: ELoadingStatus.init,
        ));
      },
    );
  }

  // @Deprecated('phone verify is deprecated')
  // Future<void> _signupChangePhoneNumHandler(
  //   SignupChangePhoneNum event,
  //   Emitter<SignupState> emit,
  // ) async {
  //   emit(state.copyWith(
  //     phoneNum: event.phoneNum,
  //   ));
  // }

  Future<void> _signupSubmitHandler(
    SignupSubmit event,
    Emitter<SignupState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;

    // Validate
    if (!_emailValidate(state.email)) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '이메일을 정확히 입력해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }
    if (state.password == null || state.password == Strings.nullStr) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '비밀번호를 입력해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }
    if (state.password != state.passwordCheck) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '비밀번호를 다시 확인해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }
    if (state.email != state.verifiedEmail) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '이메일을 인증해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }
    // @Deprecated('phone verify is deprecated')
    // if (state.phoneNum == null || state.phoneNum == Strings.nullStr) {
    //   emit(state.copyWith(
    //     status: ELoadingStatus.error,
    //     message: '핸드폰 인증을 진행해주세요.',
    //   ));
    //   emit(state.copyWith(status: ELoadingStatus.init));
    //   return;
    // }

    emit(state.copyWith(
      status: ELoadingStatus.loading,
      submitStatus: ELoadingStatus.loading,
    ));
    await handleApiRequest(
      () async {
        await authRepository.postSignup(
          email: state.email!,
          password: state.password!,
          // phoneNum: state.phoneNum!,
        );
        emit(state.copyWith(
          status: ELoadingStatus.loaded,
          submitStatus: ELoadingStatus.loaded,
        ));
      },
      emit: emit,
      state: state,
      finallyCall: () async {
        emit(state.copyWith(
          status: ELoadingStatus.init,
          submitStatus: ELoadingStatus.init,
        ));
      },
    );
  }

  bool _emailValidate(String? value) {
    if (value == null) return false;
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value.isNotEmpty == true && !regex.hasMatch(value) ? false : true;
  }
}
