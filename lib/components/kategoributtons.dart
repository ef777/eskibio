import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'media.dart';

class CategoryButton extends StatelessWidget {
  var icon;
  final String name;
  final void Function() onTap;
  CategoryButton(
      {Key? key, required this.icon, required this.name, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Padding(
      padding: const EdgeInsets.only(right: 25),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF81C242),
              ),
              child: Container(child: icon),
            ),
            Container(
                color: Colors.white60.withOpacity(0.6),
                width: 45,
                height: 25,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 10),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
