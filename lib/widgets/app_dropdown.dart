import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:flutter/material.dart';

class AppDropdown extends StatelessWidget {
  final String? value;
  final List<String> values;
  final Function(String? value) onChanged;
  final String hint;
  final double? width;

  const AppDropdown({
    super.key,
    this.value,
    required this.values,
    required this.onChanged,
    required this.hint,
    this.width,
  });

  String? _valueCheck() {
    if (values.contains(value)) return value;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: Sizes.size1,
            spreadRadius: Sizes.size1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
        child: DropdownButton(
          isExpanded: width != null,
          underline: Container(),
          icon: const Icon(Icons.arrow_drop_down_rounded),
          value: _valueCheck(),
          menuMaxHeight: 300,
          style: const TextStyle(
            fontSize: Sizes.size12,
            color: Colors.black,
          ),
          hint: AppFont(hint),
          items: [
            for (var value in values)
              DropdownMenuItem(
                value: value,
                child: AppFont(value),
              ),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
