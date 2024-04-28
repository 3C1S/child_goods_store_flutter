import 'package:bloc/bloc.dart';
import 'package:child_goods_store_flutter/blocs/together/detail/together_detail_event.dart';
import 'package:child_goods_store_flutter/blocs/together/detail/together_detail_state.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/repositories/interface/together_repository_interface.dart';

class TogetherDetailBloc extends Bloc<TogetherDetailEvent, TogetherDetailState>
    with DioExceptionHandlerMixin {
  final ITogetherRepository togetherRepository;
  final int togetherId;

  TogetherDetailBloc({
    required this.togetherRepository,
    required this.togetherId,
  }) : super(const TogetherDetailState.init()) {
    on<TogetherDetailGet>(_togetherDetailGetHandler);
    on<TogetherDetailChangeHeart>(_togetherDetailChangeHeartHandler);

    add(TogetherDetailGet());
  }

  Future<void> _togetherDetailGetHandler(
    TogetherDetailGet event,
    Emitter<TogetherDetailState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading &&
        state.togetherStatus == ELoadingStatus.loading) return;

    emit(state.copyWith(
      status: ELoadingStatus.loading,
      togetherStatus: ELoadingStatus.loading,
    ));
    await handleApiRequest(
      () async {
        var res = await togetherRepository.getTogether(
          togetherId: togetherId,
        );

        emit(state.copyWith(
          status: ELoadingStatus.loaded,
          togetherStatus: ELoadingStatus.loaded,
          together: res.data,
        ));
      },
      state: state,
      emit: emit,
      initAfterError: false,
    );
  }

  Future<void> _togetherDetailChangeHeartHandler(
    TogetherDetailChangeHeart event,
    Emitter<TogetherDetailState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading &&
        state.heartStatus == ELoadingStatus.loading) return;

    bool prevState = state.together?.togetherHeart ?? false;

    // on event -> change
    emit(state.copyWith(
      together: state.together?.copyWith(
        togetherHeart: !prevState,
      ),
      status: ELoadingStatus.loading,
      heartStatus: ELoadingStatus.loading,
    ));
    await handleApiRequest(
      () async {
        if (prevState) {
          await togetherRepository.deleteTogetherHeart(
            togetherId: togetherId,
          );
        } else {
          await togetherRepository.postTogetherHeart(
            togetherId: togetherId,
          );
        }
        // on success -> keep state
        emit(state.copyWith(
          status: ELoadingStatus.loaded,
          heartStatus: ELoadingStatus.loaded,
        ));
      },
      state: state,
      emit: emit,
      initAfterError: false,
      finallyCall: () async {
        // on error -> rollback
        if (state.status == ELoadingStatus.error &&
            state.heartStatus == ELoadingStatus.loading) {
          emit(state.copyWith(
            status: ELoadingStatus.init,
            heartStatus: ELoadingStatus.init,
            together: state.together?.copyWith(
              togetherHeart: prevState,
            ),
          ));
        } else {
          emit(state.copyWith(
            status: ELoadingStatus.init,
            heartStatus: ELoadingStatus.init,
          ));
        }
      },
    );
  }
}
