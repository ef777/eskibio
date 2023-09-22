import 'dart:convert';

import 'package:biorganikpazar/config/config.dart';

class Kullanicisorumodel {
  String? id;
  String? kodu;
  String? urunId;
  String? urunKodu;
  String? tezgahId;
  String? tezgahKodu;
  String? kullaniciId;
  String? kullaniciKimlik;
  String? durum;
  String? cevapDurum;
  String? zaman;
  String? ip;
  String? urunAdi;
  String? vitrinResim;
  String? urunLink;
  String? kullaniciAdi;
  String? tezgahLink;
  String? tezgahAdi;
  String? mesaj;
  String? tarih;

  Kullanicisorumodel(
      {this.id,
      this.kodu,
      this.urunId,
      this.urunKodu,
      this.tezgahId,
      this.tezgahKodu,
      this.kullaniciId,
      this.kullaniciKimlik,
      this.durum,
      this.cevapDurum,
      this.zaman,
      this.ip,
      this.urunAdi,
      this.vitrinResim,
      this.urunLink,
      this.kullaniciAdi,
      this.tezgahLink,
      this.tezgahAdi,
      this.mesaj,
      this.tarih});

  Kullanicisorumodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kodu = json['kodu'];
    urunId = json['urun_id'];
    urunKodu = json['urun_kodu'];
    tezgahId = json['tezgah_id'];
    tezgahKodu = json['tezgah_kodu'];
    kullaniciId = json['kullanici_id'];
    kullaniciKimlik = json['kullanici_kimlik'];
    durum = json['durum'];
    cevapDurum = json['cevap_durum'];
    zaman = json['zaman'];
    ip = json['ip'];
    urunAdi = json['urun_adi'];
    vitrinResim = json['vitrin_resim'];
    urunLink = json['urun_link'];
    kullaniciAdi = json['kullaniciAdi'];
    tezgahLink = json['tezgah_link'];
    tezgahAdi = json['tezgah_adi'];
    mesaj = json['mesaj'];
    tarih = json['tarih'];
  }
}

Future<List<Kullanicisorumodel>> getkullanicisorulari() async {
  var data = {"kullaniciId": 2};
  var sonuc = await Config().postMethod("kullanici/sorular", data);
  var body = jsonDecode(sonuc) as List;
  return body.map((e) => Kullanicisorumodel.fromJson(e)).toList();
}
