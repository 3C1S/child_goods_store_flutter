import 'package:child_goods_store_flutter/blocs/auth/auth_bloc_singleton.dart';
import 'package:child_goods_store_flutter/blocs/auth/auth_event.dart';
import 'package:child_goods_store_flutter/blocs/delete_account/delete_account_bloc.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/routes.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/pages/settings/widgets/delete_account_dialog.dart';
import 'package:child_goods_store_flutter/repositories/interface/user_repository_interface.dart';
import 'package:child_goods_store_flutter/widgets/app_bottom_sheet.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void _onTapProfile(BuildContext context) {
    context.push(Routes.editProfile);
  }

  void _onTapShip(BuildContext context) {
    context.push('${Routes.settings}/${SubRoutes.ship}');
  }

  void _onTapNotification(BuildContext context) {
    context.push('${Routes.settings}/${SubRoutes.notification}');
  }

  void _onTapSignout(BuildContext context) {
    AuthBlocSingleton.bloc.add(AuthSignout());
  }

  void _onTapRemoveAccount(BuildContext context) {
    AppBottomSheet.show(
      context,
      applyBottomPadding: true,
      child: BlocProvider(
        create: (context) => DeleteAccountBloc(
          userRepository: context.read<IUserRepository>(),
        ),
        child: const DeleteAccountDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppFont('설정'),
        centerTitle: false,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppInkButton(
                onTap: () => _onTapProfile(context),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: const AppFont('프로필 / 내 동네 설정'),
              ),
              Gaps.v10,
              AppInkButton(
                onTap: () => _onTapShip(context),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: const AppFont('배송지 설정'),
              ),
              Gaps.v32,
              AppInkButton(
                onTap: () => _onTapNotification(context),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: const AppFont('알림 설정'),
              ),
              Gaps.v10,
              AppInkButton(
                onTap: () => _onTapSignout(context),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: const AppFont('로그아웃'),
              ),
              Gaps.v10,
              AppInkButton(
                onTap: () => _onTapRemoveAccount(context),
                color: Theme.of(context).scaffoldBackgroundColor,
                child: const AppFont('회원탈퇴'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
