import 'dart:convert';

import 'package:biorganikpazar/config/config.dart';

class Ilmodel {
  String? sehirId;
  String? il;
  String? plaka;

  Ilmodel({this.sehirId, this.il, this.plaka});

  Ilmodel.fromJson(Map<String, dynamic> json) {
    sehirId = json['sehir_id'];
    il = json['il'];
    plaka = json['plaka'];
  }
}

Future<List<Ilmodel>> getIlgetir() async {
  var data = {};
  var dersler = await Config().getMethod("konum/ilgetir", data);
  var body = json.decode(dersler) as List;
  return body.map((e) => Ilmodel.fromJson(e)).toList();
}
