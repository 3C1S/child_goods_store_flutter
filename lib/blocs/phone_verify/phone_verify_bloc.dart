import 'package:child_goods_store_flutter/blocs/phone_verify/phone_verify_event.dart';
import 'package:child_goods_store_flutter/blocs/phone_verify/phone_verify_state.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/repositories/interface/auth_repository_interfece.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneVerifyBloc extends Bloc<PhoneVerifyEvent, PhoneVerifyState>
    with DioExceptionHandlerMixin {
  final IAuthRepository authRepository;

  PhoneVerifyBloc({
    required this.authRepository,
  }) : super(const PhoneVerifyState.init()) {
    on<PhoneVerifyChangeNum>(_phoneVerifyChangeNumHandler);
    on<PhoneVerifyChangeCode>(_phoneVerifyChangeCodeHandler);
    on<PhoneVerifySubmit>(_phoneVerifySubmitHandler);
  }

  Future<void> _phoneVerifyChangeNumHandler(
    PhoneVerifyChangeNum event,
    Emitter<PhoneVerifyState> emit,
  ) async {
    emit(state.copyWith(
      phoneNum: event.phoneNum,
    ));
  }

  Future<void> _phoneVerifyChangeCodeHandler(
    PhoneVerifyChangeCode event,
    Emitter<PhoneVerifyState> emit,
  ) async {
    emit(state.copyWith(
      code: event.code,
    ));
  }

  Future<void> _phoneVerifySubmitHandler(
    PhoneVerifySubmit event,
    Emitter<PhoneVerifyState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;

    await handleApiRequest(
      () async {
        emit(state.copyWith(status: ELoadingStatus.loading));

        if (state.phoneStatus != ELoadingStatus.loaded) {
          // Validate
          if (state.phoneNum == null || state.phoneNum == Strings.nullStr) {
            emit(state.copyWith(
              status: ELoadingStatus.error,
              message: '핸드폰 번호를 입력해주세요.',
            ));
            emit(state.copyWith(status: ELoadingStatus.init));
            return;
          }
          // await authRepository.postPhoneSend(phoneNum: state.phoneNum!);
          emit(state.copyWith(
            status: ELoadingStatus.loaded,
            phoneStatus: ELoadingStatus.loaded,
          ));
        } else {
          // Validate
          if (state.code == null || state.code == Strings.nullStr) {
            emit(state.copyWith(
              status: ELoadingStatus.error,
              message: '인증번호를 입력해주세요.',
            ));
            emit(state.copyWith(status: ELoadingStatus.init));
            return;
          }
          // await authRepository.postPhoneVerify(code: state.code!);
          emit(state.copyWith(
            status: ELoadingStatus.loaded,
            codeStatus: ELoadingStatus.loaded,
          ));
        }
      },
      emit: emit,
      state: state,
    );
  }
}
