import 'package:flutter/material.dart';

class Kanalbutton extends StatelessWidget {
  final String baslik;
  final VoidCallback onpress;
  final IconData? kanalIcon;
  final Color btnColor;
  const Kanalbutton(
      {Key? key,
      this.baslik = "",
      required this.onpress,
      this.kanalIcon,
      required this.btnColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: btnColor,
            child: Icon(
              kanalIcon,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            baslik,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          ),
        ],
      ),
    );
  }
}
