import 'package:child_goods_store_flutter/blocs/edit_review/edit_review_bloc.dart';
import 'package:child_goods_store_flutter/blocs/edit_review/edit_review_event.dart';
import 'package:child_goods_store_flutter/blocs/edit_review/edit_review_state.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/models/go_router_extra_model.dart';
import 'package:child_goods_store_flutter/models/review/review_model.dart';
import 'package:child_goods_store_flutter/pages/edit_review/widgets/edit_review_stars.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:child_goods_store_flutter/widgets/app_snackbar.dart';
import 'package:child_goods_store_flutter/widgets/app_text_form_field.dart';
import 'package:child_goods_store_flutter/widgets/common/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditReviewPage extends StatefulWidget {
  const EditReviewPage({super.key});

  @override
  State<EditReviewPage> createState() => _EditReviewPageState();
}

class _EditReviewPageState extends State<EditReviewPage> {
  late final TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(
      text: context.read<EditReviewBloc>().state.review.content,
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  void _onTapRetryGetItem(BuildContext context) {
    context.read<EditReviewBloc>().add(EditReviewGetItem());
  }

  void _onChangeContent(String content) {
    context.read<EditReviewBloc>().add(EditReviewChangeContent(content));
    _contentController.text = content;
  }

  void _onTapComplete() {
    context.read<EditReviewBloc>().add(EditReviewSubmit());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditReviewBloc, EditReviewState>(
      listener: (context, state) {
        if (state.status == ELoadingStatus.error &&
            state.reviewStatus == ELoadingStatus.error) {
          AppSnackbar.show(
            context,
            message: state.message ?? Strings.unknownFail,
          );
        }
        if (state.status == ELoadingStatus.loaded &&
            state.reviewStatus == ELoadingStatus.loaded) {
          context.pop<GoRouterExtraModel<ReviewModel>>(GoRouterExtraModel(
            data: state.review.copyWith(
              id: context.read<EditReviewBloc>().id,
              type: context.read<EditReviewBloc>().type,
            ),
          ));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const AppFont('후기 수정'),
          centerTitle: false,
        ),
        body: BlocBuilder<EditReviewBloc, EditReviewState>(
          builder: (context, state) {
            if (state.targetStatus == ELoadingStatus.error) {
              return _buildError(
                message: state.message ?? Strings.unknownFail,
              );
            }
            return _buildBody(state);
          },
        ),
        bottomNavigationBar: BlocBuilder<EditReviewBloc, EditReviewState>(
          builder: (context, state) {
            if (state.targetStatus != ELoadingStatus.loaded) {
              return const SizedBox();
            }
            return AppInkButton(
              onTap: state.reviewStatus == ELoadingStatus.loading
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
                  child: state.reviewStatus == ELoadingStatus.loading
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

  Widget _buildBody(EditReviewState state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ItemCard(
            product: state.targetProduct,
            together: state.targetTogether,
            type: state.targetStatus != ELoadingStatus.loaded
                ? null
                : context.read<EditReviewBloc>().type,
          ),
          Gaps.v32,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const EditReviewStars(),
                Gaps.v32,
                AppTextFormField(
                  hintText: '리뷰',
                  singleLine: false,
                  controller: _contentController,
                  onChange: _onChangeContent,
                ),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                ),
                Gaps.v10,
                _reviewPresetButton(
                  text: '소통이 원활했어요',
                  isPro: true,
                ),
                _reviewPresetButton(
                  text: '상품이 명시된 상태보다 좋아요',
                  isPro: true,
                ),
                _reviewPresetButton(
                  text: '거래가 원활했어요',
                  isPro: true,
                ),
                _reviewPresetButton(
                  text: '소통이 잘 안돼요',
                  isPro: false,
                ),
                _reviewPresetButton(
                  text: '상품이 명시된 상태보다 별로예요',
                  isPro: false,
                ),
                _reviewPresetButton(
                  text: '거래가 힘들었어요',
                  isPro: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError({
    required String message,
  }) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppFont(message),
          Gaps.v20,
          AppInkButton(
            onTap: () => _onTapRetryGetItem(context),
            child: const AppFont(
              '재시도',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _reviewPresetButton({
    required String text,
    required bool isPro,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: Sizes.size10),
      child: AppInkButton(
        padding: EdgeInsets.zero,
        color: Colors.transparent,
        shadowColor: Colors.transparent,
        onTap: () => _onChangeContent(text),
        child: Container(
          padding: const EdgeInsets.all(Sizes.size10),
          decoration: BoxDecoration(
            border: Border.all(color: isPro ? Colors.green : Colors.red),
            borderRadius: BorderRadius.circular(Sizes.size10),
          ),
          child: Center(
            child: AppFont(text),
          ),
        ),
      ),
    );
  }
}
