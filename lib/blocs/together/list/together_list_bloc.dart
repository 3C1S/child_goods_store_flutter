import 'package:child_goods_store_flutter/blocs/together/list/together_list_event.dart';
import 'package:child_goods_store_flutter/blocs/together/list/together_list_state.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/enums/sub_category.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/models/together/together_preview_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/together_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TogetherListBloc extends Bloc<TogetherListEvent, TogetherListState>
    with DioExceptionHandlerMixin {
  final ITogetherRepository togetherRepository;

  TogetherListBloc({
    required this.togetherRepository,
  }) : super(const TogetherListState.init()) {
    on<TogetherListGet>(_togetherListGetHandler);
    on<TogetherListChangeMainCat>(_togetherListChangeMainCatHandler);
    on<TogetherListChangeSubCat>(_togetherListChangeSubCatHandler);
    on<TogetherListChangeRegion>(_togetherListChangeRegionHandler);
    on<TogetherListChangeAgeFilter>(_togetherListChangeAgeFilterHandler);
    on<TogetherListApplyFilter>(_togetherListApplyFilterHandler);

    add(TogetherListGet());
  }

  Future<void> _togetherListGetHandler(
    TogetherListGet event,
    Emitter<TogetherListState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;

    await handleApiRequest(
      () async {
        emit(state.copyWith(
          status: ELoadingStatus.loading,
          applyFilter: true,
        ));

        var res = await togetherRepository.getTogetherList(
          region: state.region,
          mainCategory: state.mainCategory,
          subCategory: state.subCategory,
          age: state.age,
          page: state.page,
        );

        // End scroll
        if (res.data?.isNotEmpty == false) {
          emit(state.copyWith(
            status: ELoadingStatus.error,
            message: Strings.endOfPage,
          ));
          return;
        }

        List<TogetherPreviewModel> newList = [];
        newList
          ..addAll(state.togethers)
          ..addAll(res.data ?? []);

        emit(state.copyWith(
          status: ELoadingStatus.loaded,
          togethers: newList,
          page: state.page + 1,
        ));
      },
      state: state,
      emit: emit,
      initAfterError: false,
    );
  }

  Future<void> _togetherListChangeMainCatHandler(
    TogetherListChangeMainCat event,
    Emitter<TogetherListState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;
    if (state.mainCategory == event.mainCategory) return;

    if (event.reset == true) {
      emit(state.copyWith(
        resetMain: true,
        resetSub: true,
        togethers: const [],
      ));
    } else {
      late ESubCategory subCat;
      for (var sub in ESubCategory.values) {
        if (sub.mainCategory == event.mainCategory) {
          subCat = sub;
          break;
        }
      }

      emit(state.copyWith(
        mainCategory: event.mainCategory,
        subCategory: subCat,
        togethers: [],
      ));
    }

    add(TogetherListGet());
  }

  Future<void> _togetherListChangeSubCatHandler(
    TogetherListChangeSubCat event,
    Emitter<TogetherListState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;
    if (state.subCategory == event.subCategory) return;

    emit(state.copyWith(
      subCategory: event.subCategory,
      togethers: [],
    ));

    add(TogetherListGet());
  }

  Future<void> _togetherListChangeRegionHandler(
    TogetherListChangeRegion event,
    Emitter<TogetherListState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;
    if (state.region == event.region) return;

    emit(state.copyWith(
      region: event.region,
      togethers: [],
    ));

    add(TogetherListGet());
  }

  Future<void> _togetherListChangeAgeFilterHandler(
    TogetherListChangeAgeFilter event,
    Emitter<TogetherListState> emit,
  ) async {
    if (state.age == event.age) return;

    emit(state.copyWith(
      age: event.age,
      resetAge: event.reset,
      applyFilter: false,
    ));
  }

  Future<void> _togetherListApplyFilterHandler(
    TogetherListApplyFilter event,
    Emitter<TogetherListState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;
    if (state.applyFilter) return;

    emit(state.copyWith(
      applyFilter: true,
      togethers: const [],
    ));

    add(TogetherListGet());
  }
}
