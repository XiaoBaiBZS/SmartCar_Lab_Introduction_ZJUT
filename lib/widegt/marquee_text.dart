/**
 *@Author: ZhanshuoBai
 *@CreateTime: 2025-06-15
 *@Description:
 *@Version: 1.0
 */

import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

typedef MarqueeBuilder = Marquee Function(
    BuildContext context, String text, TextStyle textStyle);
typedef TextBuilder = Text Function(
    BuildContext context, String text, TextStyle textStyle);

class MarqueeText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final double containerWidth;
  final TextBuilder textBuilder;
  final MarqueeBuilder marqueeBuilder;

  const MarqueeText(
      {Key? key,
        required this.marqueeBuilder,
        required this.textBuilder,
        required this.text,
        required this.textStyle,
        required this.containerWidth})
      : super(key: key);

  Size calculateTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    final textWidth = this.calculateTextSize(this.text, this.textStyle).width;
    return textWidth < this.containerWidth
        ? this.textBuilder(context, text, textStyle)
        : this.marqueeBuilder(context, text, textStyle);
  }
}
