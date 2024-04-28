import 'package:child_goods_store_flutter/blocs/app_data/app_data_event.dart';
import 'package:child_goods_store_flutter/blocs/app_data/app_data_state.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/models/address/address_model.dart';
import 'package:child_goods_store_flutter/repositories/interface/data_repository_interface.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppDataBloc extends Bloc<AppDataEvent, AppDataState>
    with DioExceptionHandlerMixin {
  final IDataRepository dataRepository;

  AppDataBloc({
    required this.dataRepository,
  }) : super(AppDataState.init()) {
    on<AppDataReset>(_appDataResetHandler);
    on<AppDataLoadAdminDistrict>(_appDataLoadAdminDistrictHandler);
    on<AppDataLoadAddress>(_appDataLoadAddressHandler);
    on<AppDataUpdateAddress>(_appDataUpdateAddressHandler);
  }

  Future<void> _appDataResetHandler(
    AppDataReset event,
    Emitter<AppDataState> emit,
  ) async {
    emit(AppDataState.init());
  }

  Future<void> _appDataLoadAdminDistrictHandler(
    AppDataLoadAdminDistrict event,
    Emitter<AppDataState> emit,
  ) async {
    emit(state.copyWith(
      regionStatus: ELoadingStatus.loading,
      status: ELoadingStatus.loading,
    ));
    await handleApiRequest(
      () async {
        var res = await dataRepository.getAdminDistrict();

        emit(state.copyWith(
          regionStatus: ELoadingStatus.loaded,
          status: ELoadingStatus.loaded,
          region: res,
        ));
      },
      state: state,
      emit: emit,
      initAfterError: false,
    );
  }

  Future<void> _appDataLoadAddressHandler(
    AppDataLoadAddress event,
    Emitter<AppDataState> emit,
  ) async {
    emit(state.copyWith(
      addressStatus: ELoadingStatus.loading,
      status: ELoadingStatus.loading,
    ));
    await handleApiRequest(
      () async {
        var res = await dataRepository.getAddress();

        emit(state.copyWith(
          addressStatus: ELoadingStatus.loaded,
          status: ELoadingStatus.loaded,
          addresses: res.data,
        ));
      },
      state: state,
      emit: emit,
      initAfterError: false,
    );
  }

  Future<void> _appDataUpdateAddressHandler(
    AppDataUpdateAddress event,
    Emitter<AppDataState> emit,
  ) async {
    bool isNew = true;
    List<AddressModel> res = [];
    for (var address in state.addresses) {
      if (address.addressId == event.address.addressId) {
        res.add(event.address);
        isNew = false;
      } else {
        res.add(address);
      }
    }
    if (isNew) {
      res.add(event.address);
    }

    emit(state.copyWith(addresses: res));
  }
}
