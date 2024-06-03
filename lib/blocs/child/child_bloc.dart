import 'package:child_goods_store_flutter/blocs/auth/auth_bloc_singleton.dart';
import 'package:child_goods_store_flutter/blocs/child/child_event.dart';
import 'package:child_goods_store_flutter/blocs/child/child_state.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/models/child/child_model.dart';
import 'package:child_goods_store_flutter/models/product/product_preview_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/child_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChildBloc extends Bloc<ChildEvent, ChildState>
    with DioExceptionHandlerMixin {
  final IChildRepository childRepository;

  ChildBloc({
    required this.childRepository,
  }) : super(const ChildState.init()) {
    on<ChildGetChildren>(_childGetChildrenHandler);
    on<ChildAdd>(_childAddHandler);
    on<ChildEdit>(_childEditHandler);
    on<ChildSelect>(_childSelectHandler);
    on<ChildGetProductList>(_childGetProductListHandler);

    add(ChildGetChildren());
  }

  Future<void> _childGetChildrenHandler(
    ChildGetChildren event,
    Emitter<ChildState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading &&
        state.childListStatus == ELoadingStatus.loading) return;

    emit(state.copyWith(
      status: ELoadingStatus.loading,
      childListStatus: ELoadingStatus.loading,
    ));
    await handleApiRequest(
      () async {
        var res = await childRepository.getChild();

        emit(state.copyWith(
          status: ELoadingStatus.loaded,
          childListStatus: ELoadingStatus.loaded,
          childList: res.data,
        ));

        if (res.data?.isNotEmpty == true) {
          add(ChildSelect(res.data!.first.childId!));
        }
      },
      state: state,
      emit: emit,
      initAfterError: false,
    );
  }

  Future<void> _childSelectHandler(
    ChildSelect event,
    Emitter<ChildState> emit,
  ) async {
    if (state.childList.isEmpty) return;

    var selectedChild = state.childList.firstWhere(
      (child) => child.childId == event.childId,
      orElse: () => ChildModel(childId: -1),
    );

    if (selectedChild.childId != -1) {
      emit(state.copyWith(
        selectedChild: selectedChild,
        productList: [],
      ));
      add(ChildGetProductList());
    } else {
      emit(state.copyWith(
        nullSelectedChild: true,
        productList: [],
      ));
    }
  }

  Future<void> _childAddHandler(
    ChildAdd event,
    Emitter<ChildState> emit,
  ) async {
    List<ChildModel> res = [];
    res
      ..addAll(state.childList)
      ..add(event.child);
    emit(state.copyWith(childList: res));

    add(ChildSelect(event.child.childId!));
  }

  Future<void> _childEditHandler(
    ChildEdit event,
    Emitter<ChildState> emit,
  ) async {
    List<ChildModel> res = [];
    for (var child in state.childList) {
      if (child.childId == event.child.childId) {
        res.add(event.child);
      } else {
        res.add(child);
      }
    }
    emit(state.copyWith(childList: res));

    add(ChildSelect(event.child.childId!));
  }

  Future<void> _childGetProductListHandler(
    ChildGetProductList event,
    Emitter<ChildState> emit,
  ) async {
    if (state.selectedChild?.childId == null) return;
    if (state.status == ELoadingStatus.loading &&
        state.productListStatus == ELoadingStatus.loading) return;

    emit(state.copyWith(
      status: ELoadingStatus.loading,
      productListStatus: ELoadingStatus.loading,
    ));
    await handleApiRequest(
      () async {
        var res = await childRepository.getChildProductList(
          childId: state.selectedChild!.childId!,
          userId: AuthBlocSingleton.bloc.state.user!.userId!,
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

        List<ProductPreviewModel> newList = [];
        newList
          ..addAll(state.productList)
          ..addAll(res.data ?? []);

        emit(state.copyWith(
          status: ELoadingStatus.loaded,
          productListStatus: ELoadingStatus.loaded,
          productList: newList,
          page: state.page + 1,
        ));
      },
      state: state,
      emit: emit,
      initAfterError: false,
    );
  }
}
