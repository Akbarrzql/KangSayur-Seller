import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common/color_value.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    this.textInputType = TextInputType.text,
    this.maxLines = 1,
    this.isPassword = false,
    this.validator,
    required this.controller,
    this.onChanged,
    this.width = 343,
    this.inputFormatters,
  });

  final String label;
  final TextInputType textInputType;
  final int maxLines;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final int width;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: widget.width.toDouble(),
      child: TextFormField(
        inputFormatters: widget.inputFormatters,
        controller: widget.controller,
        keyboardType: widget.textInputType,
        maxLines: widget.maxLines,
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: widget.isPassword ? _isPasswordVisible : false,
        autocorrect: !widget.isPassword,
        enableSuggestions: !widget.isPassword,
        onChanged: widget.onChanged,
        style: textTheme.labelLarge,
        decoration: InputDecoration(
          hintText: widget.label,
          hintStyle: textTheme.bodyMedium,
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18,
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    color: ColorValue.primaryColor,
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 0.5,
              color: ColorValue.hintColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 0.5,
              color: ColorValue.hintColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 2,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
