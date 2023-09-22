import 'dart:convert';

import 'package:biorganikpazar/config/config.dart';

class Kullanicisorudetaymodel {
  String? id;
  String? soruId;
  String? soruKodu;
  String? tur;
  String? kisiId;
  String? kisiKodu;
  String? mesaj;
  String? tarih;
  String? durum;
  String? ustId;

  Kullanicisorudetaymodel(
      {this.id,
      this.soruId,
      this.soruKodu,
      this.tur,
      this.kisiId,
      this.kisiKodu,
      this.mesaj,
      this.tarih,
      this.durum,
      this.ustId});

  Kullanicisorudetaymodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    soruId = json['soru_id'];
    soruKodu = json['soru_kodu'];
    tur = json['tur'];
    kisiId = json['kisi_id'];
    kisiKodu = json['kisi_kodu'];
    mesaj = json['mesaj'];
    tarih = json['tarih'];
    durum = json['durum'];
    ustId = json['ustId'];
  }
}

getkullanicisorudetay(String soruId, String tezgahId) async {
  var data = {
    "soruId": soruId,
    "tezgahId": tezgahId,
    "kullaniciId": Config.kullaniciid
  };
  var sonuc = await Config().postMethod("kullanici/sorudetay", data);
  print(sonuc);
  // var body = jsonDecode(sonuc) as List;
  // return body.map((e) => Kullanicisorudetaymodel.fromJson(e)).toList();
}
