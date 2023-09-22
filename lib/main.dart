import 'dart:io';

import 'package:biorganikpazar/pages/hata_page.dart';
import 'package:biorganikpazar/pages/home.dart';
import 'package:biorganikpazar/pages/kullanici/hesap.dart';
import 'package:biorganikpazar/pages/kullanici/login.dart';
import 'package:biorganikpazar/pages/kullanici/uyeol.dart';
import 'package:biorganikpazar/pages/odemeyap.dart';
import 'package:biorganikpazar/pages/urun_detay.dart';
import 'package:biorganikpazar/pages/urun_liste.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/urunler': (context) => const Urun_liste(),
        '/login': (context) => const Login(),
        '/uyeol': (context) => const UyeOl(),
        '/hesabim': (context) => const Hesap(),
      },
      onGenerateRoute: (RouteSettings settings) {
        List<String> veri = settings.name!.split("/");
        if (veri[1] == "urunler") {
          return MaterialPageRoute(
            builder: (context) => Urun_liste(
              kategorim: veri[2].toString(),
            ),
          );
        } else if (veri[1] == "odemeyap") {
          return MaterialPageRoute(
            builder: (context) => Odemeyap(
              odemeTip: veri[2].toString(),
              adresId: veri[3].toString(),
            ),
          );
        } else if (veri[1] == "urun") {
          return MaterialPageRoute(
            builder: (context) => Urun_detay(
              link: veri[2].toString(),
              urunkodu: veri[3].toString(),
            ),
          );
        } else {
          return MaterialPageRoute(builder: (context) => const Hatapage());
        }
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) => const Hatapage());
      },
    );
  }
}
