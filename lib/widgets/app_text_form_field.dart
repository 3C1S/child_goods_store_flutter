import 'package:child_goods_store_flutter/constants/sizes.dart';
import 'package:child_goods_store_flutter/widgets/app_font.dart';
import 'package:flutter/material.dart';

class AppTextFormField extends StatefulWidget {
  final String? hintText;
  final Function(String value)? onChange;
  final Function(String value)? onFieldSubmitted;
  final bool singleLine;
  final bool expanded;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool hasNext;
  final bool obscureText;
  final bool? enabled;
  final String? suffixText;
  final Color? enableBorderColor;
  final Color? focusBorderColor;

  const AppTextFormField({
    super.key,
    this.hintText,
    this.onChange,
    this.onFieldSubmitted,
    this.singleLine = true,
    this.expanded = false,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.hasNext = false,
    this.obscureText = false,
    this.enabled,
    this.suffixText,
    this.enableBorderColor,
    this.focusBorderColor,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onChange(String value) {
    widget.onChange?.call(value);
  }

  void _unfocus() {
    if (widget.focusNode == null) {
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      textInputAction: widget.hasNext ? TextInputAction.next : null,
      autocorrect: false,
      onTapOutside: (_) => _unfocus(),
      onChanged: _onChange,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.focusBorderColor ?? Theme.of(context).primaryColor,
            width: Sizes.size2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.enableBorderColor ?? Colors.grey.shade200,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: Sizes.size5,
          horizontal: Sizes.size10,
        ),
        hintText: widget.hintText,
        suffix: widget.suffixText != null ? AppFont(widget.suffixText!) : null,
      ),
      style: const TextStyle(
        fontSize: Sizes.size14,
      ),
      textAlign: widget.suffixText != null ? TextAlign.right : TextAlign.left,
      obscureText: widget.obscureText,
      cursorRadius: const Radius.circular(Sizes.size5),
      keyboardType: widget.keyboardType ??
          (widget.singleLine ? null : TextInputType.multiline),
      maxLines: widget.singleLine ? 1 : null,
      expands: widget.expanded,
      enabled: widget.enabled,
    );
  }
}
