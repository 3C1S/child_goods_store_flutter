import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:flutter/material.dart';

class AppInkButton extends StatelessWidget {
  final Function()? onTap;
  final double borderRadSize;
  final Color? color;
  final Widget child;
  final EdgeInsets padding;
  final Color? shadowColor;

  const AppInkButton({
    super.key,
    this.onTap,
    this.borderRadSize = Sizes.size10,
    this.color,
    required this.child,
    this.padding = const EdgeInsets.symmetric(
      vertical: Sizes.size10,
      horizontal: Sizes.size20,
    ),
    this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          padding: padding,
          decoration: BoxDecoration(
            color: color ?? Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(borderRadSize),
            boxShadow: [
              BoxShadow(
                color: shadowColor ??
                    Theme.of(context).shadowColor.withOpacity(0.1),
                blurRadius: Sizes.size3,
                spreadRadius: Sizes.size1,
              ),
            ],
          ),
          child: child,
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                // Delay for button ink animation
                await Future.delayed(const Duration(milliseconds: 100));
                onTap?.call();
              },
              highlightColor: Colors.transparent,
              splashColor: Theme.of(context).splashColor,
              borderRadius: BorderRadius.circular(borderRadSize),
            ),
          ),
        ),
      ],
    );
  }
}
