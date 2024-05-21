import 'package:child_goods_store_flutter/blocs/edit_together/edit_together_bloc.dart';
import 'package:child_goods_store_flutter/blocs/edit_together/edit_together_event.dart';
import 'package:child_goods_store_flutter/blocs/edit_together/edit_together_state.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/models/go_router_extra_model.dart';
import 'package:child_goods_store_flutter/pages/edit_together/widgets/edit_together_address.dart';
import 'package:child_goods_store_flutter/pages/edit_together/widgets/edit_together_age.dart';
import 'package:child_goods_store_flutter/pages/edit_together/widgets/edit_together_category.dart';
import 'package:child_goods_store_flutter/pages/edit_together/widgets/edit_together_deadline.dart';
import 'package:child_goods_store_flutter/pages/edit_together/widgets/edit_together_image.dart';
import 'package:child_goods_store_flutter/pages/edit_together/widgets/edit_together_tag.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:child_goods_store_flutter/widgets/app_snackbar.dart';
import 'package:child_goods_store_flutter/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditTogetherPage extends StatefulWidget {
  const EditTogetherPage({super.key});

  @override
  State<EditTogetherPage> createState() => _EditTogetherPageState();
}

class _EditTogetherPageState extends State<EditTogetherPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _detailsController;
  late final TextEditingController _linkController;
  late final TextEditingController _totalPriceController;
  late final TextEditingController _totalNumController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: context.read<EditTogetherBloc>().state.together.togetherName,
    );
    _detailsController = TextEditingController(
      text: context.read<EditTogetherBloc>().state.together.details,
    );
    _linkController = TextEditingController(
      text: context.read<EditTogetherBloc>().state.together.link,
    );
    _totalPriceController = TextEditingController(
      text: context
          .read<EditTogetherBloc>()
          .state
          .together
          .totalPrice
          ?.toString(),
    );
    _totalNumController = TextEditingController(
      text:
          context.read<EditTogetherBloc>().state.together.totalNum?.toString(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _detailsController.dispose();
    _linkController.dispose();
    _totalPriceController.dispose();
    _totalNumController.dispose();
    super.dispose();
  }

  void _onChangeName(String name) {
    context.read<EditTogetherBloc>().add(EditTogetherChangeName(name));
  }

  void _onChangeDetails(String details) {
    context.read<EditTogetherBloc>().add(EditTogetherChangeDetails(details));
  }

  void _onChangeLink(String link) {
    context.read<EditTogetherBloc>().add(EditTogetherChangeLink(link));
  }

  void _onChangeTotalPrice(String totalPrice) {
    if (int.tryParse(totalPrice) == null) return;
    context
        .read<EditTogetherBloc>()
        .add(EditTogetherChangeTotalPrice(int.parse(totalPrice)));
  }

  void _onChangeTotalNum(String totalNum) {
    if (int.tryParse(totalNum) == null) return;
    context
        .read<EditTogetherBloc>()
        .add(EditTogetherChangeTotalNum(int.parse(totalNum)));
  }

  void _onTapComplete() {
    context.read<EditTogetherBloc>().add(EditTogetherSubmit());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditTogetherBloc, EditTogetherState>(
      listener: (context, state) {
        if (state.status == ELoadingStatus.error) {
          AppSnackbar.show(
            context,
            message: state.message ?? Strings.nullStr,
          );
        }
        if (state.status == ELoadingStatus.loaded) {
          context.pop<GoRouterExtraModel<int>>(GoRouterExtraModel(
            data: state.result,
          ));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const AppFont('공동구매글 수정'),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Gaps.v20,
              const EditTogetherImage(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Gaps.v20,
                    const AppFont(
                      '정보',
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w700,
                    ),
                    Gaps.v10,
                    AppTextFormField(
                      hintText: '공동 구매글 제목',
                      controller: _nameController,
                      onChange: _onChangeName,
                      hasNext: true,
                    ),
                    Gaps.v10,
                    AppTextFormField(
                      hintText: '설명',
                      singleLine: false,
                      controller: _detailsController,
                      onChange: _onChangeDetails,
                    ),
                    Gaps.v20,
                    const EditTogetherAge(),
                    Gaps.v20,
                    const EditTogetherCategory(),
                    Gaps.v20,
                    const EditTogetherTag(),
                    Gaps.v20,
                    const AppFont(
                      '구매 정보',
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w700,
                    ),
                    Gaps.v10,
                    AppTextFormField(
                      hintText: '판매 링크',
                      controller: _linkController,
                      onChange: _onChangeLink,
                      hasNext: true,
                    ),
                    Gaps.v10,
                    AppTextFormField(
                      hintText: '총 구매 가격',
                      controller: _totalPriceController,
                      keyboardType: TextInputType.number,
                      onChange: _onChangeTotalPrice,
                      hasNext: true,
                    ),
                    Gaps.v10,
                    AppTextFormField(
                      hintText: '총 구매 수량',
                      controller: _totalNumController,
                      keyboardType: TextInputType.number,
                      onChange: _onChangeTotalNum,
                    ),
                    Gaps.v20,
                    const EditTogetherDeadline(),
                    Gaps.v20,
                    const EditTogetherAddress(),
                  ],
                ),
              ),
              Gaps.v40,
            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<EditTogetherBloc, EditTogetherState>(
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
