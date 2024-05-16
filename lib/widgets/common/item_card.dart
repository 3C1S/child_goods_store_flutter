import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/routes.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/enums/chat_item_type.dart';
import 'package:child_goods_store_flutter/models/product/product_model.dart';
import 'package:child_goods_store_flutter/models/together/together_model.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:child_goods_store_flutter/widgets/app_ink_button.dart';
import 'package:child_goods_store_flutter/widgets/app_network_image.dart';
import 'package:child_goods_store_flutter/utils/other_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemCard extends StatelessWidget {
  final ProductModel? product;
  final TogetherModel? together;

  /// type == null -> Loading state \
  /// type != null -> Corresponded model required
  final EChatItemType? type;

  const ItemCard({
    super.key,
    this.product,
    this.together,
    this.type,
  }) : assert(type == null ||
            (type == EChatItemType.product && product != null) ||
            (type == EChatItemType.together && together != null));

  void _onTap(BuildContext context) {
    if (type == EChatItemType.product) {
      context.push('${Routes.productDetail}/${product?.productId}');
    }
    if (type == EChatItemType.together) {
      context.push('${Routes.togetherDetail}/${together?.togetherId}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppInkButton(
      borderRadSize: 0,
      padding: EdgeInsets.zero,
      onTap: () => _onTap(context),
      color: Colors.black12,
      shadowColor: Colors.transparent,
      child: SizedBox(
        height: Sizes.size80,
        child: type == EChatItemType.product
            ? _buildProduct(context)
            : type == EChatItemType.together
                ? _buildTogether(context)
                : _buildLoading(context),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildProduct(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: Sizes.size80,
          height: Sizes.size80,
          child: AppNetworkImage(
            profileImg: product?.productImage.first,
          ),
        ),
        Gaps.h10,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppFont(product?.productName ?? Strings.nullStr),
              AppFont('${product?.price?.price() ?? "-"}원'),
            ],
          ),
        ),
        Gaps.h10,
        const Icon(Icons.keyboard_arrow_right_rounded),
        Gaps.h10,
      ],
    );
  }

  Widget _buildTogether(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: Sizes.size80,
          height: Sizes.size80,
          child: AppNetworkImage(
            profileImg: together?.togetherImage.first,
          ),
        ),
        Gaps.h10,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppFont(together?.togetherName ?? Strings.nullStr),
              AppFont(
                  '${together?.totalPrice?.price() ?? "-"} (${together?.purchasePrice?.price() ?? "-"})원'),
              AppFont(together?.deadline.toString().split(' ').first ??
                  Strings.nullStr),
            ],
          ),
        ),
        Gaps.h10,
        const Icon(Icons.keyboard_arrow_right_rounded),
        Gaps.h10,
      ],
    );
  }
}
