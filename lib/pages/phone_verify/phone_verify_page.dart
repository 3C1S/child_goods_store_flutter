import 'package:child_goods_store_flutter/blocs/phone_verify/phone_verify_bloc.dart';
import 'package:child_goods_store_flutter/blocs/phone_verify/phone_verify_event.dart';
import 'package:child_goods_store_flutter/blocs/phone_verify/phone_verify_state.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:child_goods_store_flutter/widgets/app_snackbar.dart';
import 'package:child_goods_store_flutter/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PhoneVerifyPage extends StatefulWidget {
  const PhoneVerifyPage({super.key});

  @override
  State<PhoneVerifyPage> createState() => _PhoneVerifyPageState();
}

class _PhoneVerifyPageState extends State<PhoneVerifyPage> {
  void _onChangePhone(String value) {
    context.read<PhoneVerifyBloc>().add(PhoneVerifyChangeNum(value));
  }

  void _onChangeCode(String value) {
    context.read<PhoneVerifyBloc>().add(PhoneVerifyChangeCode(value));
  }

  void _onTapComplete() {
    context.read<PhoneVerifyBloc>().add(PhoneVerifySubmit());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneVerifyBloc, PhoneVerifyState>(
      listener: (context, state) {
        if (state.status == ELoadingStatus.error) {
          AppSnackbar.show(
            context,
            message: state.message ?? Strings.nullStr,
          );
        }
        if (state.codeStatus == ELoadingStatus.loaded) {
          context.pop<String?>(state.phoneNum);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const AppFont('핸드폰 인증'),
          centerTitle: false,
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(Sizes.size20),
            child: BlocBuilder<PhoneVerifyBloc, PhoneVerifyState>(
              builder: (context, state) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppTextFormField(
                    hintText: '핸드폰 번호를 입력해주세요',
                    keyboardType: TextInputType.phone,
                    onChange: _onChangePhone,
                    enabled: state.phoneStatus != ELoadingStatus.loaded,
                    onFieldSubmitted: (_) => _onTapComplete(),
                  ),
                  Gaps.v20,
                  if (state.phoneStatus == ELoadingStatus.loaded)
                    AppTextFormField(
                      hintText: '인증번호를 입력해주세요',
                      keyboardType: TextInputType.number,
                      onChange: _onChangeCode,
                      onFieldSubmitted: (_) => _onTapComplete(),
                    ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BlocBuilder<PhoneVerifyBloc, PhoneVerifyState>(
          builder: (context, state) {
            return AppInkButton(
              onTap: state.status == ELoadingStatus.loading
                  ? null
                  : _onTapComplete,
              borderRadSize: 0,
              child: Container(
                width: double.infinity,
                height: Sizes.size32,
                margin: EdgeInsets.only(
                  bottom: MediaQuery.viewPaddingOf(context).bottom,
                ),
                child: Center(
                  child: state.status == ELoadingStatus.loading
                      ? const SizedBox(
                          width: Sizes.size28,
                          height: Sizes.size28,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : AppFont(
                          state.phoneStatus != ELoadingStatus.loaded
                              ? '인증 번호 전송'
                              : '인증 완료',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
