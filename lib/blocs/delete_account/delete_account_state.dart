import 'package:child_goods_store_flutter/blocs/abs_bloc_state.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';

class DeleteAccountState extends BlocState {
  const DeleteAccountState({
    required super.status,
    super.message,
  });

  const DeleteAccountState.init()
      : super(
          status: ELoadingStatus.init,
          message: null,
        );

  @override
  DeleteAccountState copyWith({
    ELoadingStatus? status,
    String? message,
  }) =>
      DeleteAccountState(
        status: status ?? this.status,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        status,
        message,
      ];
}
