import 'package:bloc/bloc.dart';
import 'package:child_goods_store_flutter/blocs/delete_account/delete_account_event.dart';
import 'package:child_goods_store_flutter/blocs/delete_account/delete_account_state.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/mixins/dio_exception_handler.dart';
import 'package:child_goods_store_flutter/repositories/interface/user_repository_interface.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState>
    with DioExceptionHandlerMixin {
  final IUserRepository userRepository;

  DeleteAccountBloc({
    required this.userRepository,
  }) : super(const DeleteAccountState.init()) {
    on<DeleteAccount>(_deleteAccountHandler);
  }

  Future<void> _deleteAccountHandler(
    DeleteAccount event,
    Emitter<DeleteAccountState> emit,
  ) async {
    if (state.status == ELoadingStatus.loading) return;

    await handleApiRequest(
      () async {
        emit(const DeleteAccountState(status: ELoadingStatus.loading));

        await userRepository.deleteUser();

        emit(const DeleteAccountState(status: ELoadingStatus.loaded));
      },
      state: state,
      emit: emit,
    );
  }
}
