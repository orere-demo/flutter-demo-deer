import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:demo2_deer/res/resources.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {Key? key,
      this.text = '',
      this.fontSize = Dimens.font_sp18,
      this.textColor})
      : super(key: key);

  final String text;
  final double fontSize;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {},
        child: Text(text, style: TextStyle(fontSize: fontSize)));
  }
}
