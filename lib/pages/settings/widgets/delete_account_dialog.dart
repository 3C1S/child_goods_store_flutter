import 'package:child_goods_store_flutter/blocs/auth/auth_bloc_singleton.dart';
import 'package:child_goods_store_flutter/blocs/auth/auth_event.dart';
import 'package:child_goods_store_flutter/blocs/delete_account/delete_account_bloc.dart';
import 'package:child_goods_store_flutter/blocs/delete_account/delete_account_event.dart';
import 'package:child_goods_store_flutter/blocs/delete_account/delete_account_state.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:child_goods_store_flutter/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  void _onTapDelete(BuildContext context) {
    context.read<DeleteAccountBloc>().add(DeleteAccount());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteAccountBloc, DeleteAccountState>(
      listener: (context, state) {
        if (state.status == ELoadingStatus.loaded) {
          AuthBlocSingleton.bloc.add(AuthSignout());
          AppSnackbar.show(
            context,
            message: '회원 탈퇴가 완료되었습니다',
          );
          context.pop();
        }
        if (state.status == ELoadingStatus.error) {
          AppSnackbar.show(
            context,
            message: state.message ?? Strings.unknownFail,
          );
          context.pop();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AppFont(
            '경고',
            color: Colors.red,
            fontSize: Sizes.size20,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          Gaps.v10,
          const AppFont('회원 탈퇴는 되돌릴 수 없습니다.'),
          const AppFont('정말로 탈퇴하시겠습니까?'),
          Gaps.v20,
          BlocBuilder<DeleteAccountBloc, DeleteAccountState>(
            builder: (context, state) {
              if (state.status == ELoadingStatus.loading) {
                return const SizedBox(
                  height: Sizes.size40,
                  child: Center(
                    child: SizedBox(
                      width: Sizes.size20,
                      height: Sizes.size20,
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              }
              return SizedBox(
                height: Sizes.size40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: AppInkButton(
                        onTap: context.pop,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: const Center(
                          child: AppFont('아니오'),
                        ),
                      ),
                    ),
                    Gaps.h10,
                    Expanded(
                      child: AppInkButton(
                        onTap: () => _onTapDelete(context),
                        color: Colors.red,
                        child: const Center(
                          child: AppFont(
                            '네, 탈퇴할게요',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Gaps.v10,
        ],
      ),
    );
  }
}
