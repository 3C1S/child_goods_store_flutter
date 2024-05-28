import 'package:child_goods_store_flutter/blocs/auth/auth_bloc_singleton.dart';
import 'package:child_goods_store_flutter/blocs/together/detail/together_detail_bloc.dart';
import 'package:child_goods_store_flutter/blocs/together/detail/together_detail_event.dart';
import 'package:child_goods_store_flutter/blocs/together/detail/together_detail_state.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/routes.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/models/go_router_extra_model.dart';
import 'package:child_goods_store_flutter/models/together/together_model.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:child_goods_store_flutter/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:child_goods_store_flutter/utils/other_extensions.dart';

class TogetherDetailBottomBar extends StatefulWidget {
  const TogetherDetailBottomBar({super.key});

  @override
  State<TogetherDetailBottomBar> createState() =>
      _TogetherDetailBottomBarState();
}

class _TogetherDetailBottomBarState extends State<TogetherDetailBottomBar> {
  late final TextEditingController _numController;

  @override
  void initState() {
    super.initState();
    _numController = TextEditingController();
  }

  @override
  void dispose() {
    _numController.dispose();
    super.dispose();
  }

  void _onTapEditTogether() async {
    var res = await context.push<GoRouterExtraModel<int>>(
      Routes.editTogether,
      extra: GoRouterExtraModel<TogetherModel>(
        data: context.read<TogetherDetailBloc>().state.together,
      ),
    );

    if (res?.data != null && mounted) {
      context.read<TogetherDetailBloc>().add(TogetherDetailGet());
    }
  }

  void _onTapParticipate() {}

  bool _iamSaler(TogetherDetailState state) {
    return AuthBlocSingleton.bloc.state.user?.userId ==
        state.together?.user?.userId;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TogetherDetailBloc, TogetherDetailState>(
      builder: (context, state) {
        if (state.togetherStatus != ELoadingStatus.loaded) {
          return const SizedBox();
        }
        return Container(
          height: Sizes.size60 + MediaQuery.viewPaddingOf(context).bottom,
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewPaddingOf(context).bottom,
            left: Sizes.size20,
            right: Sizes.size20,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                spreadRadius: Sizes.size1,
                blurRadius: Sizes.size3,
                offset: const Offset(0, Sizes.size2),
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
          child: Material(
            child: Row(
              children: [
                Expanded(
                  child: AppFont(
                    '${state.together?.purchasePrice?.price()} 원',
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gaps.h10,
                SizedBox(
                  width: Sizes.size96,
                  height: Sizes.size40,
                  child: AppTextFormField(
                    controller: _numController,
                    hintText: '수량',
                    keyboardType: TextInputType.number,
                    suffixText: '개',
                  ),
                ),
                Gaps.h10,
                AppInkButton(
                  onTap:
                      _iamSaler(state) ? _onTapEditTogether : _onTapParticipate,
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size10,
                    horizontal: Sizes.size14,
                  ),
                  child: AppFont(
                    _iamSaler(state) ? '수정하기' : '참여하기',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
