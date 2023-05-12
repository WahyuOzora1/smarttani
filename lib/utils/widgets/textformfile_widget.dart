import 'package:flutter/material.dart';
import 'package:smarttaniapp/utils/constant/color.dart';

InputDecoration textFieldStyle(
    {String labelTextStr = "", String hintTextStr = ""}) {
  return InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      labelText: labelTextStr,
      hintText: hintTextStr,
      labelStyle: const TextStyle(color: Color.fromARGB(255, 90, 89, 89)),
      fillColor: formColor,
      filled: true,
      focusColor: primaryColor,
      hoverColor: primaryColor,
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ));
}
