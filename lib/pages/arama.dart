import 'dart:convert';

import 'package:biorganikpazar/components/urun_blog.dart';
import 'package:biorganikpazar/config/config.dart';
import 'package:biorganikpazar/models/urunliste_model.dart';
import 'package:flutter/material.dart';

class Arama extends StatefulWidget {
  const Arama({Key? key}) : super(key: key);

  @override
  State<Arama> createState() => _AramaState();
}

class _AramaState extends State<Arama> {
  late List<Urunliste_model> urunliste;
  bool hata = false;
  String kelime = "";
  @override
  void initState() {
    super.initState();
    urunliste = [];
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            border:
                Border.all(width: 1, color: (hata) ? Colors.red : Colors.white),
            color: Colors.white60,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          height: 32,
          child: TextField(
            onSubmitted: (value) {
              aramayap();
            },
            onChanged: (val) {
              kelime = val;
            },
            textInputAction: TextInputAction.go,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: 10),
              hintText: "Size nasıl yardımcı olabiliriz",
            ),
          ),
        ),
      ),
      body: (urunliste.isNotEmpty)
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 10,
                childAspectRatio: (itemWidth / itemHeight),
              ),
              itemCount: urunliste.length,
              itemBuilder: (BuildContext ctx, index) {
                var body = urunliste[index];
                return Urun_Blog(
                  title: body.urunAdi.toString(),
                  img: body.vitrinResim.toString(),
                  kargo: body.kargoDurum.toString(),
                  fiyat: body.urunFiyat.toString(),
                  link: body.urunLink.toString(),
                  kanal: Config.kanal,
                  urunkodu: body.urunKodu.toString(),
                  tip: body.urunAdet.toString(),
                  birimdeger: body.birimSembol.toString(),
                  degerlendirme: body.puanlama.toString(),
                  yorumadet: body.yorumadet.toString(),
                  id: body.id.toString(),
                );
              })
          : Container(
              alignment: Alignment.center,
              child: const Text("Lütfen Bir arama yapn"),
            ),
    );
  }

  aramayap() async {
    if (kelime != "") {
      //  ara-kelime
      var dersler = await Config().postMethod(
          "urunler/liste/?kategorim=44&siparis=" +
              Config.kanal +
              "&basla=0&bitis=100&ara-kelime=" +
              kelime,
          {});

      var body = json.decode(dersler) as List;
      urunliste = body.map((e) => Urunliste_model.fromJson(e)).toList();
      setState(() {
        hata = false;
      });
    } else {
      setState(() {
        hata = true;
      });
    }
  }
}
