import 'package:child_goods_store_flutter/constants/gaps.dart';
import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/constants/strings.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String? profileImg;
  final double? width;
  final double? height;

  const AppNetworkImage({
    super.key,
    this.profileImg,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(),
      clipBehavior: Clip.hardEdge,
      child: profileImg == null || profileImg == Strings.nullStr
          ? Center(
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.image_not_supported_rounded,
                      size: Sizes.size40,
                      color: Colors.black87.withOpacity(0.5),
                    ),
                    Gaps.v10,
                    AppFont(
                      '제공되는 이미지가\n없습니다 :(',
                      textAlign: TextAlign.center,
                      fontSize: Sizes.size10,
                      color: Colors.black87.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            )
          : Image.network(
              profileImg!,
              fit: BoxFit.cover,
              width: width,
              height: height,
              errorBuilder: (context, error, stackTrace) => Center(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.image_not_supported_rounded,
                        size: Sizes.size40,
                        color: Colors.black87.withOpacity(0.5),
                      ),
                      Gaps.v10,
                      AppFont(
                        '제공되는 이미지가\n없습니다 :(',
                        textAlign: TextAlign.center,
                        fontSize: Sizes.size10,
                        color: Colors.black87.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
