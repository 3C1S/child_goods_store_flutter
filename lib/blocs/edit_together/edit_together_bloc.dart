import 'package:child_goods_store_flutter/blocs/edit_together/edit_together_event.dart';
import 'package:child_goods_store_flutter/blocs/edit_together/edit_together_state.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/http_method.dart';
import 'package:child_goods_store_flutter/enums/image_category.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/models/together/together_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/image_repository_interface.dart';
import 'package:child_goods_store_flutter/repositories/interface/together_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditTogetherBloc extends Bloc<EditTogetherEvent, EditTogetherState>
    with DioExceptionHandlerMixin {
  final ITogetherRepository togetherRepository;
  final IImageRepository imageRepository;
  final EHttpMethod httpMethod;

  EditTogetherBloc({
    required this.togetherRepository,
    required this.imageRepository,
    required this.httpMethod,
    TogetherModel? together,
  }) : super(EditTogetherState.init(together: together)) {
    on<EditTogetherAddImage>(_editTogetherAddImageHandler);
    on<EditTogetherDeleteXFileImage>(_editTogetherDeleteXFileImageHandler);
    on<EditTogetherDeleteNetworkImage>(_editTogetherDeleteNetworkImageHandler);
    on<EditTogetherChangeName>(_editTogetherChangeNameHandler);
    on<EditTogetherChangeDetails>(_editTogetherChangeDetailsHandler);
    on<EditTogetherChangeMainCat>(_editTogetherChangeMainCatHandler);
    on<EditTogetherChangeSubCat>(_editTogetherChangeSubCatHandler);
    on<EditTogetherChangeAge>(_editTogetherChangeAgeHandler);
    on<EditTogetherChangeTags>(_editTogetherChangeTagsHandler);
    on<EditTogetherChangeLink>(_editTogetherChangeLinkHandler);
    on<EditTogetherChangeTotalPrice>(_editTogetherChangeTotalPriceHandler);
    on<EditTogetherChangeTotalNum>(_editTogetherChangeTotalNumHandler);
    on<EditTogetherChangeDeadline>(_editTogetherChangeDeadlineHandler);
    on<EditTogetherChangeAddress>(_editTogetherChangeAddressHandler);
    on<EditTogetherChangeDetailAddress>(
        _editTogetherChangeDetailAddressHandler);
    on<EditTogetherSubmit>(_editTogetherSubmitHandler);
  }

  Future<void> _editTogetherAddImageHandler(
    EditTogetherAddImage event,
    Emitter<EditTogetherState> emit,
  ) async {
    List<XFile> newImages = [];
    newImages
      ..addAll(state.newImage)
      ..addAll(event.images);
    emit(state.copyWith(
      newImage: newImages,
    ));
  }

  Future<void> _editTogetherDeleteXFileImageHandler(
    EditTogetherDeleteXFileImage event,
    Emitter<EditTogetherState> emit,
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

  Future<void> _editTogetherDeleteNetworkImageHandler(
    EditTogetherDeleteNetworkImage event,
    Emitter<EditTogetherState> emit,
  ) async {
    List<String> newImages = [];
    for (var image in state.together.togetherImage.indexed) {
      if (image.$1 != event.index) {
        newImages.add(image.$2);
      }
    }
    emit(state.copyWith(
      together: state.together.copyWith(
        togetherImage: newImages,
      ),
    ));
  }

  Future<void> _editTogetherChangeNameHandler(
    EditTogetherChangeName event,
    Emitter<EditTogetherState> emit,
  ) async {
    emit(state.copyWith(
      together: state.together.copyWith(
        togetherName: event.togetherName,
      ),
    ));
  }

  Future<void> _editTogetherChangeDetailsHandler(
    EditTogetherChangeDetails event,
    Emitter<EditTogetherState> emit,
  ) async {
    emit(state.copyWith(
      together: state.together.copyWith(
        details: event.details,
      ),
    ));
  }

  Future<void> _editTogetherChangeMainCatHandler(
    EditTogetherChangeMainCat event,
    Emitter<EditTogetherState> emit,
  ) async {
    emit(state.copyWith(
      together: state.together.copyWith(
        mainCategory: event.mainCategory,
        subCategory: null,
      ),
    ));
  }

  Future<void> _editTogetherChangeSubCatHandler(
    EditTogetherChangeSubCat event,
    Emitter<EditTogetherState> emit,
  ) async {
    emit(state.copyWith(
      together: state.together.copyWith(
        subCategory: event.subCategory,
      ),
    ));
  }

  Future<void> _editTogetherChangeAgeHandler(
    EditTogetherChangeAge event,
    Emitter<EditTogetherState> emit,
  ) async {
    emit(state.copyWith(
      together: state.together.copyWith(
        age: event.age,
      ),
    ));
  }

  Future<void> _editTogetherChangeTagsHandler(
    EditTogetherChangeTags event,
    Emitter<EditTogetherState> emit,
  ) async {
    emit(state.copyWith(
      together: state.together.copyWith(
        tag: event.tag,
      ),
    ));
  }

  Future<void> _editTogetherChangeLinkHandler(
    EditTogetherChangeLink event,
    Emitter<EditTogetherState> emit,
  ) async {
    emit(state.copyWith(
      together: state.together.copyWith(
        link: event.link,
      ),
    ));
  }

  Future<void> _editTogetherChangeTotalPriceHandler(
    EditTogetherChangeTotalPrice event,
    Emitter<EditTogetherState> emit,
  ) async {
    emit(state.copyWith(
      together: state.together.copyWith(
        totalPrice: event.totalPrice,
      ),
    ));
  }

  Future<void> _editTogetherChangeTotalNumHandler(
    EditTogetherChangeTotalNum event,
    Emitter<EditTogetherState> emit,
  ) async {
    emit(state.copyWith(
      together: state.together.copyWith(
        totalNum: event.totalNum,
      ),
    ));
  }

  Future<void> _editTogetherChangeDeadlineHandler(
    EditTogetherChangeDeadline event,
    Emitter<EditTogetherState> emit,
  ) async {
    emit(state.copyWith(
      together: state.together.copyWith(
        deadline: event.deadline,
      ),
    ));
  }

  Future<void> _editTogetherChangeAddressHandler(
    EditTogetherChangeAddress event,
    Emitter<EditTogetherState> emit,
  ) async {
    emit(state.copyWith(
      together: state.together.copyWith(
        address: event.address,
      ),
    ));
  }

  Future<void> _editTogetherChangeDetailAddressHandler(
    EditTogetherChangeDetailAddress event,
    Emitter<EditTogetherState> emit,
  ) async {
    emit(state.copyWith(
      together: state.together.copyWith(
        detailAddress: event.detailAddress,
      ),
    ));
  }

  Future<void> _editTogetherSubmitHandler(
    EditTogetherSubmit event,
    Emitter<EditTogetherState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;

    // Validate
    if (state.together.togetherName == null ||
        state.together.togetherName == Strings.nullStr) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '공동 구매글 제목을 입력해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }
    if (state.together.details == null ||
        state.together.details == Strings.nullStr) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '공동 구매글 설명을 입력해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }
    if (state.together.mainCategory == null) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '카테고리를 선택해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }
    if (state.together.subCategory == null) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '서브 카테고리를 선택해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }
    if (state.together.link == null || state.together.link == Strings.nullStr) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '상품 링크를 입력해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }
    if (state.together.totalPrice == null) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '총 구매 가격을 입력해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }
    if (state.together.totalNum == null) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '총 구매 수량을 입력해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }
    if (state.together.deadline == null) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '모집 기한을 선택해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }
    if (state.together.address == null ||
        state.together.address == Strings.nullStr ||
        state.together.detailAddress == null ||
        state.together.detailAddress == Strings.nullStr) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '거래 희망장소를 입력해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }

    await handleApiRequest(
      () async {
        emit(state.copyWith(status: ELoadingStatus.loading));

        if (state.newImage.isNotEmpty) {
          var res = await imageRepository.postImageList(
            category: EImageCategory.together,
            images: state.newImage,
          );
          List<String> newImages = [];
          newImages
            ..addAll(state.together.togetherImage)
            ..addAll(res.data ?? []);
          emit(state.copyWith(
            newImage: const [],
            together: state.together.copyWith(
              togetherImage: newImages,
            ),
          ));
        }

        ResModel<int>? res;
        switch (httpMethod) {
          case EHttpMethod.post:
            res = await togetherRepository.postTogether(
              together: state.together,
            );
            break;
          case EHttpMethod.patch:
            res = await togetherRepository.patchTogether(
              together: state.together,
            );
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
