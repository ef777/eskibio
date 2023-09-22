import 'dart:convert';

import 'package:biorganikpazar/config/config.dart';

class Favoritezgahmodel {
  String? id;
  String? tezgahlogo;
  String? tezgahId;
  String? tezgahToken;
  String? tezgahKodu;
  String? tezgahAdi;
  String? sifre;
  String? kayitTarih;
  String? kayitIp;
  String? durum;
  String? telefon;
  String? eposta;
  String? epostaOnay;
  String? logo;
  String? kapakFoto;
  String? aciklama;
  String? kadinGirisimci;
  String? perakende;
  String? toptan;
  String? express;
  String? puan;
  String? statu;
  String? tezgahKategori;
  String? tezgahLink;
  String? toplamurun;
  String? toplamsiparis;

  Favoritezgahmodel(
      {this.id,
      this.tezgahlogo,
      this.tezgahId,
      this.tezgahToken,
      this.tezgahKodu,
      this.tezgahAdi,
      this.sifre,
      this.kayitTarih,
      this.kayitIp,
      this.durum,
      this.telefon,
      this.eposta,
      this.epostaOnay,
      this.logo,
      this.kapakFoto,
      this.aciklama,
      this.kadinGirisimci,
      this.perakende,
      this.toptan,
      this.express,
      this.puan,
      this.statu,
      this.tezgahKategori,
      this.tezgahLink,
      this.toplamurun,
      this.toplamsiparis});

  Favoritezgahmodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tezgahlogo = json['tezgahlogo'];
    tezgahId = json['tezgah_id'];
    tezgahToken = json['tezgah_token'];
    tezgahKodu = json['tezgah_kodu'];
    tezgahAdi = json['tezgah_adi'];
    sifre = json['sifre'];
    kayitTarih = json['kayit_tarih'];
    kayitIp = json['kayit_ip'];
    durum = json['durum'];
    telefon = json['telefon'];
    eposta = json['eposta'];
    epostaOnay = json['eposta_onay'];
    logo = json['logo'];
    kapakFoto = json['kapak_foto'];
    aciklama = json['aciklama'];
    kadinGirisimci = json['kadin_girisimci'];
    perakende = json['perakende'];
    toptan = json['toptan'];
    express = json['express'];
    puan = json['puan'];
    statu = json['statu'];
    tezgahKategori = json['tezgah_kategori'];
    tezgahLink = json['tezgah_link'];
    toplamurun = json['toplamurun'];
    toplamsiparis = json['toplamsiparis'];
  }
}

Future<List<Favoritezgahmodel>> getfavoritezgahlar() async {
  var data = {"kullaniciId": Config.kullaniciid};
  var sonuc = await Config().postMethod("kullanici/favoritezgah", data);
  var body = jsonDecode(sonuc) as List;
  return body.map((e) => Favoritezgahmodel.fromJson(e)).toList();
}
