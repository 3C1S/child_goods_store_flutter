import 'package:child_goods_store_flutter/blocs/app_data/app_data_bloc.dart';
import 'package:child_goods_store_flutter/blocs/app_data/app_data_event.dart';
import 'package:child_goods_store_flutter/blocs/app_data/app_data_state.dart';
import 'package:child_goods_store_flutter/blocs/auth/auth_bloc_singleton.dart';
import 'package:child_goods_store_flutter/blocs/auth/auth_event.dart';
import 'package:child_goods_store_flutter/blocs/splash/splash_cubit.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<AppDataBloc>().add(AppDataReset());
    WidgetsBinding.instance.addPostFrameCallback((_) => _afterFirstBuild());
  }

  void _afterFirstBuild() {
    context.read<SplashCubit>().setSplash(ESplash.adminDistrict);
  }

  void _getAdminDistrict() {
    context.read<AppDataBloc>().add(AppDataLoadAdminDistrict());
  }

  void _getAddress() {
    context.read<AppDataBloc>().add(AppDataLoadAddress());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      extendBodyBehindAppBar: true,
      body: Center(
        child: MultiBlocListener(
          listeners: [
            // Admin district listen
            BlocListener<AppDataBloc, AppDataState>(
              listenWhen: (previous, current) =>
                  previous.regionStatus != current.regionStatus,
              listener: (context, state) {
                if (state.regionStatus == ELoadingStatus.loaded) {
                  context.read<SplashCubit>().setSplash(ESplash.getAddress);
                }
              },
            ),
            // Address listen
            BlocListener<AppDataBloc, AppDataState>(
              listenWhen: (previous, current) =>
                  previous.addressStatus != current.addressStatus,
              listener: (context, state) {
                if (state.addressStatus == ELoadingStatus.loaded) {
                  context.read<SplashCubit>().setSplash(ESplash.getUser);
                }
              },
            ),
            // Auth listening from GoRouter listenable
            // Error listen
            BlocListener<AppDataBloc, AppDataState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status == ELoadingStatus.error) {
                  context.read<SplashCubit>().setSplash(ESplash.error);
                }
              },
            ),
          ],
          child: BlocConsumer<SplashCubit, ESplash>(
            listener: (context, state) {
              if (state == ESplash.adminDistrict) {
                _getAdminDistrict();
              }
              if (state == ESplash.getAddress) {
                _getAddress();
              }
              if (state == ESplash.getUser) {
                AuthBlocSingleton.bloc.add(AuthGetUser());
              }
            },
            builder: (context, state) {
              if (state == ESplash.error) {
                return _buildError(
                  context,
                  message: context.read<AppDataBloc>().state.message ??
                      Strings.unknownFail,
                );
              }
              return Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/child_goods_store_icon_1024.png',
                    width: MediaQuery.sizeOf(context).width * 0.66,
                    height: MediaQuery.sizeOf(context).width * 0.66,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).width * 0.66,
                    ),
                    child: SafeArea(
                      child: AppFont(state.text),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildError(
    BuildContext context, {
    required String message,
  }) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppFont(message),
          Gaps.v20,
          const AppFont('같은 문제가 지속적으로 발생된다면 아래 주소로 신고해주세요.'),
        ],
      ),
    );
  }
}
