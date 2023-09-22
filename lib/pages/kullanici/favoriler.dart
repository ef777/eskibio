import 'package:biorganikpazar/config/config.dart';
import 'package:biorganikpazar/models/favorimurunmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Favoriler extends StatefulWidget {
  const Favoriler({Key? key}) : super(key: key);

  @override
  State<Favoriler> createState() => _FavorilerState();
}

class _FavorilerState extends State<Favoriler> {
  late Future<List<Favoriurunmodel>> _favoriliste;
  @override
  void initState() {
    super.initState();
    favorigetir();
  }

  favorigetir() {
    _favoriliste = getfavoriurunler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favori Ürünler")),
      body: FutureBuilder<List<Favoriurunmodel>>(
        future: _favoriliste, // async work
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
                    leading: Image.network(Config().cdnUrl +
                        "urunler/" +
                        data.id.toString() +
                        "/crop/" +
                        data.vitrinResim.toString()),
                    title: Text(data.urunAdi.toString()),
                    subtitle: Wrap(
                      direction: Axis.horizontal,
                      children: data.nitelikler!.map(
                        (i) {
                          return Text(
                            i.ad.toString() + " , ",
                            style: TextStyle(fontSize: 12),
                          );
                        },
                      ).toList(),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.grey,
                      ),
                      onPressed: () async {
                        favoricikart(data.id.toString());
                      },
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

  Future favoricikart(String urunId) async {
    var data = {"kullaniciId": Config.kullaniciid, "urunId": urunId};
    await Config().postMethod("kullanici/favoriuruncikart", data);
    setState(() {
      favorigetir();
    });
  }
}
