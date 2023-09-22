import 'dart:convert';

import 'package:biorganikpazar/config/config.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Odemeyap extends StatefulWidget {
  final String adresId, odemeTip;
  const Odemeyap({Key? key, required this.adresId, required this.odemeTip})
      : super(key: key);

  @override
  State<Odemeyap> createState() => _OdemeyapState();
}

class _OdemeyapState extends State<Odemeyap> {
  late String adresId, odemeTip, sepeteliste;
  @override
  void initState() {
    super.initState();
    adresId = widget.adresId;
    odemeTip = widget.odemeTip;
    sepeteliste = jsonEncode(Config.sepetliste);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ödeme Yap"),
      ),
      body: SafeArea(
        child: WebView(
          initialUrl:
              "https://api.biorganikpazar.com/odeme/odemeyap?kullaniciId=${Config.kullaniciid}&adresId=$adresId&odetip=$odemeTip&septeliste=$sepeteliste",
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
          onProgress: (int progress) {},
          onWebResourceError: (deger) {},
          onPageStarted: (_) {},
          onPageFinished: (_) async {},
          onWebViewCreated: (WebViewController webViewController) async {},
        ),
      ),
    );
  }
}
