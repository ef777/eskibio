import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final Color bgcolor, textColor;
  final VoidCallback onpress;
  final String btnText;
  final dynamic whidth;
  const Buttons(
      {Key? key,
      this.whidth,
      required this.btnText,
      required this.onpress,
      this.textColor = Colors.black,
      this.bgcolor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        width: whidth,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: bgcolor,
        ),
        child: Text(
          btnText,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
          textAlign: TextAlign.center,
        ),
      ),
      onTap: onpress,
    );
  }
}
