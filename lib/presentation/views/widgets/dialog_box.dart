import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:psgames/presentation/views/widgets/text_view.dart';

class DialogBox extends StatelessWidget {
  final String? text;
  const DialogBox({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.black),
      child: Center(
        child: TextView(
          text: text ?? '',
          fontWeight: FontWeight.bold,
          textColor: Colors.white,
        ),
      ),
    );
  }
}
