import 'package:flutter/material.dart';

class Hatapage extends StatelessWidget {
  const Hatapage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Sayfa Bunumadı"),
        ),
      ),
    );
  }
}
