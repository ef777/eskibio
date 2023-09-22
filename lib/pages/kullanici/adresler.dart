import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:biorganikpazar/config/config.dart';
import 'package:biorganikpazar/models/adreslistemodel.dart';
import 'package:biorganikpazar/pages/kullanici/adresislem.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class Adresler extends StatefulWidget {
  const Adresler({Key? key}) : super(key: key);

  @override
  State<Adresler> createState() => _AdreslerState();
}

class _AdreslerState extends State<Adresler> {
  late Future<List<Adreslistemode>> _adresliste;
  @override
  void initState() {
    super.initState();
    adresetir();
  }

  adresetir() {
    _adresliste = getAdresgetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adreslerim"),
        actions: [
          TextButton(
            onPressed: () async {
              final sonuc = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Adresislem(),
                ),
              );
              setState(() {
                adresetir();
              });
            },
            child: Text(
              "Ekle",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<Adreslistemode>>(
        future: _adresliste,
        builder: (context, snaphost) {
          if (snaphost.hasData) {
            return Card(
              child: ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemBuilder: (context, index) {
                  var adres = snaphost.data![index];
                  return ListTile(
                    trailing: Wrap(
                      spacing: 12,
                      children: [
                        IconButton(
                          onPressed: () async {
                            final sonuc = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Adresislem(
                                  adresId: adres.id.toString(),
                                  adresdata: adres,
                                ),
                              ),
                            );

                            setState(() {
                              adresetir();
                            });
                          },
                          icon: Icon(
                            FontAwesome.edit,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            adressilaler(adres.id.toString());
                          },
                          icon: Icon(
                            FontAwesome.trash,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    title: Text(adres.adi.toString()),
                    subtitle: Text(adres.aliciAdi.toString() +
                        " " +
                        adres.aliciSoyadi.toString() +
                        "\n" +
                        adres.adres.toString() +
                        " " +
                        adres.ilAdi.toString() +
                        " " +
                        adres.ilceAdi.toString() +
                        " " +
                        adres.mahalleAdi.toString() +
                        " / " +
                        adres.postakodu.toString()),
                  );
                },
                itemCount: snaphost.data!.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.grey,
                  );
                },
              ),
            );
          } else {
            return const Center(
              child: SizedBox(
                height: 32,
                width: 32,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  adressilaler(String id) async {
    ArtDialogResponse response = await ArtSweetAlert.show(
      context: context,
      artDialogArgs: ArtDialogArgs(
        confirmButtonText: "Evet",
        type: ArtSweetAlertType.warning,
        title: "Veriyi Silmek istermisiniz",
        text: "Adres verisi silinecektir silmek istediğinizden emin misiniz",
        showCancelBtn: true,
        cancelButtonText: "Hayır",
      ),
    );
    if (response == null) {
      return;
    }

    if (response.isTapConfirmButton) {
      var data = {};
      var sonuc = await Config()
          .getMethod("kullanici/adressil/$id/${Config.kullaniciid}", data);
      print(sonuc);
      if (sonuc == false) {
      } else {
        ArtSweetAlert.show(
          context: context,
          artDialogArgs: ArtDialogArgs(
            confirmButtonText: "Tamam",
            type: ArtSweetAlertType.success,
            title: "Başarılı",
            text: "Başarıyla İşleminiz Yapıldı",
          ),
        );
        setState(() {
          adresetir();
        });
      }
      return;
    }
  }
}
