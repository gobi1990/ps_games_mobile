import 'package:flutter/material.dart';
import 'package:psgames/constants/font_family.dart';

class TextView extends StatelessWidget {
  final String text;
  final double? fontSize;
  final double? marginTop;
  final Color? textColor;
  final FractionalOffset? alignment;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextStyle? textStyle;
  final TextOverflow? overflow;
  final String? fontFamily;

  const TextView(
      {Key? key,
      required this.text,
      this.textColor,
      this.fontSize,
      this.marginTop,
      this.fontWeight,
      this.alignment,
      this.textAlign,
      this.maxLines,
      this.overflow,
      this.textStyle,
      this.fontFamily})
      :
        //assert(textStyle != null && fontWeight != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment ?? FractionalOffset.center,
      margin: EdgeInsets.only(top: marginTop ?? 0),
      child: Text(
        text,
        maxLines: maxLines,
        overflow: overflow,
        style: textStyle ??
            TextStyle(
                fontWeight: fontWeight ?? FontWeight.normal,
                color: textColor ?? Colors.black,
                fontSize: fontSize ?? 14,
                fontFamily: fontFamily ?? FontFamily.poppins),
        textAlign: textAlign ?? TextAlign.center,
      ),
    );
  }
}
