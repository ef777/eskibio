import 'dart:convert';

import 'package:biorganikpazar/components/siparisblog.dart';
import 'package:biorganikpazar/config/config.dart';
import 'package:biorganikpazar/models/siparislistemodel.dart';
import 'package:flutter/material.dart';

class Siparisler extends StatefulWidget {
  const Siparisler({Key? key}) : super(key: key);

  @override
  State<Siparisler> createState() => _SiparislerState();
}

class _SiparislerState extends State<Siparisler> {
  late final Future<List<Siparislistemodel>> _siparisler;
  @override
  void initState() {
    _siparisler = getsiparisliste();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Siparislistemodel>>(
      future: _siparisler,
      builder: (context, snaphost) {
        if (snaphost.hasData) {
          var dataliste = snaphost.data;
          return Scaffold(
            backgroundColor: Colors.grey.shade300,
            appBar: AppBar(
              title: const Text("Siparişlerim"),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            body: ListView.builder(
              itemBuilder: (context, index) {
                var veri = dataliste![index];
                return Siparisblog(
                  id: veri.id,
                  siparisKodu: veri.siparisKodu,
                  durumu: veri.durum,
                  tarih: veri.tarih,
                  urunler: veri.urunler,
                );
              },
              itemCount: dataliste!.length,
            ),
          );
        } else {
          return const Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
              width: 32,
              height: 32,
            ),
          );
        }
      },
    );
  }

  Future<List<Siparislistemodel>> getsiparisliste() async {
    var data = {"kullaniciid": Config.kullaniciid, "adet": 10};
    var sonuc = await Config().postMethod("kullanici/siparisler", data);
    var body = json.decode(sonuc) as List;
    return body.map((e) => Siparislistemodel.fromJson(e)).toList();
  }
}
