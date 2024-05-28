import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class NotificationListItem extends StatefulWidget {
  final String title;
  final bool onState;
  final Function(bool) onChanged;

  const NotificationListItem({
    super.key,
    required this.title,
    required this.onState,
    required this.onChanged,
  });

  @override
  State<NotificationListItem> createState() => _NotificationListItemState();
}

class _NotificationListItemState extends State<NotificationListItem> {
  late final ValueNotifier<bool> _controller;

  @override
  void initState() {
    super.initState();
    _controller = ValueNotifier(widget.onState);
  }

  @override
  void didUpdateWidget(covariant NotificationListItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.onState != widget.onState) {
      _controller.value = widget.onState;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppFont(widget.title),
          AdvancedSwitch(
            controller: _controller,
            initialValue: widget.onState,
            onChanged: (value) {
              _controller.value = value;
              widget.onChanged.call(value);
            },
            height: Sizes.size24,
          ),
        ],
      ),
    );
  }
}
