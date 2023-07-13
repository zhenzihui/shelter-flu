import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts/colors.dart';

inputWithLabel(String label, { Icon? icon , ValueChanged<String>? onChange }) {
  return Column(children: [
    Row(children: [
      icon??const Spacer(),
      Text(label)
    ],),
    CupertinoTextField(
      onChanged: onChange,

    )
  ],);
}

positiveButton(String text, {Size? minimumSize, VoidCallback? onPressed, backgroundColor = loginBtnBg}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
        backgroundColor: loginBtnBg,
        minimumSize: minimumSize,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    child: Text(
      text,
      style: const TextStyle(fontSize: 14, color: plainText),
    ),
  );
}