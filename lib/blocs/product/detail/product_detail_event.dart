import 'package:child_goods_store_flutter/enums/product_sale_state.dart';

abstract class ProductDetailEvent {}

class ProductDetailGet extends ProductDetailEvent {}

class ProductDetailChangeSaleState extends ProductDetailEvent {
  final EProductSaleState state;
  final int? userId;

  ProductDetailChangeSaleState(
    this.state, {
    this.userId,
  });
}

class ProductDetailChangeHeart extends ProductDetailEvent {}

class ProductDetailChat extends ProductDetailEvent {}
