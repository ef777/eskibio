import 'dart:convert';

import 'package:biorganikpazar/config/config.dart';

class Ilcemodel {
  String? ilceId;
  String? ilce;
  String? ilceKey;
  String? ilPlaka;

  Ilcemodel({this.ilceId, this.ilce, this.ilceKey, this.ilPlaka});

  Ilcemodel.fromJson(Map<String, dynamic> json) {
    ilceId = json['ilce_id'];
    ilce = json['ilce'];
    ilceKey = json['ilce_key'];
    ilPlaka = json['il_plaka'];
  }
}

Future<List<Ilcemodel>> getIlceGetir(String plaka) async {
  var data = {};
  final dersler = await Config().getMethod("konum/ilcegetir/$plaka", data);
  var body = json.decode(dersler) as List;
  return body.map((e) => Ilcemodel.fromJson(e)).toList();
}
