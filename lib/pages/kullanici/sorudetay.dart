import 'package:biorganikpazar/models/kullanicisorudetaymodel.dart';
import 'package:flutter/material.dart';

class Sorudetay extends StatefulWidget {
  final String soruId, soruBaslik, tezgahId;
  const Sorudetay(
      {Key? key,
      required this.soruId,
      required this.soruBaslik,
      required this.tezgahId})
      : super(key: key);

  @override
  State<Sorudetay> createState() => _SorudetayState();
}

class _SorudetayState extends State<Sorudetay> {
  late String soruId, sorubaslik, tezgahId;
  late Future<List<Kullanicisorudetaymodel>> sorudetay;
  @override
  void initState() {
    super.initState();
    soruId = widget.soruId.toString();
    sorubaslik = widget.soruBaslik;
    tezgahId = widget.tezgahId;
    sordetayliste();
  }

  sordetayliste() {
    getkullanicisorudetay(soruId, tezgahId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(sorubaslik)),
      body: Text("ddd"),
    );
  }
}
