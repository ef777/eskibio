// ignore_for_file: iterable_contains_unrelated_type

import 'package:biorganikpazar/components/Input.dart';
import 'package:biorganikpazar/models/sozlesmemodel.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class UyeOl extends StatefulWidget {
  const UyeOl({Key? key}) : super(key: key);

  @override
  State<UyeOl> createState() => _UyeOlState();
}

class _UyeOlState extends State<UyeOl> {
  final _formKey = GlobalKey<FormState>();
  String sifre = "", email = "";
  List<bool> isChecked = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        FontAwesome.cancel,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "BiOrganik Pazar'a Kayıt Ol",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                const SizedBox(
                  height: 20,
                ),
                Input(
                  label: "Adınız ve Soyadınız",
                  inputype: TextInputType.text,
                  borderColors: Colors.grey,
                  textval: (text) => {email = text},
                  errorText: "Ad Soyad Boş Olamaz",
                ),
                Input(
                  label: "Eposta Adresiniz",
                  inputype: TextInputType.emailAddress,
                  borderColors: Colors.grey,
                  textval: (text) => {email = text},
                  errorText: "Eposta Boş Olamaz",
                ),
                Input(
                  label: "Telefon Numrası",
                  inputype: TextInputType.phone,
                  borderColors: Colors.grey,
                  textval: (text) => {email = text},
                  errorText: "Telefon Boş Olamaz",
                ),
                Input(
                  label: "Şifreniz",
                  inputype: TextInputType.text,
                  borderColors: Colors.grey,
                  textval: (text) => {email = text},
                  errorText: "Şifre Boş Olamaz",
                ),
                Input(
                  label: "Şifre Tekrar",
                  inputype: TextInputType.text,
                  borderColors: Colors.grey,
                  nextType: TextInputAction.done,
                  textval: (text) => {email = text},
                  errorText: "Şifre Boş Olamaz",
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder<List<Sozlesmemodel>>(
                  future: getsozlesmeler("uye"),
                  builder: (context, veri) {
                    if (veri.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) {
                          var datam = veri.data![index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 15,
                            ),
                            child: CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              checkColor: Colors.white,
                              title: Text(
                                  datam.adi.toString() + " Okudum Onaylıyorum"),
                              value: isChecked.contains(index),
                              onChanged: (bool? value) {},
                            ),
                          );
                        },
                        itemCount: veri.data?.length,
                      );
                    } else {
                      return const Text("Yükleniyor");
                    }
                  },
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  color: Colors.green,
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                    },
                    child: const Text("Kayıt Ol",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        )),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Hesabınız Yoksa Hemen"),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Giriş Yap"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
