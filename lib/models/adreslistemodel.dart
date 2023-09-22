import 'dart:convert';

import 'package:biorganikpazar/config/config.dart';

class Adreslistemode {
  String? id;
  String? kullaniciId;
  String? kimlik;
  String? adi;
  String? aliciAdi;
  String? aliciSoyadi;
  String? aliciTc;
  String? adres;
  String? il;
  String? ilce;
  String? mahalle;
  String? postakodu;
  String? tarih;
  String? varsayilanAdres;
  String? ilceAdi;
  String? ilAdi;
  String? mahalleAdi;

  Adreslistemode(
      {this.id,
      this.kullaniciId,
      this.kimlik,
      this.adi,
      this.aliciAdi,
      this.aliciSoyadi,
      this.aliciTc,
      this.adres,
      this.il,
      this.ilce,
      this.mahalle,
      this.postakodu,
      this.ilAdi,
      this.ilceAdi,
      this.mahalleAdi,
      this.tarih,
      this.varsayilanAdres});

  Adreslistemode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kullaniciId = json['kullanici_id'];
    kimlik = json['kimlik'];
    adi = json['adi'];
    aliciAdi = json['alici_adi'];
    aliciSoyadi = json['alici_soyadi'];
    aliciTc = json['alici_tc'];
    adres = json['adres'];
    il = json['il'];
    ilce = json['ilce'];
    mahalle = json['mahalle'];
    ilAdi = json['ilAdi'];
    ilceAdi = json['ilceAdi'];
    mahalleAdi = json['mahalleAdi'];
    postakodu = json['postakodu'];
    tarih = json['tarih'];
    varsayilanAdres = json['varsayilan_adres'];
  }
}

Future<List<Adreslistemode>> getAdresgetir() async {
  var data = {"kullaniciId": Config.kullaniciid};
  var veri = await Config().postMethod("kullanici/adresler", data);
  var body = jsonDecode(veri) as List;
  return body.map((e) => Adreslistemode.fromJson(e)).toList();
}
