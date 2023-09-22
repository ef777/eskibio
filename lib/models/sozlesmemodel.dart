import 'dart:convert';

import 'package:biorganikpazar/config/config.dart';

class Sozlesmemodel {
  String? id;
  String? adi;
  String? link;
  String? icerik;
  String? title;
  String? keywords;
  String? description;
  String? odemedeKullan;
  String? kullaniciKayit;
  String? tezgahKayit;
  String? kargoKayit;
  String? sira;
  String? icerik2;

  Sozlesmemodel(
      {id,
      adi,
      link,
      icerik,
      title,
      keywords,
      description,
      odemedeKullan,
      kullaniciKayit,
      tezgahKayit,
      kargoKayit,
      sira,
      icerik2});

  Sozlesmemodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adi = json['adi'];
    link = json['link'];
    icerik = json['icerik'];
    title = json['title'];
    keywords = json['keywords'];
    description = json['description'];
    odemedeKullan = json['odemede_kullan'];
    kullaniciKayit = json['kullanici_kayit'];
    tezgahKayit = json['tezgah_kayit'];
    kargoKayit = json['kargo_kayit'];
    sira = json['sira'];
    icerik2 = json['icerik_2'];
  }
}

Future<List<Sozlesmemodel>> getsozlesmeler(String tip) async {
  var data = {};
  var dersler = await Config().getMethod("interaktif/sozlemeler/" + tip, data);
  var body = json.decode(dersler) as List;
  return body.map((e) => Sozlesmemodel.fromJson(e)).toList();
}
