import 'package:child_goods_store_flutter/blocs/abs_bloc_state.dart';
import 'package:child_goods_store_flutter/enums/child_age.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/enums/main_category.dart';
import 'package:child_goods_store_flutter/enums/search_range.dart';
import 'package:child_goods_store_flutter/enums/sub_category.dart';
import 'package:child_goods_store_flutter/models/together/together_preview_model.dart';

class TogetherListState extends BlocState {
  final EMainCategory? mainCategory;
  final ESubCategory? subCategory;
  final ESearchRange region;
  final EChildAge? age;
  final bool applyFilter;
  final List<TogetherPreviewModel> togethers;
  final int page;

  const TogetherListState({
    this.mainCategory,
    this.subCategory,
    required this.region,
    this.age,
    required this.applyFilter,
    required this.togethers,
    required this.page,
    required super.status,
    super.message,
  });

  const TogetherListState.init()
      : mainCategory = null,
        subCategory = null,
        region = ESearchRange.myRegion,
        age = null,
        applyFilter = true,
        togethers = const [],
        page = 0,
        super(
          status: ELoadingStatus.init,
          message: null,
        );

  @override
  TogetherListState copyWith({
    ELoadingStatus? status,
    String? message,
    EMainCategory? mainCategory,
    bool? resetMain,
    ESubCategory? subCategory,
    bool? resetSub,
    ESearchRange? region,
    EChildAge? age,
    bool? resetAge,
    bool? applyFilter,
    List<TogetherPreviewModel>? togethers,
    int? page,
  }) =>
      TogetherListState(
        status: status ?? this.status,
        message: message ?? this.message,
        mainCategory:
            resetMain == true ? null : (mainCategory ?? this.mainCategory),
        subCategory:
            resetSub == true ? null : (subCategory ?? this.subCategory),
        region: region ?? this.region,
        age: resetAge == true ? null : (age ?? this.age),
        applyFilter: applyFilter ?? this.applyFilter,
        togethers: togethers ?? this.togethers,
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
        applyFilter,
        togethers,
        page,
      ];
}
