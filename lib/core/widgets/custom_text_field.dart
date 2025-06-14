import 'package:flutter/material.dart';

import '../theming/color_manager.dart';
import '../theming/styles_manager.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final Color? hintColor;
  final int? maxLines;
  final int? maxLength;
  final bool? readOnly;
  final bool isPassword;
  final Color? suffixColor;
  final Color? prefixColor;
  final Color? fillColor;
  final Color? typingColor;
  final Color borderColor;
  final String? prefixIcon;
  final double borderRadius;
  final double? hintFontSize;
  final String? suffixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final TextInputAction textInputAction;
  final void Function(String)? onSubmitted;

  const CustomTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.maxLength,
    this.readOnly,
    this.maxLines,
    this.borderRadius = 6,
    this.hintColor,
    this.hintFontSize,
    this.fillColor,
    this.borderColor = Colors.white,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.onTap,
    this.textInputAction = TextInputAction.done,
    this.suffixColor = Colors.black,
    this.prefixColor = Colors.black,
    this.isPassword = false,
    this.typingColor, this.onSubmitted ,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: ColorManager.orangeColor,
      maxLength: widget.maxLength,
      readOnly: widget.readOnly ?? false,
      maxLines: widget.isPassword ? 1 : widget.maxLines,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? _obscureText : false,
      onTap: widget.onTap,
      textInputAction: widget.textInputAction,
      style:  TextStyle(color: widget.typingColor ?? Colors.black, fontSize: 17),
      decoration: InputDecoration(
        counterText: '',
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        hintStyle: Styles.textStyle14w4.copyWith(
          color: widget.hintColor ?? Colors.black,
          fontSize: widget.hintFontSize,
        ),
        labelStyle: Styles.textStyle14w5,
        fillColor: widget.fillColor ?? ColorManager.grey3,
        prefixIconConstraints: const BoxConstraints(),
        filled: true,
        prefixIcon:
        widget.prefixIcon != null
            ? Padding(
          padding: const EdgeInsets.only(left: 15),
          child: ImageIcon(
            AssetImage(widget.prefixIcon!),
            color: widget.prefixColor,
            size: 20,
          ),
        )
            : const SizedBox(width: 10),

        suffixIcon:
        widget.isPassword
            ? IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: widget.suffixColor,
          ),
        )
            : (widget.suffixIcon != null
            ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ImageIcon(
            AssetImage(widget.suffixIcon!),
            color: widget.suffixColor,
          ),
        )
            : null),

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.grey),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
    );
  }
}
