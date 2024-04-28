import 'package:child_goods_store_flutter/blocs/edit_product/edit_product_event.dart';
import 'package:child_goods_store_flutter/blocs/edit_product/edit_product_state.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/http_method.dart';
import 'package:child_goods_store_flutter/enums/image_category.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/models/product/product_model.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/image_repository_interface.dart';
import 'package:child_goods_store_flutter/repositories/interface/product_repository_interfave.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProductBloc extends Bloc<EditProductEvent, EditProductState>
    with DioExceptionHandlerMixin {
  final IProductRepository productRepository;
  final IImageRepository imageRepository;
  final EHttpMethod httpMethod;

  EditProductBloc({
    required this.productRepository,
    required this.imageRepository,
    required this.httpMethod,
    ProductModel? product,
  }) : super(EditProductState.init(product: product)) {
    on<EditProductAddImage>(_editProductAddImageHandler);
    on<EditProductDeleteXFileImage>(_editProductDeleteXFileImageHandler);
    on<EditProductDeleteNetworkImage>(_editProductDeleteNetworkImageHandler);
    on<EditProductChangeName>(_editProductChangeNameHandler);
    on<EditProductChangeContent>(_editProductChangeContentHandler);
    on<EditProductChangeMainCat>(_editProductChangeMainCatHandler);
    on<EditProductChangeSubCat>(_editProductChangeSubCatHandler);
    on<EditProductChangeAge>(_editProductChangeAgeHandler);
    on<EditProductChangeTags>(_editProductChangeTagsHandler);
    on<EditProductChangePrice>(_editProductChangePriceHandler);
    on<EditProductChangeState>(_editProductChangeStateHandler);
    on<EditProductSubmit>(_editProductSubmitHandler);
  }

  Future<void> _editProductAddImageHandler(
    EditProductAddImage event,
    Emitter<EditProductState> emit,
  ) async {
    List<XFile> newImages = [];
    newImages
      ..addAll(state.newImage)
      ..addAll(event.images);
    emit(state.copyWith(
      newImage: newImages,
    ));
  }

  Future<void> _editProductDeleteXFileImageHandler(
    EditProductDeleteXFileImage event,
    Emitter<EditProductState> emit,
  ) async {
    List<XFile> newImages = [];
    for (var image in state.newImage.indexed) {
      if (image.$1 != event.index) {
        newImages.add(image.$2);
      }
    }
    emit(state.copyWith(
      newImage: newImages,
    ));
  }

  Future<void> _editProductDeleteNetworkImageHandler(
    EditProductDeleteNetworkImage event,
    Emitter<EditProductState> emit,
  ) async {
    List<String> newImages = [];
    for (var image in state.product.productImage.indexed) {
      if (image.$1 != event.index) {
        newImages.add(image.$2);
      }
    }
    emit(state.copyWith(
      product: state.product.copyWith(
        productImage: newImages,
      ),
    ));
  }

  Future<void> _editProductChangeNameHandler(
    EditProductChangeName event,
    Emitter<EditProductState> emit,
  ) async {
    emit(state.copyWith(
      product: state.product.copyWith(
        productName: event.productName,
      ),
    ));
  }

  Future<void> _editProductChangeContentHandler(
    EditProductChangeContent event,
    Emitter<EditProductState> emit,
  ) async {
    emit(state.copyWith(
      product: state.product.copyWith(
        content: event.content,
      ),
    ));
  }

  Future<void> _editProductChangeMainCatHandler(
    EditProductChangeMainCat event,
    Emitter<EditProductState> emit,
  ) async {
    emit(state.copyWith(
      product: state.product.copyWith(
        mainCategory: event.mainCategory,
        subCategory: null,
      ),
    ));
  }

  Future<void> _editProductChangeSubCatHandler(
    EditProductChangeSubCat event,
    Emitter<EditProductState> emit,
  ) async {
    emit(state.copyWith(
      product: state.product.copyWith(
        subCategory: event.subCategory,
      ),
    ));
  }

  Future<void> _editProductChangeAgeHandler(
    EditProductChangeAge event,
    Emitter<EditProductState> emit,
  ) async {
    emit(state.copyWith(
      product: state.product.copyWith(
        age: event.age,
      ),
    ));
  }

  Future<void> _editProductChangeTagsHandler(
    EditProductChangeTags event,
    Emitter<EditProductState> emit,
  ) async {
    emit(state.copyWith(
      product: state.product.copyWith(
        tag: event.tag,
      ),
    ));
  }

  Future<void> _editProductChangePriceHandler(
    EditProductChangePrice event,
    Emitter<EditProductState> emit,
  ) async {
    emit(state.copyWith(
      product: state.product.copyWith(
        price: event.price,
      ),
    ));
  }

  Future<void> _editProductChangeStateHandler(
    EditProductChangeState event,
    Emitter<EditProductState> emit,
  ) async {
    emit(state.copyWith(
      product: state.product.copyWith(
        productState: event.productState,
      ),
    ));
  }

  Future<void> _editProductSubmitHandler(
    EditProductSubmit event,
    Emitter<EditProductState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;

    // Validate
    if (state.product.productName == null ||
        state.product.productName == Strings.nullStr) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '상품 이름을 입력해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }
    if (state.product.content == null ||
        state.product.content == Strings.nullStr) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '상품 설명을 입력해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }
    if (state.product.price == null) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '상품 가격을 입력해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }
    if (state.product.productState == null) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '상품 상태를 골라주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }
    if (state.product.mainCategory == null) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '상품 카테고리를 선택해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }
    if (state.product.subCategory == null) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '상품 서브 카테고리를 선택해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }

    await handleApiRequest(
      () async {
        emit(state.copyWith(status: ELoadingStatus.loading));

        if (state.newImage.isNotEmpty) {
          var res = await imageRepository.postImageList(
            category: EImageCategory.product,
            images: state.newImage,
          );
          List<String> newImages = [];
          newImages
            ..addAll(state.product.productImage)
            ..addAll(res.data ?? []);
          emit(state.copyWith(
            newImage: const [],
            product: state.product.copyWith(
              productImage: newImages,
            ),
          ));
        }

        ResModel<int>? res;
        switch (httpMethod) {
          case EHttpMethod.post:
            res = await productRepository.postProduct(product: state.product);
            break;
          case EHttpMethod.patch:
            res = await productRepository.patchProduct(product: state.product);
            break;
        }

        if (res.data == null) {
          emit(state.copyWith(
            status: ELoadingStatus.error,
            message: '저장에 실패했습니다.',
          ));
          emit(state.copyWith(status: ELoadingStatus.init));
          return;
        }

        emit(state.copyWith(
          status: ELoadingStatus.loaded,
          result: res.data,
        ));
      },
      state: state,
      emit: emit,
    );
  }
}
