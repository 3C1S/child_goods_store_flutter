import 'package:child_goods_store_flutter/blocs/product/detail/product_detail_event.dart';
import 'package:child_goods_store_flutter/blocs/product/detail/product_detail_state.dart';
import 'package:child_goods_store_flutter/enums/chat_item_type.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/enums/product_sale_state.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/chat_repository_interface.dart';
import 'package:child_goods_store_flutter/repositories/interface/product_repository_interfave.dart';
import 'package:child_goods_store_flutter/utils/mock_dio_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState>
    with DioExceptionHandlerMixin {
  final IProductRepository productRepository;
  final IChatRepository chatRepository;
  final int productId;

  ProductDetailBloc({
    required this.productRepository,
    required this.chatRepository,
    required this.productId,
  }) : super(const ProductDetailState.init()) {
    on<ProductDetailGet>(_productDetailGetHandler);
    on<ProductDetailChangeSaleState>(_productDetailChangeSaleStateHandler);
    on<ProductDetailChangeHeart>(_productDetailChangeHeartHandler);
    on<ProductDetailChat>(_productDetailChatHandler);

    add(ProductDetailGet());
  }

  Future<void> _productDetailGetHandler(
    ProductDetailGet event,
    Emitter<ProductDetailState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading &&
        state.productStatus == ELoadingStatus.loading) return;

    emit(state.copyWith(
      status: ELoadingStatus.loading,
      productStatus: ELoadingStatus.loading,
    ));
    await handleApiRequest(
      () async {
        var res = await productRepository.getProduct(
          productId: productId,
        );

        emit(state.copyWith(
          status: ELoadingStatus.loaded,
          productStatus: ELoadingStatus.loaded,
          productModel: res.data,
        ));
      },
      state: state,
      emit: emit,
      initAfterError: false,
    );
  }

  Future<void> _productDetailChangeSaleStateHandler(
    ProductDetailChangeSaleState event,
    Emitter<ProductDetailState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading &&
        state.changeSaleStatus == ELoadingStatus.loading) return;

    if (event.state != EProductSaleState.soldout &&
        state.productModel?.state == event.state) return;

    emit(state.copyWith(
      status: ELoadingStatus.loading,
      changeSaleStatus: ELoadingStatus.loading,
    ));
    await handleApiRequest(
      () async {
        if (event.state == EProductSaleState.soldout && event.userId == null) {
          mockThrowDioError(
            errorModel: ResModel(
              code: 5000,
              message: '구매자가 설정되지 않았습니다.',
            ),
          );
          return;
        }

        await productRepository.postProductState(
          state: event.state,
          productId: productId,
          saledUserId: event.userId,
        );

        emit(state.copyWith(
          status: ELoadingStatus.loaded,
          changeSaleStatus: ELoadingStatus.loaded,
          productModel: state.productModel?.copyWith(
            state: event.state,
          ),
        ));
      },
      state: state,
      emit: emit,
      finallyCall: () async {
        emit(state.copyWith(
          status: ELoadingStatus.init,
          changeSaleStatus: ELoadingStatus.init,
        ));
      },
    );
  }

  Future<void> _productDetailChangeHeartHandler(
    ProductDetailChangeHeart event,
    Emitter<ProductDetailState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading &&
        state.heartStatus == ELoadingStatus.loading) return;

    bool prevState = state.productModel?.productHeart ?? false;

    // on event -> change
    emit(state.copyWith(
      productModel: state.productModel?.copyWith(
        productHeart: !prevState,
      ),
      status: ELoadingStatus.loading,
      heartStatus: ELoadingStatus.loading,
    ));
    await handleApiRequest(
      () async {
        if (prevState) {
          await productRepository.deleteProductHeart(
            productId: productId,
          );
        } else {
          await productRepository.postProductHeart(
            productId: productId,
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
            productModel: state.productModel?.copyWith(
              productHeart: prevState,
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

  Future<void> _productDetailChatHandler(
    ProductDetailChat event,
    Emitter<ProductDetailState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading &&
        state.chatStatus == ELoadingStatus.loading) return;

    emit(state.copyWith(
      status: ELoadingStatus.loading,
      chatStatus: ELoadingStatus.loading,
    ));
    await handleApiRequest(
      () async {
        var res = await chatRepository.postChattingRoom(
          category: EChatItemType.product,
          id: productId,
        );

        emit(state.copyWith(
          status: ELoadingStatus.loaded,
          chatStatus: ELoadingStatus.loaded,
          chatRoomIdResult: res.data,
        ));
      },
      state: state,
      emit: emit,
      finallyCall: () async {
        emit(state.copyWith(
          status: ELoadingStatus.init,
          chatStatus: ELoadingStatus.init,
        ));
      },
    );
  }
}
