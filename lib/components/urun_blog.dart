// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:biorganikpazar/config/config.dart';
import 'package:biorganikpazar/models/urundetay_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/route_manager.dart';

// ignore: camel_case_types
class Urun_Blog extends StatefulWidget {
  final String title,
      img,
      kargo,
      fiyat,
      link,
      urunkodu,
      tip,
      birimdeger,
      degerlendirme,
      yorumadet,
      kanal,
      id;

  Urun_Blog({
    Key? key,
    required this.id,
    required this.link,
    required this.urunkodu,
    required this.title,
    required this.img,
    required this.kargo,
    required this.fiyat,
    required this.tip,
    required this.birimdeger,
    required this.degerlendirme,
    required this.kanal,
    required this.yorumadet,
  }) : super(key: key);

  @override
  State<Urun_Blog> createState() => _Urun_BlogState();
}

class _Urun_BlogState extends State<Urun_Blog> {
  // late final Urundetay? datam;
  late int adet = 1;
  late final Future<List<Urundetay>> urundetayy;
  Future<List<Urundetay>> urunGetir(String link, String id) async {
    var veriler = await Config().getMethod("urunler/detay/${link}/${id}", {});
    var body = json.decode(veriler) as List;
    //print(body);
    return body.map((e) => Urundetay.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => Duyurular()));
        Get.toNamed("/urun/${widget.link}/${widget.urunkodu}");
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.1, color: Colors.grey),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(children: [
                Image.network(
                  Config().cropImage(widget.img, "100", "100", "1"),
                  fit: BoxFit.contain,
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
                Positioned.fill(
                  child: Align(
                      alignment: Alignment.topRight,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        height: 30.0,
                        minWidth: 30.0,
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        textColor: Colors.white,
                        child: new Text("+"),
                        onPressed: () async {
                          print("bastın");
                          final urundetayy = await urunGetir(
                              widget.link, widget.urunkodu.toString());

                          var datam = urundetayy[0];
                          print(datam.urunAdi);
                          List urun = [
                            {
                              "title": datam.urunAdi.toString(),
                              "urunId": datam.id.toString(),
                              "resim": datam.vitrinResim.toString(),
                              "fiyat": datam.urunkargo!.perakendeFiyat,
                              "kargo": "taze",
                              "link": datam.urunLink,
                              "urunKodu": datam.urunKodu,
                              "adet": adet,
                              "tip": "Ücretsiz Kargo"
                            }
                          ];
                          print("tamamlandi");
                          Config().sepetekle(urun);
                        },
                        splashColor: Colors.redAccent,
                      )),
                ),
              ]),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                child: Text(
                  widget.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13),
                ),
                height: 38,
              ),
              const SizedBox(
                height: 5,
              ),
              Wrap(
                children: [
                  RatingBarIndicator(
                    rating: double.parse(widget.degerlendirme),
                    itemCount: 5,
                    itemSize: 16,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text("( ${widget.yorumadet} )"),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.kargo,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.orange),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: '₺' + widget.fiyat.toString() + "  / ",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ), // default text style
                        children: <TextSpan>[
                          TextSpan(
                            text: '${widget.tip} ${widget.birimdeger}',
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Icon(
                    (widget.kanal == "perakende")
                        ? FontAwesome.cube
                        : (widget.kanal == "toptan")
                            ? FontAwesome.cubes
                            : FontAwesome.motorcycle,
                    size: 16,
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
