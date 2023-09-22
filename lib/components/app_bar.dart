import 'package:biorganikpazar/config/config.dart';
import 'package:biorganikpazar/pages/arama.dart';
import 'package:biorganikpazar/pages/kullanici/hesap.dart';
import 'package:biorganikpazar/pages/kullanici/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';

// ignore: camel_case_types
class App_bar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState>? scfkey;
  final Widget? bottomwidget;
  final int boyut;
  const App_bar({Key? key, this.scfkey, this.bottomwidget, this.boyut = 50})
      : super(key: key);

  @override
  State<App_bar> createState() => _App_barState();

  @override
  Size get preferredSize => Size.fromHeight(boyut.toDouble());
}

// ignore: camel_case_types
class _App_barState extends State<App_bar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: Size.fromHeight(54.0), // here the desired height
        child: Container(
            decoration: BoxDecoration(
              boxShadow: [boxShadow2],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: Theme(
                data: Theme.of(context).copyWith(
                  // Set the transparency here
                  canvasColor: Colors
                      .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
                ),
                child: AppBar(
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        Config().displayDialog(context);
                      },
                      child: const Icon(
                        FontAwesome.location,
                        size: 24.0,
                      ),
                    ),
                  ),
                  backgroundColor: Color(0xFF81C242).withOpacity(1),
                  title: Container(
                    height: 80,
                    width: 130,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/img.png"),
                            fit: BoxFit.contain)),
                  ),
                  centerTitle: true,
                  actions: [
                    const SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute<bool>(
                              fullscreenDialog: true,
                              builder: (BuildContext context) => const Arama(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.search,
                          size: 26.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute<bool>(
                              fullscreenDialog: true,
                              builder: (BuildContext context) =>
                                  (Config.logindurum == true)
                                      ? const Hesap()
                                      : const Login(),
                            ),
                          );
                        },
                        child: const Icon(
                          FontAwesome.user,
                          size: 22.0,
                        ),
                      ),
                    ),
                  ],
                ))));
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
