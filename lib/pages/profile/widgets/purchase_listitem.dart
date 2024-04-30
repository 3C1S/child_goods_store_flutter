import 'package:child_goods_store_flutter/blocs/profile/profile_tab_bloc.dart';
import 'package:child_goods_store_flutter/blocs/profile/profile_tab_event.dart';
import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/routes.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/chat_item_type.dart';
import 'package:child_goods_store_flutter/models/go_router_extra_model.dart';
import 'package:child_goods_store_flutter/models/purchase/purchase_model.dart';
import 'package:child_goods_store_flutter/models/review/review_model.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:child_goods_store_flutter/widgets/app_network_image.dart';
import 'package:child_goods_store_flutter/utils/other_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PurchaseListItem extends StatefulWidget {
  final PurchaseModel purchase;

  const PurchaseListItem({
    super.key,
    required this.purchase,
  });

  @override
  State<PurchaseListItem> createState() => _PurchaseListItemState();
}

class _PurchaseListItemState extends State<PurchaseListItem> {
  void _pushItem() {
    if (widget.purchase.category == EChatItemType.product) {
      context.push('${Routes.productDetail}/${widget.purchase.id}');
    }
    if (widget.purchase.category == EChatItemType.together) {
      context.push('${Routes.togetherDetail}/${widget.purchase.id}');
    }
  }

  void _pushReview() async {
    var res = await context.push<GoRouterExtraModel<ReviewModel>>(
      Routes.editReview,
      extra: GoRouterExtraModel<ReviewModel>(
        itemId: widget.purchase.id,
        itemType: widget.purchase.category,
      ),
    );

    // Update puchase item's isReview
    if (res?.data?.id != null && mounted) {
      if (res?.data?.type == EChatItemType.product) {
        context
            .read<ProfileTabBloc>()
            .add(ProfileTabProductReviewed(res!.data!.id!));
      }
      if (res?.data?.type == EChatItemType.together) {
        context
            .read<ProfileTabBloc>()
            .add(ProfileTabTogetherReviewed(res!.data!.id!));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(Sizes.size10),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.1),
            blurRadius: Sizes.size3,
            spreadRadius: Sizes.size1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 150,
            child: AppInkButton(
              onTap: _pushItem,
              padding: const EdgeInsets.all(Sizes.size5),
              borderRadSize: 0,
              color: Colors.transparent,
              shadowColor: Colors.transparent,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizes.size5),
                      ),
                      child: AppNetworkImage(
                        profileImg: widget.purchase.image,
                        height: 150,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size10,
                      ),
                      decoration: const BoxDecoration(),
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Gaps.v5,
                            AppFont(
                              widget.purchase.title ?? Strings.nullStr,
                              maxLine: 1,
                            ),
                            Gaps.v5,
                            const AppFont(
                              '구매가',
                              fontSize: Sizes.size7,
                            ),
                            AppFont(
                              '${widget.purchase.price?.price()}원',
                              fontWeight: FontWeight.w700,
                            ),
                            const AppFont(
                              '판매자',
                              fontSize: Sizes.size7,
                            ),
                            AppFont(
                              widget.purchase.sellerName ?? Strings.nullStr,
                              maxLine: 1,
                            ),
                            const AppFont(
                              '거래일',
                              fontSize: Sizes.size7,
                            ),
                            AppFont(widget.purchase.saleCompleteDate
                                .toString()
                                .split(' ')
                                .first),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: Sizes.size5),
                      child: Icon(
                        Icons.keyboard_arrow_right_rounded,
                        color: Colors.black87.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (widget.purchase.isReview != true)
            AppInkButton(
              onTap: _pushReview,
              borderRadSize: 0,
              child: const AppFont(
                '후기 남기기',
                color: Colors.white,
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
