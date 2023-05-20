import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipely/src/extensions/extensions.dart';

/// Common Text Field Widget
/// With complete validation & parameters for app level usage

class RecipelyTextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool? obscureText;
  final Function(String)? onChange, onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final Widget prefixWidget, suffixWidget;
  final String? Function(String?)? onValidate;

  const RecipelyTextFieldWidget({
    Key? key,
    required this.textEditingController,
    required this.focusNode,
    required this.textInputType,
    required this.textInputAction,
    this.obscureText,
    this.onChange,
    this.onSubmitted,
    this.inputFormatters,
    required this.prefixWidget,
    required this.suffixWidget,
    required this.onValidate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      cursorColor: HexColor("#00838f"),
      obscureText: obscureText ?? false,
      inputFormatters: inputFormatters,
      onChanged: onChange,
      cursorWidth: 0.5,
      validator: onValidate,
      onFieldSubmitted: onSubmitted,
      style: TextStyle(
        color: HexColor("#3a3b35"),
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: HexColor("#3a3b35").withOpacity(0.3),
            width: 0.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: HexColor("#FF0000").withOpacity(0.3),
            width: 0.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: HexColor("#3a3b35"),
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: HexColor("#3a3b35"),
            width: 0.5,
          ),
        ),
        isDense: true,
//          isCollapsed: true,
        prefixIcon: prefixWidget,
        suffixIcon: suffixWidget,
      ),
    );
  }
}
