import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class Anaban {
  String name;
  var icon;
  Anaban(this.name, this.icon);
}

List<Anaban> AnabanList = [
  Anaban(
      'Vegan',
      (Icon(
        FontAwesome.leaf,
        color: Colors.white,
      ))),
  Anaban('Glütensiz', (Icon(FontAwesome.slack, color: Colors.white))),
  Anaban('Diyet', (Icon(FontAwesome.wikipedia_w, color: Colors.white))),
  Anaban('Girişimci Kadınlar', (Icon(FontAwesome.female, color: Colors.white))),
  Anaban('Fırsatlar', (Icon(FontAwesome.inbox, color: Colors.white))),
  Anaban('Organik Ürünler', (Icon(FontAwesome.apple, color: Colors.white))),
  Anaban('Tezgah', (Icon(FontAwesome.safari, color: Colors.white)))
];
