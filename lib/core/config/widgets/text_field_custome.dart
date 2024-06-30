import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';

class TextFieldCustom extends StatelessWidget {
  int? maxLine = 1;
  final String text;
  final TextEditingController controller;
  final IconData? icon;
  TextInputType? keyboardType;
  void Function(String)? onChanged;
  TextFieldCustom(
      {Key? key,
      required this.text,
      required this.controller,
      this.icon,
      this.keyboardType = TextInputType.text,
      this.maxLine,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: dark,
        fontFamily: font,
        fontSize: 12,
      ),
      controller: controller,
      enableSuggestions: true,
      decoration: InputDecoration(
          fillColor: gray,
          filled: true,
          hintStyle: const TextStyle(color: gray, fontFamily: font, fontSize: 16, fontWeight: FontWeight.normal),
          suffixIcon: Icon(
            icon,
            color: dark,
          ),
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: gray),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: gray),
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: text,
          iconColor: dark,
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          errorStyle: const TextStyle(height: 0),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: purple, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          labelStyle:
              const TextStyle(color: Colors.grey, fontFamily: font, fontSize: 16, fontWeight: FontWeight.normal)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}
