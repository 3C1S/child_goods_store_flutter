import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:flutter/material.dart';

class AppInkButton extends StatelessWidget {
  final Function()? onTap;
  final double borderRadSize;
  final Color? color;
  final Widget child;

  const AppInkButton({
    super.key,
    this.onTap,
    this.borderRadSize = Sizes.size10,
    this.color,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(borderRadSize),
      child: Ink(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
          horizontal: Sizes.size20,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadSize),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.2),
              blurRadius: Sizes.size3,
              spreadRadius: Sizes.size1,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
