import 'package:child_goods_store_flutter/blocs/edit_product/edit_product_bloc.dart';
import 'package:child_goods_store_flutter/blocs/edit_product/edit_product_event.dart';
import 'package:child_goods_store_flutter/blocs/edit_product/edit_product_state.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/models/go_router_extra_model.dart';
import 'package:child_goods_store_flutter/pages/edit_product/widgets/edit_product_age.dart';
import 'package:child_goods_store_flutter/pages/edit_product/widgets/edit_product_status.dart';
import 'package:child_goods_store_flutter/pages/edit_product/widgets/edit_product_category.dart';
import 'package:child_goods_store_flutter/pages/edit_product/widgets/edit_product_image.dart';
import 'package:child_goods_store_flutter/pages/edit_product/widgets/edit_product_tag.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:child_goods_store_flutter/widgets/app_snackbar.dart';
import 'package:child_goods_store_flutter/widgets/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late final TextEditingController _nameController;
  late final TextEditingController _contentController;
  late final TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: context.read<EditProductBloc>().state.product.productName,
    );
    _contentController = TextEditingController(
      text: context.read<EditProductBloc>().state.product.content,
    );
    _priceController = TextEditingController(
      text: context.read<EditProductBloc>().state.product.price?.toString(),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contentController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _onChangeName(String name) {
    context.read<EditProductBloc>().add(EditProductChangeName(name));
  }

  void _onChangeContent(String content) {
    context.read<EditProductBloc>().add(EditProductChangeContent(content));
  }

  void _onChangePrice(String price) {
    if (int.tryParse(price) == null) return;
    context
        .read<EditProductBloc>()
        .add(EditProductChangePrice(int.parse(price)));
  }

  void _onTapComplete() {
    context.read<EditProductBloc>().add(EditProductSubmit());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProductBloc, EditProductState>(
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
          title: const AppFont('상품 정보 수정'),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Gaps.v20,
              const EditProductImage(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Gaps.v20,
                    const AppFont(
                      '상품 정보',
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w700,
                    ),
                    Gaps.v10,
                    AppTextFormField(
                      hintText: '상품명',
                      controller: _nameController,
                      onChange: _onChangeName,
                      hasNext: true,
                    ),
                    Gaps.v10,
                    AppTextFormField(
                      hintText: '설명',
                      singleLine: false,
                      controller: _contentController,
                      onChange: _onChangeContent,
                    ),
                    Gaps.v10,
                    AppTextFormField(
                      hintText: '가격',
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      onChange: _onChangePrice,
                    ),
                    Gaps.v20,
                    const EditProductAge(),
                    Gaps.v20,
                    const EditProductStatus(),
                    Gaps.v20,
                    const EditProductCategory(),
                    Gaps.v20,
                    const EditProductTag(),
                  ],
                ),
              ),
              Gaps.v40,
            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<EditProductBloc, EditProductState>(
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
