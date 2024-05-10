import 'package:child_goods_store_flutter/blocs/product/buyer/product_buyer_event.dart';
import 'package:child_goods_store_flutter/blocs/product/buyer/product_buyer_state.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/repositories/interface/product_repository_interfave.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBuyerBloc extends Bloc<ProductBuyerEvent, ProductBuyerState>
    with DioExceptionHandlerMixin {
  final IProductRepository productRepository;
  final int productId;

  ProductBuyerBloc({
    required this.productRepository,
    required this.productId,
  }) : super(const ProductBuyerState.init()) {
    on<ProductBuyerGet>(_productBuyerGetHandler);
  }

  Future<void> _productBuyerGetHandler(
    ProductBuyerGet event,
    Emitter<ProductBuyerState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;

    await handleApiRequest(
      () async {
        emit(state.copyWith(status: ELoadingStatus.loading));

        var res = await productRepository.getProductBuyer(
          productId: productId,
        );

        emit(state.copyWith(
          status: ELoadingStatus.loaded,
          buyers: res.data,
        ));
      },
      state: state,
      emit: emit,
      initAfterError: false,
    );
  }
}
