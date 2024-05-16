import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:flutter/material.dart';

class TagContainer extends StatelessWidget {
  final String tag;

  const TagContainer({
    super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Sizes.size10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AppFont(
              '#',
              fontWeight: FontWeight.w900,
              fontSize: Sizes.size18,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Gaps.h3,
          AppFont(tag),
        ],
      ),
    );
  }
}
