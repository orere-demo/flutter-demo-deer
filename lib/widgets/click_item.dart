import 'package:flutter/material.dart';

class ClickItem extends StatelessWidget {
  const ClickItem(
      {Key? key,
      this.onTap,
      this.content = '',
      this.textAlign = TextAlign.start,
      this.maxLines = 1,
      required this.title})
      : super(key: key);

  final GestureTapCallback? onTap;
  final String title;
  final String content;
  final TextAlign textAlign;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(''),
    );
  }
}
