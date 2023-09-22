import 'dart:convert';

import 'package:biorganikpazar/components/Input.dart';
import 'package:biorganikpazar/components/app_bar.dart';
import 'package:biorganikpazar/components/buttons.dart';
import 'package:biorganikpazar/config/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // ignore: unused_field
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String sifre = "", email = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const App_bar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/sitelogo.png",
                    width: MediaQuery.of(context).size.width / 3,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Tüm işlemlerinizi görmek ve alışveri yapmak için lütfen giriş yapın",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Input(
                    label: "E-posta Adresiniz",
                    inputype: TextInputType.emailAddress,
                    borderColors: Colors.grey,
                    textval: (text) => {email = text},
                    errorText: "Boş Olamaz ve Eposta Olmalıdır",
                  ),
                  Input(
                    label: "Şifreniz",
                    passwordstatus: true,
                    nextType: TextInputAction.done,
                    borderColors: Colors.grey,
                    textval: (text) => {
                      sifre = text,
                    },
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text("Şifremi Unuttum"),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Buttons(
                          btnText: "Giriş Yap",
                          bgcolor: Colors.green,
                          textColor: Colors.white,
                          onpress: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              _loginislem();
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: Buttons(
                          btnText: "Üye Ol",
                          bgcolor: Colors.orange,
                          textColor: Colors.white,
                          onpress: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed(
                              '/uyeol',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loginislem() async {
    var veriler = await Config()
        .postMethod("kullanici/login", {"eposta": email, "sifre": sifre});
    if (veriler != false) {
      var body = jsonDecode(veriler) as List;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("id", body[0]["id"].toString());
      prefs.setString("adi", body[0]["adi"].toString());
      prefs.setString("email", body[0]["e_posta"].toString());
      prefs.setString("kimlik", body[0]["kimlik"].toString());
      Get.dialog(
        AlertDialog(
          title: const Text(
            'Başarılı',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Başarıyla Giriş Yaptınız',
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
                child: const Text("Tamam"),
                onPressed: () {
                  Config.logindurum = true;
                  Get.offAllNamed("/");
                }),
          ],
        ),
      );
    } else {}
  }
}
