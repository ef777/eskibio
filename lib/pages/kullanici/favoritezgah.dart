import 'package:biorganikpazar/config/config.dart';
import 'package:biorganikpazar/models/favoritezgahmodel.dart';
import 'package:flutter/material.dart';

class Favoritezgah extends StatefulWidget {
  const Favoritezgah({Key? key}) : super(key: key);

  @override
  State<Favoritezgah> createState() => _FavoritezgahState();
}

class _FavoritezgahState extends State<Favoritezgah> {
  late Future<List<Favoritezgahmodel>> _favoritezgah;
  @override
  void initState() {
    super.initState();
    tezgahgetir();
  }

  tezgahgetir() {
    _favoritezgah = getfavoritezgahlar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favori Tezgahlar")),
      body: FutureBuilder<List<Favoritezgahmodel>>(
        future: _favoritezgah, // async work
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            var favorilistem = snapshot.data;
            if (favorilistem!.isNotEmpty) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  var data = favorilistem[index];
                  return ListTile(
                    leading: Image.network(
                        Config().cdnUrl + data.tezgahlogo.toString()),
                    title: Text(data.tezgahAdi.toString()),
                    subtitle: Text("Toplam Ürün:3 Toplam Satış :4"),
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
                child: Text("Favoride ekli tezgah bulunamadı"),
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
    var data = {"kullaniciId": Config.kullaniciid, "id": urunId};
    await Config().postMethod("kullanici/favoritezgahcikart", data);
    setState(() {
      tezgahgetir();
    });
  }
}
