import 'dart:convert';
import 'package:biorganikpazar/components/il_ilce_mahalle.dart';
import 'package:biorganikpazar/pages/urun_liste.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Config extends ChangeNotifier {
  String serverUrl = "https://api.biorganikpazar.com/";
  String cdnUrl = "https://cdn.biorganikpazar.com/";
  static String konum = "";
  static int selectedIndex = 0;

  static String il = "İl Seçin";
  static bool konumsecildi = false;
  static String plaka = "";
  static String ilce = "ilçe Seçin";
  static String ilcekey = "";
  static String mahalle = "Mahalle Seçin";
  static String mahallekey = "";
  static double lang = 0;
  static double long = 0;
  static String kanal = "perakende";
  static bool logindurum = false;
  static String kullaniciid = "0";
  static List sepetliste = [];
  sepetekle(List urunbilgi) {
    if (urunbilgi[0]["adet"] > 0) {
      sepetliste.addAll(urunbilgi);
      return true;
    } else {
      return false;
    }
  }

  cropImage(String resimUrl, String width, String height, String crop) {
    List<String> veri = resimUrl.split(".");
    String yeniresim = veri[0] +
        "." +
        veri[1] +
        "." +
        veri[2] +
        "X" +
        width +
        "X" +
        height +
        "X" +
        crop +
        "." +
        veri[3];
    return yeniresim;
  }

  sepetsil(int index) {
    sepetliste.remove(sepetliste[index]);
    notifyListeners();
  }

  postMethod(String urlm, Object data) async {
    try {
      var sonuc = await http.post(Uri.parse(serverUrl + urlm),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Basic bXVyYXRiYXozNEBnbWFpbC5jb206MTIz'
          },
          body: jsonEncode(data));
      if (sonuc.statusCode == 200) {
        return sonuc.body;
      } else {
        Get.dialog(
          AlertDialog(
            title: const Text(
              'Hatalı',
              textAlign: TextAlign.center,
            ),
            content: const Text(
              'Hatalı bir işlem yaptınız tekrar deneyin veya yöneticiye başvurun',
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                child: const Text("Tamam"),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        );
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  getMethod(String urlm, Object data) async {
    try {
      var sonuc = await http.get(Uri.parse(serverUrl + urlm), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Basic bXVyYXRiYXozNEBnbWFpbC5jb206MTIz'
      });
      if (sonuc.statusCode == 200) {
        return sonuc.body;
      } else {
        return "";
      }
    } catch (error) {
      return "";
    }
  }

  displayDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konum Seçin"),
          content: SizedBox(
            height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      var sonuc = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Ilgetir(),
                        ),
                      );
                      Config.il = (sonuc != null) ? sonuc["title"] : Config.il;
                      Config.plaka =
                          (sonuc != null) ? sonuc["plaka"] : Config.plaka;
                      Config.ilce = "İlçe Seçin";
                      Config.ilcekey = "";
                      Config.mahalle = "Mahalle Seçin";
                      Config.mahallekey = "";
                      Navigator.pop(context, true);
                      displayDialog(context);
                    },
                    child: Text(
                      Config.il,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextButton(
                      onPressed: () async {
                        var sonuc = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Ilcegetir(
                              plaka: Config.plaka,
                            ),
                          ),
                        );
                        Config.ilce =
                            (sonuc != null) ? sonuc["title"] : Config.ilce;
                        Config.ilcekey =
                            (sonuc != null) ? sonuc["plaka"] : Config.ilcekey;
                        Config.mahalle = "Mahalle Seçin";
                        Config.mahallekey = "";
                        Navigator.pop(context, true);
                        displayDialog(context);
                      },
                      child: Text(Config.ilce)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: TextButton(
                      onPressed: () async {
                        var sonuc = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Mahallegetir(
                              ilcekey: Config.ilcekey,
                            ),
                          ),
                        );
                        Config.mahalle =
                            (sonuc != null) ? sonuc["title"] : Config.mahalle;
                        Config.mahallekey = (sonuc != null)
                            ? sonuc["plaka"]
                            : Config.mahallekey;
                        Navigator.pop(context, true);
                        displayDialog(context);
                      },
                      child: Text(Config.mahalle)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orange)),
                        onPressed: () async {
                          Config.konum = Config.mahallekey;
                          Config.kanal = "express";
                          Navigator.pop(context);
                          Navigator.of(context, rootNavigator: false).push(
                              MaterialPageRoute(
                                  builder: (context) => const Urun_liste()));
                        },
                        icon: const Icon(
                          FontAwesome.location,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "LİSTELE",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Config.konum = Config.mahallekey;
                          konumsecildi = true;
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue)),
                        child: const Text(
                          "Konum Kaydet",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
