import 'dart:convert';

import '../config/config.dart';

class KategorilisteModel {
  String? id;
  String? name;
  String? parentId;
  String? icon;
  String? mi;

  KategorilisteModel({this.id, this.mi, this.name, this.parentId, this.icon});

  KategorilisteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    icon = json['icon'];
    mi = json['mi'];
  }
}

Future<List<KategorilisteModel>> getKategorifulliste(String kategori) async {
  var data = {};
  var dersler = await Config()
      .getMethod("urunler/kategoriler/" + kategori.toString(), data);
  var body = json.decode(dersler) as List;
  return body.map((e) => KategorilisteModel.fromJson(e)).toList();
}
