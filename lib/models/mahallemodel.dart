import 'dart:convert';

import 'package:biorganikpazar/config/config.dart';

class Mahallemodel {
  String? mahalleId;
  String? mahalle;
  String? mahalleKey;
  String? ilceKey;

  Mahallemodel({this.mahalleId, this.mahalle, this.mahalleKey, this.ilceKey});

  Mahallemodel.fromJson(Map<String, dynamic> json) {
    mahalleId = json['mahalle_id'];
    mahalle = json['mahalle'];
    mahalleKey = json['mahalle_key'];
    ilceKey = json['ilce_key'];
  }
}

Future<List<Mahallemodel>> getMahalleGetir(String ilcekey) async {
  var data = {};
  var dersler = await Config().getMethod("konum/mahallegetir/$ilcekey", data);
  var body = json.decode(dersler) as List;
  return body.map((e) => Mahallemodel.fromJson(e)).toList();
}
