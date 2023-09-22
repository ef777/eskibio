import 'dart:convert';

import 'package:biorganikpazar/config/config.dart';

class BannerModel {
  BannerModel({
    required this.sliderId,
    required this.resim,
    required this.resimK,
    required this.baslik,
    required this.baslik2,
    required this.aciklama,
    required this.aciklama2,
    required this.url,
    required this.urlAdi,
    required this.durum,
    this.tarih,
    this.ip,
    this.tarihSayisal,
  });

  String sliderId;
  String resim;
  String resimK;
  String baslik;
  String baslik2;
  String aciklama;
  String aciklama2;
  String url;
  String urlAdi;
  String durum;
  dynamic tarih;
  dynamic ip;
  dynamic tarihSayisal;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        sliderId: json["slider_id"],
        resim: json["resim"],
        resimK: json["resim_k"],
        baslik: json["baslik"],
        baslik2: json["baslik_2"],
        aciklama: json["aciklama"],
        aciklama2: json["aciklama_2"],
        url: json["url"],
        urlAdi: json["url_adi"],
        durum: json["durum"],
        tarih: json["tarih"],
        ip: json["ip"],
        tarihSayisal: json["tarih_sayisal"],
      );

  Map<String, dynamic> toJson() => {
        "slider_id": sliderId,
        "resim": resim,
        "resim_k": resimK,
        "baslik": baslik,
        "baslik_2": baslik2,
        "aciklama": aciklama,
        "aciklama_2": aciklama2,
        "url": url,
        "url_adi": urlAdi,
        "durum": durum,
        "tarih": tarih,
        "ip": ip,
        "tarih_sayisal": tarihSayisal,
      };
}

Future<List<BannerModel>> getBannerliste() async {
  var data = {};
  var dersler = await Config().getMethod("ayarlar/banner", data);
  var body = json.decode(dersler) as List;
  return body.map((e) => BannerModel.fromJson(e)).toList();
}
