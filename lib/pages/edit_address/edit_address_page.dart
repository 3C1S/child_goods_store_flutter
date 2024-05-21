import 'package:child_goods_store_flutter/blocs/app_data/app_data_bloc.dart';
import 'package:child_goods_store_flutter/blocs/app_data/app_data_event.dart';
import 'package:child_goods_store_flutter/blocs/edit_address/edit_address_bloc.dart';
import 'package:child_goods_store_flutter/blocs/edit_address/edit_address_event.dart';
import 'package:child_goods_store_flutter/blocs/edit_address/edit_address_state.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/pages/edit_address/widgets/edit_address_category.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:child_goods_store_flutter/widgets/app_snackbar.dart';
import 'package:child_goods_store_flutter/widgets/app_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kpostal/kpostal.dart';

class EditAddressPage extends StatefulWidget {
  const EditAddressPage({super.key});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  late final TextEditingController _detailController;

  @override
  void initState() {
    super.initState();
    _detailController = TextEditingController(
      text: context.read<EditAddressBloc>().state.address.detailAddress,
    );
  }

  @override
  void dispose() {
    _detailController.dispose();
    super.dispose();
  }

  void _onTapEditAddress() async {
    Kpostal? result = await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            CupertinoPageTransition(
          primaryRouteAnimation: animation,
          secondaryRouteAnimation: secondaryAnimation,
          linearTransition: false,
          child: KpostalView(
            loadingColor: Theme.of(context).primaryColorDark,
          ),
        ),
      ),
    );

    if (result?.address != null && mounted) {
      context
          .read<EditAddressBloc>()
          .add(EditAddressChangeAddress(result!.address));
    }
  }

  void _onDetailChange(String detail) {
    context.read<EditAddressBloc>().add(EditAddressChangeDetail(detail));
  }

  void _onTapComplete() {
    context.read<EditAddressBloc>().add(EditAddressSubmit());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditAddressBloc, EditAddressState>(
      listener: (context, state) {
        if (state.status == ELoadingStatus.error) {
          AppSnackbar.show(
            context,
            message: state.message ?? Strings.nullStr,
          );
        }
        if (state.status == ELoadingStatus.loaded) {
          context.read<AppDataBloc>().add(AppDataUpdateAddress(state.result!));
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const AppFont('배송지 수정'),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.size20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: _onTapEditAddress,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          const AppFont(
                            '도로명 주소',
                            fontSize: Sizes.size16,
                            fontWeight: FontWeight.w700,
                          ),
                          Gaps.h10,
                          SizedBox(
                            width: Sizes.size40,
                            height: Sizes.size40,
                            child: AppInkButton(
                              borderRadSize: Sizes.size20,
                              onTap: _onTapEditAddress,
                              padding: EdgeInsets.zero,
                              child: const Icon(
                                Icons.search_rounded,
                                color: Colors.white,
                                size: Sizes.size20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gaps.v5,
                      Container(
                        padding: const EdgeInsets.all(Sizes.size10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: Sizes.size1,
                            color: Colors.grey.shade200,
                          ),
                          borderRadius: BorderRadius.circular(Sizes.size5),
                        ),
                        child: BlocBuilder<EditAddressBloc, EditAddressState>(
                          builder: (context, state) => AppFont(
                            state.address.address ?? '도로명 주소를 검색해주세요.',
                            fontSize: Sizes.size14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gaps.v5,
                AppTextFormField(
                  hintText: '상세 주소',
                  controller: _detailController,
                  onChange: _onDetailChange,
                ),
                Gaps.v20,
                const EditAddressCategory(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BlocBuilder<EditAddressBloc, EditAddressState>(
          builder: (context, state) {
            return AppInkButton(
              onTap: state.status == ELoadingStatus.loading
                  ? null
                  : _onTapComplete,
              borderRadSize: 0,
              padding: EdgeInsets.zero,
              child: Container(
                width: double.infinity,
                height: Sizes.size60,
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
                      : const AppFont(
                          '저장',
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
