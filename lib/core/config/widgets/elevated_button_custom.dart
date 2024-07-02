import 'package:flutter/material.dart';
import 'package:lets_buy/core/config/constant/constant.dart';

class ElevatedButtonCustom extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Color color;
  final Color textColor;
  const ElevatedButtonCustom(
      {Key? key, this.textColor = dark, required this.onPressed, required this.text, this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(color),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontFamily: font, fontWeight: FontWeight.w600, fontSize: 14),
          )),
    );
  }
}
