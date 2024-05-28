import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:flutter/material.dart';

class AppBottomSheet extends BottomSheet {
  const AppBottomSheet({
    super.key,
    required super.onClosing,
    required super.builder,
  });

  static show(
    BuildContext context, {
    required Widget child,
    bool applyBottomPadding = false,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: EdgeInsets.only(
          bottom: Sizes.size20 +
              (applyBottomPadding
                  ? MediaQuery.viewPaddingOf(context).bottom
                  : 0),
          left: Sizes.size20,
          right: Sizes.size20,
        ),
        padding: const EdgeInsets.only(
          left: Sizes.size20,
          right: Sizes.size20,
          bottom: Sizes.size10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Sizes.size20),
        ),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.remove,
              color: Theme.of(context).primaryColor,
            ),
            child,
          ],
        ),
      ),
    );
  }

  static showList(
    BuildContext context, {
    required Widget Function(
      BuildContext context,
      ScrollController controller,
    ) builder,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewPaddingOf(context).bottom + Sizes.size20,
            left: Sizes.size20,
            right: Sizes.size20,
          ),
          child: DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.2,
            maxChildSize: 0.75,
            expand: false,
            builder: (_, controller) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Sizes.size20),
                ),
                clipBehavior: Clip.hardEdge,
                child: Material(
                  child: Column(
                    children: [
                      Icon(
                        Icons.remove,
                        color: Theme.of(context).primaryColor,
                      ),
                      Expanded(
                        child: builder(
                          context,
                          controller,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
