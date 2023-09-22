import 'dart:convert';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:biorganikpazar/config/config.dart';
import 'package:biorganikpazar/config/prefservice.dart';
import 'package:biorganikpazar/models/adreslistemodel.dart';
import 'package:biorganikpazar/models/odemeseceneklerimodel.dart';
import 'package:biorganikpazar/pages/kullanici/adresislem.dart';
import "package:flutter/material.dart";
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';

class Sepet extends StatefulWidget {
  const Sepet({Key? key}) : super(key: key);

  @override
  State<Sepet> createState() => _SepetState();
}

class _SepetState extends State<Sepet> {
  late bool logindurum = false;
  double toplam = 0, kdvtoplam = 0;
  late String adresId = "";
  late String odemtip = "";
  late Future<List<Adreslistemode>> _adresliste;
  late Future<List<Odemeseceneklerimodel>> _odemesecenkleri;
  @override
  void initState() {
    logincontrol();
    _adresliste = getAdresgetir();
    _odemesecenkleri = getOdemesecenekleri();
    super.initState();
  }

  logincontrol() async {
    String sonuc = await PrefService().getString("id");
    if (sonuc != "") {
      Config.logindurum = true;
      Config.kullaniciid = sonuc;
      logindurum = true;
    } else {
      Config.logindurum = false;
      Config.kullaniciid = "0";
      logindurum = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF81C242).withOpacity(1),
        title: const Text("Sepetim"),
      ),
      body: FutureBuilder(
        future: Future.wait([_adresliste, _odemesecenkleri]),
        builder: (context, AsyncSnapshot<List<dynamic>> snaphost) {
          if (snaphost.hasData) {
            var adresliste = snaphost.data![0];
            print("adres ${adresliste.runtimeType}");
            var odemesecenekleri = snaphost.data![1];
            return (Config.sepetliste.isNotEmpty)
                ? SingleChildScrollView(
                    primary: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            itemBuilder: (context, index) {
                              var datam = Config.sepetliste[index];
                              toplam = toplam +
                                  (double.parse(datam["fiyat"].toString()) *
                                      double.parse(datam["adet"].toString()));
                              return ListTile(
                                onTap: () {
                                  Get.toNamed(
                                      "/urun/${datam["link"]}/${datam["urunkodu"]}");
                                },
                                leading: Image.network(datam["resim"]),
                                title: Text(datam["title"] ?? ""),
                                subtitle: Text(datam["kargo"] +
                                    " " +
                                    datam["tip"] +
                                    "  " +
                                    datam["adet"].toString() +
                                    "X" +
                                    datam["fiyat"].toString() +
                                    "TL"),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    Config().sepetsil(index);
                                    setState(() {});
                                  },
                                ),
                              );
                            },
                            itemCount: Config.sepetliste.length,
                          ),
                          const Divider(),
                          Visibility(
                            child: Card(
                              child: ListView(
                                padding: const EdgeInsets.all(10),
                                shrinkWrap: true,
                                primary: false,
                                children: [
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "Ara Toplam",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text("$toplam TL"),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          "Kargo Toplam",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text("$kdvtoplam TL"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            visible: Config.logindurum,
                          ),
                          const Divider(),
                          Visibility(
                            visible: Config.logindurum,
                            child: Card(
                                child: adresliste.isEmpty
                                    ? Container(
                                        height: 50,
                                        width: 350,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text("adres yok!"),
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Adresislem()),
                                                    );
                                                  },
                                                  icon: Icon(Icons.add))
                                            ]))
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        itemBuilder: (context, index) {
                                          var adres = adresliste[index];

                                          return ListTile(
                                            onTap: () {
                                              setState(() {
                                                adresId = adres.id;
                                              });
                                            },
                                            trailing: Icon(
                                              (adresId == adres.id)
                                                  ? FontAwesome.dot_circled
                                                  : FontAwesome.circle_empty,
                                              color: Colors.green,
                                            ),
                                            title: Text(adres.adi.toString()),
                                            subtitle: Text(
                                                adres.aliciAdi.toString() +
                                                    " " +
                                                    adres.aliciSoyadi +
                                                    "\n" +
                                                    adres.ilAdi +
                                                    " " +
                                                    adres.ilceAdi +
                                                    " " +
                                                    adres.mahalleAdi +
                                                    " / " +
                                                    adres.postakodu),
                                          );
                                        },
                                        itemCount: adresliste.length,
                                      )),
                          ),
                          Visibility(
                            child: Card(
                              child: ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (context, index) {
                                  var odeme = odemesecenekleri[index];
                                  return ListTile(
                                      onTap: () {
                                        setState(() {
                                          odemtip = odeme.path;
                                        });
                                      },
                                      trailing: Icon(
                                        (odemtip == odeme.path)
                                            ? FontAwesome.dot_circled
                                            : FontAwesome.circle_empty,
                                        color: Colors.green,
                                      ),
                                      title: Text(odeme.adi),
                                      subtitle: Text(odeme.aciklama));
                                },
                                itemCount: odemesecenekleri.length,
                              ),
                            ),
                            visible: Config.logindurum,
                          ),
                          Container(
                            alignment: Alignment.center,
                            color: Colors.green,
                            child: (Config.logindurum == true)
                                ? TextButton(
                                    child: const Text(
                                      "Ödeme Yap",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      if (odemtip != "" && adresId != "") {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pushNamed(
                                                "/odemeyap/${odemtip}/${adresId}");
                                      } else if (adresId == "") {
                                        ArtSweetAlert.show(
                                          context: context,
                                          artDialogArgs: ArtDialogArgs(
                                            confirmButtonText: "Tamam",
                                            type: ArtSweetAlertType.danger,
                                            title: "Hatalı",
                                            text: "Lütfen Adres Seçiniz",
                                          ),
                                        );
                                      } else if (odemtip == "") {
                                        ArtSweetAlert.show(
                                          context: context,
                                          artDialogArgs: ArtDialogArgs(
                                            confirmButtonText: "Tamam",
                                            type: ArtSweetAlertType.danger,
                                            title: "Hatalı",
                                            text:
                                                "Lütfen Ödeme Yöntemi Seçiniz",
                                          ),
                                        );
                                      } else {
                                        ArtSweetAlert.show(
                                          context: context,
                                          artDialogArgs: ArtDialogArgs(
                                            confirmButtonText: "Tamam",
                                            type: ArtSweetAlertType.danger,
                                            title: "Hatalı",
                                            text:
                                                "Lütfen Adres ve Ödeme Tipini Seçiniz",
                                          ),
                                        );
                                      }
                                    },
                                  )
                                : TextButton(
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pushNamed("/login");
                                    },
                                    child: const Text(
                                      "Giriş Yap",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),
                  )
                : const Center(child: Text("Sepet boş"));
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
