import 'package:child_goods_store_flutter/blocs/abs_bloc_state.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin DioExceptionHandlerMixin {
  BlocState? _state;

  /// ### **NOTICE**
  ///
  /// [state] \
  /// 인자로 받는 state는 [handleApiRequest]가 호출될 당시의 state를 가짐에 주의합시다.
  ///
  /// [initAfterError] \
  /// `status == ELoadingStatus.error` 상태를 유지해야 하는 경우에 `false`로 사용합니다.
  ///
  /// **Example**
  /// - 데이터를 post, patch 하는 화면이 아닌, get 하는 화면에서 에러시 에러 메세지를 화면에 직접 뿌려줘야 할 때
  /// - 무한 스크롤로 페이징 기능 수행할 때
  Future<void> handleApiRequest(
    Future<void> Function() apiCall, {
    Future<void> Function()? finallyCall,
    required BlocState state,
    required Emitter<BlocState> emit,
    bool initAfterError = true,
  }) async {
    syncState(state);
    try {
      await apiCall();
    } on DioException catch (e) {
      var error = e.error as ResModel<void>;
      emit(_state!.copyWith(
        status: ELoadingStatus.error,
        message: '[${error.code}] ${error.message ?? Strings.unknownFail}',
      ));
      debugPrint('[DioExceptionHandlerMixin/DioException] ${error.message}');
      if (initAfterError) {
        emit(_state!.copyWith(status: ELoadingStatus.init));
      }
    } catch (e, s) {
      emit(_state!.copyWith(
        status: ELoadingStatus.error,
        message: '[5001] ${e.toString().replaceAll('Exception: ', '')}',
      ));
      debugPrint('[DioExceptionHandlerMixin/Exception] ${e.toString()}');
      debugPrintStack(stackTrace: s);
      if (initAfterError) {
        emit(_state!.copyWith(status: ELoadingStatus.init));
      }
    } finally {
      await finallyCall?.call();
    }
  }

  /// ### **NOTICE**
  ///
  /// 병렬적으로 비동기에 의해 상태가 변하는 경우 [handleApiRequest] 호출시 넘겨진
  /// [state]를 기반으로 상태가 업데이트 됩니다. \
  /// 이를 방지하려면 [syncState]를 호출하여 원하는 시각에서의 상태로 동기화 할 수 있습니다.
  ///
  /// 일반적으로 로딩이 완료된 후 [emit] 호출 이후에 호출하는 게 좋습니다.
  void syncState(BlocState state) {
    _state = state;
  }
}
