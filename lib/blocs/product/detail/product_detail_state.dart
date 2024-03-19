import 'package:child_goods_store_flutter/blocs/abs_bloc_state.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/models/product/product_model.dart';

class ProductDetailState extends BlocState {
  final ProductModel? productModel;
  final ELoadingStatus productStatus;
  final ELoadingStatus changeSaleStatus;
  final ELoadingStatus heartStatus;

  const ProductDetailState({
    this.productModel,
    required this.productStatus,
    required this.changeSaleStatus,
    required this.heartStatus,
    required super.status,
    super.message,
  });

  const ProductDetailState.init()
      : productModel = null,
        productStatus = ELoadingStatus.init,
        changeSaleStatus = ELoadingStatus.init,
        heartStatus = ELoadingStatus.init,
        super(
          status: ELoadingStatus.init,
          message: null,
        );

  @override
  ProductDetailState copyWith({
    ELoadingStatus? status,
    String? message,
    ProductModel? productModel,
    ELoadingStatus? productStatus,
    ELoadingStatus? changeSaleStatus,
    ELoadingStatus? heartStatus,
  }) =>
      ProductDetailState(
        status: status ?? this.status,
        message: message ?? this.message,
        productModel: productModel ?? this.productModel,
        productStatus: productStatus ?? this.productStatus,
        changeSaleStatus: changeSaleStatus ?? this.changeSaleStatus,
        heartStatus: heartStatus ?? this.heartStatus,
      );

  @override
  List<Object?> get props => [
        status,
        message,
        productModel,
        productStatus,
        changeSaleStatus,
        heartStatus,
      ];
}
