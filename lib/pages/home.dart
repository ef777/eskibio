import 'package:biorganikpazar/config/config.dart';
import 'package:biorganikpazar/config/prefservice.dart';
import 'package:biorganikpazar/pages/home_page.dart';
import 'package:biorganikpazar/pages/kategoriler.dart';
import 'package:biorganikpazar/pages/kullanici/hesap.dart';
import 'package:biorganikpazar/pages/kullanici/login.dart';
import 'package:biorganikpazar/pages/sepet.dart';
import 'package:biorganikpazar/pages/urun_liste.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:biorganikpazar/config/config.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late bool logindurum = false;

  List pagekey = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  @override
  void initState() {
    logincontrol();
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
    List<Widget> sayfalar = [
      const Home_page(),
      const Urun_liste(),
      const Sepet(),
      const Kategoriler(),
      //(Config.logindurum == true) ? const Hesap() : const Login(),
    ];
    return WillPopScope(
        onWillPop: () async {
          var durum =
              await await pagekey[Config.selectedIndex].currentState.maybePop();
          if (durum) {
            return false;
          } else {
            if (Config.selectedIndex == 0) {
              return true;
            } else {
              setState(() {
                Config.selectedIndex = 0;
              });
              return false;
            }
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          body: Navigator(
            key: pagekey[Config.selectedIndex],
            onGenerateRoute: (routeSettings) {
              return MaterialPageRoute(
                builder: (context) {
                  return sayfalar[Config.selectedIndex];
                },
              );
            },
          ),
          bottomNavigationBar: Container(
            height: 60,
            decoration: BoxDecoration(
              boxShadow: [boxShadow],
              borderRadius: BorderRadius.only(
                  // topRight: Radius.circular(20),
                  // topLeft: Radius.circular(20),
                  ),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              iconSize: 30,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesome.home,
                    size: 20,
                  ),
                  label: "Ana Sayfa",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesome.shopping_bag,
                    size: 20,
                  ),
                  label: "Ürünler",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesome.basket,
                    size: 20,
                  ),
                  label: "Sepetim",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Typicons.th_large_outline,
                    size: 18,
                  ),
                  label: "Kategori",
                ),
              ],
              currentIndex: Config.selectedIndex,
              selectedItemColor: Color.fromARGB(255, 209, 115, 27),
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                setState(() {
                  Config.selectedIndex = index;
                });
              },
            ),
          ),
        ));
  }

  BoxShadow boxShadow = BoxShadow(
    color: Colors.black.withOpacity(1),
    spreadRadius: 5,
    blurRadius: 7,
    offset: Offset(0, 3), // changes position of shadow
  );
  BoxShadow boxShadow2 = BoxShadow(
    color: Colors.black.withOpacity(0.5),
    spreadRadius: 9,
    blurRadius: 12,
    offset: Offset(1, 0), // changes position of shadow
  );
}
