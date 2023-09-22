import 'package:biorganikpazar/components/app_bar.dart';
import 'package:biorganikpazar/components/drawer_kategor.dart';
import 'package:biorganikpazar/config/config.dart';
import 'package:biorganikpazar/config/prefservice.dart';
import 'package:biorganikpazar/pages/kullanici/Sorular.dart';
import 'package:biorganikpazar/pages/kullanici/adresler.dart';
import 'package:biorganikpazar/pages/kullanici/favoriler.dart';
import 'package:biorganikpazar/pages/kullanici/favoritezgah.dart';
import 'package:biorganikpazar/pages/kullanici/siparisler.dart';
import 'package:biorganikpazar/pages/kullanici/toptansipari.dart';
import "package:flutter/material.dart";
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:get/get.dart';

class Hesap extends StatefulWidget {
  const Hesap({Key? key}) : super(key: key);

  @override
  State<Hesap> createState() => _HesapState();
}

class _HesapState extends State<Hesap> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late String adsoyad = "", eposta = "";
  @override
  void initState() {
    bilgigetir();
    super.initState();
  }

  bilgigetir() async {
    String adi = await PrefService().getString("adi");
    String email = await PrefService().getString("email");
    setState(() {
      adsoyad = adi;
      eposta = email;
    });
  }

  cikisYap() async {
    bool durum = await PrefService().deleteString("id");
    if (durum) {
      Config.logindurum = false;
      Get.offAllNamed("/");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      key: _scaffoldKey,
      appBar: App_bar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            ListTile(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              tileColor: Colors.white,
              title: Text(adsoyad),
              subtitle: Text(eposta),
              trailing: const Icon(Icons.settings),
            ),
            const SizedBox(
              height: 15,
            ),
            ListTile(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              leading: const Icon(
                Octicons.package,
                size: 22,
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Siparisler()));
              },
              tileColor: Colors.white,
              title: const Text("Siparişlerim"),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            // ListTile(
            //   leading: const Icon(
            //     FontAwesome5.cubes,
            //     size: 22,
            //   ),
            //   tileColor: Colors.white,
            //   title: const Text("Toptan Sipariş"),
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (context) => const Toptansiparis()));
            //   },
            //   trailing: const Icon(Icons.keyboard_arrow_right),
            // ),
            ListTile(
              leading: const Icon(
                FontAwesome.heart_empty,
                size: 22,
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Favoriler()));
              },
              tileColor: Colors.white,
              title: const Text("Favori Ürünlerim"),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              leading: const Icon(
                FontAwesome5.store,
                size: 18,
              ),
              tileColor: Colors.white,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Favoritezgah()));
              },
              title: const Text("Favori Tezgahlarım"),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              leading: const Icon(
                Icons.question_answer,
                size: 22,
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Sorular()));
              },
              tileColor: Colors.white,
              title: const Text("Sorular"),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
            ListTile(
              leading: const Icon(
                Typicons.address,
                size: 22,
              ),
              tileColor: Colors.white,
              title: const Text("Adresler"),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Adresler()));
              },
            ),
            ListTile(
              onTap: () {
                cikisYap();
              },
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              leading: const Icon(
                MfgLabs.logout,
                size: 22,
              ),
              tileColor: Colors.white,
              title: const Text("Güvenlik Çıkış"),
              trailing: const Icon(Icons.keyboard_arrow_right),
            ),
          ],
        ),
      ),
    );
  }
}
