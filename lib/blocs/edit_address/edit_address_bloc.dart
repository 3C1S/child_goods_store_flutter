import 'package:bloc/bloc.dart';
import 'package:child_goods_store_flutter/blocs/edit_address/edit_address_event.dart';
import 'package:child_goods_store_flutter/blocs/edit_address/edit_address_state.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/http_method.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/models/address/address_model.dart';
import 'package:child_goods_store_flutter/models/res/res_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/data_repository_interface.dart';

class EditAddressBloc extends Bloc<EditAddressEvent, EditAddressState>
    with DioExceptionHandlerMixin {
  final IDataRepository dataRepository;
  final EHttpMethod httpMethod;

  EditAddressBloc({
    required this.dataRepository,
    required this.httpMethod,
    AddressModel? address,
  }) : super(EditAddressState.init(address: address)) {
    on<EditAddressChangeCategory>(_editAddressChangeCategoryHandler);
    on<EditAddressChangeAddress>(_editAddressChangeAddressHandler);
    on<EditAddressChangeDetail>(_editAddressChangeDetailHandler);
    on<EditAddressSubmit>(_editAddressSubmitHandler);
  }

  Future<void> _editAddressChangeCategoryHandler(
    EditAddressChangeCategory event,
    Emitter<EditAddressState> emit,
  ) async {
    emit(state.copyWith(
      address: state.address.copyWith(
        category: event.category,
      ),
    ));
  }

  Future<void> _editAddressChangeAddressHandler(
    EditAddressChangeAddress event,
    Emitter<EditAddressState> emit,
  ) async {
    emit(state.copyWith(
      address: state.address.copyWith(
        address: event.address,
      ),
    ));
  }

  Future<void> _editAddressChangeDetailHandler(
    EditAddressChangeDetail event,
    Emitter<EditAddressState> emit,
  ) async {
    emit(state.copyWith(
      address: state.address.copyWith(
        detailAddress: event.detailAddress,
      ),
    ));
  }

  Future<void> _editAddressSubmitHandler(
    EditAddressSubmit event,
    Emitter<EditAddressState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;

    // Validate
    if (state.address.category == null) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '배송지 카테고리를 설정해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }
    if (state.address.address == null ||
        state.address.address == Strings.nullStr) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '주소를 입력해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }
    if (state.address.detailAddress == null ||
        state.address.detailAddress == Strings.nullStr) {
      emit(state.copyWith(
        status: ELoadingStatus.error,
        message: '상세 주소를 입력해주세요.',
      ));
      emit(state.copyWith(status: ELoadingStatus.init));
      return;
    }

    await handleApiRequest(
      () async {
        emit(state.copyWith(status: ELoadingStatus.loading));

        ResModel<AddressModel>? res;
        switch (httpMethod) {
          case EHttpMethod.post:
            res = await dataRepository.postAddress(address: state.address);
            break;
          case EHttpMethod.patch:
            res = await dataRepository.patchAddress(address: state.address);
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
