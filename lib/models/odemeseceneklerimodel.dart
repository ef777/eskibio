import 'dart:convert';

import 'package:biorganikpazar/config/config.dart';

class Odemeseceneklerimodel {
  String? id;
  String? adi;
  String? aciklama;
  String? durum;
  String? isaret;
  String? path;

  Odemeseceneklerimodel(
      {this.id, this.adi, this.aciklama, this.durum, this.isaret, this.path});

  Odemeseceneklerimodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adi = json['adi'];
    aciklama = json['aciklama'];
    durum = json['durum'];
    isaret = json['isaret'];
    path = json['path'];
  }
}

Future<List<Odemeseceneklerimodel>> getOdemesecenekleri() async {
  var data = {"kullaniciId": Config.kullaniciid};
  var veri = await Config().postMethod("ayarlar/odemesecenekleri", data);
  var body = jsonDecode(veri) as List;
  return body.map((e) => Odemeseceneklerimodel.fromJson(e)).toList();
}
