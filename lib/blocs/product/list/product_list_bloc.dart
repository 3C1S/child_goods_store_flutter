import 'package:bloc/bloc.dart';
import 'package:child_goods_store_flutter/blocs/product/list/product_list_event.dart';
import 'package:child_goods_store_flutter/blocs/product/list/product_list_state.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/enums/sub_category.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/models/product/product_preview_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/product_repository_interfave.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState>
    with DioExceptionHandlerMixin {
  final IProductRepository productRepository;

  ProductListBloc({
    required this.productRepository,
  }) : super(const ProductListState.init()) {
    on<ProductListGet>(_productListGetHandler);
    on<ProductListChangeMainCat>(_productListChangeMainCatHandler);
    on<ProductListChangeSubCat>(_productListChangeSubCatHandler);
    on<ProductListChangeRegion>(_productListChangeRegionHandler);
    on<ProductListChangeAgeFilter>(_productListChangeAgeFilterHandler);
    on<ProductListChangePriceFilter>(_productListChangePriceFilterHandler);
    on<ProductListApplyFilter>(_productListApplyFilterHandler);

    add(ProductListGet());
  }

  Future<void> _productListGetHandler(
    ProductListGet event,
    Emitter<ProductListState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;

    await handleApiRequest(
      () async {
        emit(state.copyWith(
          status: ELoadingStatus.loading,
          applyFilter: true,
        ));

        var res = await productRepository.getProductList(
          region: state.region,
          mainCategory: state.mainCategory,
          subCategory: state.subCategory,
          age: state.age,
          minPrice: state.minPrice == ProductListState.MIN_PRICE
              ? null
              : state.minPrice,
          maxPrice: state.maxPrice == ProductListState.MAX_PRICE
              ? null
              : state.maxPrice,
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
          ..addAll(state.products)
          ..addAll(res.data ?? []);

        emit(state.copyWith(
          status: ELoadingStatus.loaded,
          products: newList,
          page: state.page + 1,
        ));
      },
      state: state,
      emit: emit,
      initAfterError: false,
    );
  }

  Future<void> _productListChangeMainCatHandler(
    ProductListChangeMainCat event,
    Emitter<ProductListState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;
    if (state.mainCategory == event.mainCategory) return;

    if (event.reset == true) {
      emit(state.copyWith(
        resetMain: true,
        resetSub: true,
        products: const [],
        page: 0,
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
        products: [],
      ));
    }

    add(ProductListGet());
  }

  Future<void> _productListChangeSubCatHandler(
    ProductListChangeSubCat event,
    Emitter<ProductListState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;
    if (state.subCategory == event.subCategory) return;

    emit(state.copyWith(
      subCategory: event.subCategory,
      products: const [],
      page: 0,
    ));

    add(ProductListGet());
  }

  Future<void> _productListChangeRegionHandler(
    ProductListChangeRegion event,
    Emitter<ProductListState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;
    if (state.region == event.region) return;

    emit(state.copyWith(
      region: event.region,
      products: const [],
      page: 0,
    ));

    add(ProductListGet());
  }

  Future<void> _productListChangeAgeFilterHandler(
    ProductListChangeAgeFilter event,
    Emitter<ProductListState> emit,
  ) async {
    if (state.age == event.age) return;

    emit(state.copyWith(
      age: event.age,
      resetAge: event.reset,
      applyFilter: false,
    ));
  }

  Future<void> _productListChangePriceFilterHandler(
    ProductListChangePriceFilter event,
    Emitter<ProductListState> emit,
  ) async {
    emit(state.copyWith(
      minPrice: event.minPrice,
      maxPrice: event.maxPrice,
      applyFilter: false,
    ));
  }

  Future<void> _productListApplyFilterHandler(
    ProductListApplyFilter event,
    Emitter<ProductListState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;
    if (state.applyFilter) return;

    emit(state.copyWith(
      applyFilter: true,
      products: const [],
      page: 0,
    ));

    add(ProductListGet());
  }
}
