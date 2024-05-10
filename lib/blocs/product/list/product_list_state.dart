import 'package:child_goods_store_flutter/blocs/abs_bloc_state.dart';
import 'package:child_goods_store_flutter/enums/child_age.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/enums/main_category.dart';
import 'package:child_goods_store_flutter/enums/search_range.dart';
import 'package:child_goods_store_flutter/enums/sub_category.dart';
import 'package:child_goods_store_flutter/models/product/product_preview_model.dart';

class ProductListState extends BlocState {
  // ignore: constant_identifier_names
  static const int MIN_PRICE = 0;
  // ignore: constant_identifier_names
  static const int MAX_PRICE = 200000;

  final EMainCategory? mainCategory;
  final ESubCategory? subCategory;
  final ESearchRange region;
  final EChildAge? age;
  final int minPrice;
  final int maxPrice;
  final bool applyFilter;
  final List<ProductPreviewModel> products;
  final int page;

  const ProductListState({
    this.mainCategory,
    this.subCategory,
    required this.region,
    this.age,
    required this.minPrice,
    required this.maxPrice,
    required this.applyFilter,
    required this.products,
    required this.page,
    required super.status,
    super.message,
  });

  const ProductListState.init()
      : mainCategory = null,
        subCategory = null,
        region = ESearchRange.myRegion,
        age = null,
        minPrice = MIN_PRICE,
        maxPrice = MAX_PRICE,
        applyFilter = true,
        products = const [],
        page = 0,
        super(
          status: ELoadingStatus.init,
          message: null,
        );

  @override
  ProductListState copyWith({
    ELoadingStatus? status,
    String? message,
    EMainCategory? mainCategory,
    bool? resetMain,
    ESubCategory? subCategory,
    bool? resetSub,
    ESearchRange? region,
    EChildAge? age,
    bool? resetAge,
    int? minPrice,
    int? maxPrice,
    bool? applyFilter,
    List<ProductPreviewModel>? products,
    int? page,
  }) =>
      ProductListState(
        status: status ?? this.status,
        message: message ?? this.message,
        mainCategory:
            resetMain == true ? null : (mainCategory ?? this.mainCategory),
        subCategory:
            resetSub == true ? null : (subCategory ?? this.subCategory),
        region: region ?? this.region,
        age: resetAge == true ? null : (age ?? this.age),
        minPrice: minPrice ?? this.minPrice,
        maxPrice: maxPrice ?? this.maxPrice,
        applyFilter: applyFilter ?? this.applyFilter,
        products: products ?? this.products,
        page: page ?? this.page,
      );

  @override
  List<Object?> get props => [
        status,
        message,
        mainCategory,
        subCategory,
        region,
        age,
        minPrice,
        maxPrice,
        applyFilter,
        products,
        page,
      ];
}
