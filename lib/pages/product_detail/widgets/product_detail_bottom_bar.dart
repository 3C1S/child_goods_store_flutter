import 'package:child_goods_store_flutter/blocs/auth/auth_bloc_singleton.dart';
import 'package:child_goods_store_flutter/blocs/product/buyer/product_buyer_bloc.dart';
import 'package:child_goods_store_flutter/blocs/product/buyer/product_buyer_event.dart';
import 'package:child_goods_store_flutter/blocs/product/detail/product_detail_bloc.dart';
import 'package:child_goods_store_flutter/blocs/product/detail/product_detail_event.dart';
import 'package:child_goods_store_flutter/blocs/product/detail/product_detail_state.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/routes.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/loading_status.dart';
import 'package:child_goods_store_flutter/enums/product_sale_state.dart';
import 'package:child_goods_store_flutter/models/go_router_extra_model.dart';
import 'package:child_goods_store_flutter/models/product/product_model.dart';
import 'package:child_goods_store_flutter/pages/product_detail/widgets/product_detail_buyer_list.dart';
import 'package:child_goods_store_flutter/repositories/interface/product_repository_interfave.dart';
import 'package:child_goods_store_flutter/widgets/app_bottom_sheet.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:child_goods_store_flutter/utils/other_extensions.dart';

class ProductDetailBottomBar extends StatefulWidget {
  const ProductDetailBottomBar({super.key});

  @override
  State<ProductDetailBottomBar> createState() => _ProductDetailBottomBarState();
}

class _ProductDetailBottomBarState extends State<ProductDetailBottomBar> {
  void _onTapChangeStatus({
    required ProductBuyerBloc bloc,
  }) {
    AppBottomSheet.show(
      context,
      applyBottomPadding: true,
      child: Material(
        child: Column(
          children: [
            for (var status in EProductSaleState.values)
              AppInkButton(
                color: Colors.transparent,
                shadowColor: Colors.transparent,
                onTap: () => _onTapChangeStatusItem(
                  status: status,
                  bloc: bloc,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: AppFont(
                      status.text,
                      color: status ==
                              context
                                  .read<ProductDetailBloc>()
                                  .state
                                  .productModel
                                  ?.state
                          ? Theme.of(context).primaryColor
                          : null,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _onTapChangeStatusItem({
    required EProductSaleState status,
    required ProductBuyerBloc bloc,
  }) {
    if (status != EProductSaleState.soldout) {
      context
          .read<ProductDetailBloc>()
          .add(ProductDetailChangeSaleState(status));
      context.pop();
    } else {
      context.pop();
      bloc.add(ProductBuyerGet());
      AppBottomSheet.showList(
        context,
        builder: (_, controller) => ProductDetailBuyerList(
          controller: controller,
          bloc: bloc,
          onSelectBuyer: (userId) => _onSelectBuyer(userId),
        ),
      );
    }
  }

  void _onSelectBuyer(int userId) {
    context.read<ProductDetailBloc>().add(ProductDetailChangeSaleState(
          EProductSaleState.soldout,
          userId: userId,
        ));
    context.pop();
  }

  void _onTapEditProduct() async {
    var res = await context.push<GoRouterExtraModel<int>>(
      Routes.editProduct,
      extra: GoRouterExtraModel<ProductModel>(
        data: context.read<ProductDetailBloc>().state.productModel,
      ),
    );

    if (res?.data != null && mounted) {
      context.read<ProductDetailBloc>().add(ProductDetailGet());
    }
  }

  void _onTapChat() {}

  bool _iamSaler(ProductDetailState state) {
    return AuthBlocSingleton.bloc.state.user?.userId ==
        state.productModel?.user?.userId;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBuyerBloc(
        productRepository: context.read<IProductRepository>(),
        productId:
            context.read<ProductDetailBloc>().state.productModel!.productId!,
      ),
      child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state.productStatus != ELoadingStatus.loaded) {
            return SizedBox(
              height: MediaQuery.viewPaddingOf(context).bottom,
            );
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
                      '${state.productModel?.price?.price()} 원',
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.h10,
                  if (_iamSaler(state))
                    AppInkButton(
                      onTap: state.changeSaleStatus == ELoadingStatus.loading
                          ? null
                          : () => _onTapChangeStatus(
                                bloc: context.read<ProductBuyerBloc>(),
                              ),
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size10,
                        horizontal: Sizes.size14,
                      ),
                      child: SizedBox(
                        height: Sizes.size20,
                        child: Center(
                          child:
                              state.changeSaleStatus == ELoadingStatus.loading
                                  ? const SizedBox(
                                      width: Sizes.size16,
                                      height: Sizes.size16,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const AppFont(
                                      '상태 변경',
                                      color: Colors.white,
                                    ),
                        ),
                      ),
                    ),
                  if (!_iamSaler(state))
                    Padding(
                      padding: const EdgeInsets.only(right: Sizes.size20),
                      child: AppFont(
                        state.productModel?.state?.text ?? Strings.nullStr,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  Gaps.h10,
                  AppInkButton(
                    onTap: _iamSaler(state) ? _onTapEditProduct : _onTapChat,
                    padding: const EdgeInsets.symmetric(
                      vertical: Sizes.size10,
                      horizontal: Sizes.size14,
                    ),
                    child: AppFont(
                      _iamSaler(state) ? '수정하기' : '채팅하기',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
