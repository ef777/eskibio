import 'package:biorganikpazar/models/kullanicisorumodel.dart';
import 'package:biorganikpazar/pages/kullanici/sorudetay.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Sorular extends StatefulWidget {
  const Sorular({Key? key}) : super(key: key);

  @override
  State<Sorular> createState() => _SorularState();
}

class _SorularState extends State<Sorular> {
  late Future<List<Kullanicisorumodel>> _soruliste;
  @override
  void initState() {
    super.initState();
    sorugetir();
  }

  sorugetir() {
    _soruliste = getkullanicisorulari();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ürün Soruları")),
      body: FutureBuilder<List<Kullanicisorumodel>>(
        future: _soruliste, // async work
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            var favorilistem = snapshot.data;
            if (favorilistem!.isNotEmpty) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  var data = favorilistem[index];
                  return ListTile(
                    onTap: () {
                      Get.toNamed("/urun/${data.urunLink}/${data.urunKodu}");
                    },
                    title: Text(data.mesaj.toString()),
                    subtitle: Text(
                        "ürün : ${data.urunAdi} | tezgah : ${data.tezgahAdi}"),
                    trailing: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Sorudetay(
                              soruId: data.id.toString(),
                              soruBaslik: data.mesaj.toString(),
                              tezgahId: data.tezgahId.toString(),
                            ),
                          ),
                        );
                      },
                      child: Text("Detay"),
                    ),
                  );
                },
                itemCount: favorilistem.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(color: Colors.grey);
                },
              );
            } else {
              return const Center(
                child: Text("Favoride ekli ürün bulunamadı"),
              );
            }
          } else {
            return const Center(
              child: SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
