// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:biorganikpazar/components/app_bar.dart';
import 'package:biorganikpazar/components/detaysatikanaliexpress.dart';
import 'package:biorganikpazar/components/detaysatiskanaliperakende.dart';
import 'package:biorganikpazar/components/detaysatiskanalitoptan.dart';
import 'package:biorganikpazar/components/drawer_kategor.dart';
import 'package:biorganikpazar/components/slider_galeri.dart';
import 'package:biorganikpazar/config/config.dart';
import 'package:biorganikpazar/models/urundetay_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';

// ignore: camel_case_types
class Urun_detay extends StatefulWidget {
  final String link, urunkodu;
  const Urun_detay({Key? key, required this.link, required this.urunkodu})
      : super(key: key);

  @override
  State<Urun_detay> createState() => _Urun_detayState();
}

// ignore: camel_case_types
class _Urun_detayState extends State<Urun_detay> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final Future<List<Urundetay>> _urundetay;
  late final Future<List<Mahalleler>> _mahdetay;
  bool aciklama = false,
      teslimat = false,
      yorumlar = false,
      sss = false,
      taze = true,
      toptan = false,
      jet = false;
  bool konums = false;

  int adetim = 0;
  @override
  void initState() {
    super.initState();

    _urundetay = urunGetir(widget.link, widget.urunkodu.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: App_bar(scfkey: _scaffoldKey),
      drawer: const Drawer_kategori(
        kategoriId: "44",
      ),
      body: FutureBuilder<List<Urundetay>>(
          future: _urundetay,
          builder: (context, snaphost) {
            if (snaphost.hasData) {
              var datam = snaphost.data![0];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Slider_galeri(
                        resimler: datam.urunresim,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        datam.urunAdi.toString(),
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                datam.urunKodu.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(),
                              ),
                            ),
                            RatingBarIndicator(
                              rating: double.parse(datam.puanlama.toString()),
                              itemCount: 5,
                              itemSize: 16,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text("${datam.yorumadet} | ${datam.satisadeti} ")
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Text("${datam.urunKisaAciklama}"),
                    ),
                    SliverToBoxAdapter(
                      child: Card(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        child: Padding(
                          child: Wrap(
                            children: [
                              TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(FontAwesome.home),
                                label: Text("${datam.uruntezgah!.tezgahAdi}"),
                              ),
                              TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  FontAwesome5.store,
                                  size: 15,
                                  color: Colors.orange,
                                ),
                                label: Text(
                                  "${datam.uruntezgah?.toplamurun}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  FontAwesome5.shipping_fast,
                                  size: 15,
                                  color: Colors.orange,
                                ),
                                label: Text(
                                  "${datam.uruntezgah!.toplamsatis}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  FontAwesome5.star,
                                  size: 15,
                                  color: Colors.orange,
                                ),
                                label: Text(
                                  "${datam.uruntezgah!.puan}",
                                  style: const TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(10),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Wrap(
                        spacing: 4,
                        children: [
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              FontAwesome5.tractor,
                              size: 15,
                            ),
                            label: Text(
                              datam.kimdenbaslik.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              FontAwesome5.heart,
                              size: 15,
                            ),
                            label: Text(
                              datam.uretimbaslik.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              FontAwesome5.envira,
                              size: 15,
                            ),
                            label: Text(
                              datam.statubaslik.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        alignment: Alignment.center,
                        height: 42,
                        child: const Text("SATIŞ KANALLARI"),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MaterialButton(
                              color:
                                  taze == true ? Colors.orange : Colors.white,
                              child: Stack(children: [
                                Icon(
                                  FontAwesome.cube,
                                  color:
                                      taze == true ? Colors.black : Colors.grey,
                                ),
                                taze == true
                                    ? Text("Taze",
                                        style: TextStyle(color: Colors.white))
                                    : Text("Taze",
                                        style: TextStyle(color: Colors.black))
                              ]),
                              onPressed: () {
                                setState(() {
                                  taze = !taze;
                                  toptan = false;
                                  jet = false;
                                });
                              },
                            ),
                            MaterialButton(
                              color:
                                  toptan == true ? Colors.orange : Colors.white,
                              child: Stack(children: [
                                Icon(
                                  FontAwesome.cubes,
                                  color: toptan == true
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                                toptan == true
                                    ? Text("Avatantajlı",
                                        style: TextStyle(color: Colors.white))
                                    : Text("Avatantajlı",
                                        style: TextStyle(color: Colors.black))
                              ]),
                              onPressed: () {
                                setState(() {
                                  taze = false;
                                  toptan = !toptan;
                                  jet = false;
                                });
                              },
                            ),
                            if (Config.konum != "")
                              MaterialButton(
                                color:
                                    jet == true ? Colors.orange : Colors.white,
                                child: Stack(children: [
                                  Icon(
                                    FontAwesome.motorcycle,
                                    color: jet == true
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                  jet == true
                                      ? Text("Jet",
                                          style: TextStyle(color: Colors.white))
                                      : Text("Jet",
                                          style: TextStyle(color: Colors.black))
                                ]),
                                onPressed: () {
                                  setState(() {
                                    taze = false;
                                    toptan = false;
                                    jet = !jet;
                                  });
                                },
                              )
                            else
                              ElevatedButton(
                                child: Stack(children: [
                                  Icon(
                                    FontAwesome.location,
                                    color: Colors.black,
                                  ),
                                  Text("Konum Seç"),
                                ]),
                                onPressed: () {
                                  Config().displayDialog(context);
                                  setState(() {
                                    taze = false;
                                    toptan = false;
                                    jet = Config.konumsecildi;
                                  });

                                  ;
                                },
                              ),
                          ]),
                    ),
                    SliverToBoxAdapter(
                        child: taze == true
                            ? Detaysatiskanaliperakende(
                                datam: datam,
                                tip: "Taze",
                              )
                            : null),
                    SliverToBoxAdapter(
                        child: toptan == true
                            ? Detaysatiskanalitoptan(
                                datam: datam,
                                tip: "Avantajlı",
                              )
                            : null),
                    SliverToBoxAdapter(
                        child: jet == true
                            ? (Detaysatikanaliexpress(
                                datam: datam,
                                tip: "Jet",
                              ))
                            : null),
                    SliverToBoxAdapter(
                      child: Container(
                        alignment: Alignment.center,
                        height: 42,
                        child: const Text("ÜRÜN BİLGİLERİ"),
                      ),
                    ),
                    SliverToBoxAdapter(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Ürün Açıklaması"),
                        Text(
                          datam.urunUzunAciklama.toString(),
                          textAlign: TextAlign.left,
                        ),
                        const Divider(),
                        ExpansionTile(
                            title: new Text("Taze Kargolama"),
                            children: <Widget>[
                              Visibility(
                                child: const Text("",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17)),
                                visible: (datam.uruntezgah!.perakende == "1" &&
                                        datam.urunkargo!
                                                .perakendeKargoUcretiFiyat !=
                                            null)
                                    ? true
                                    : false,
                              ),
                              Visibility(
                                child: Table(
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.top,
                                  border: TableBorder.all(
                                      width: 0.1, color: Colors.grey),
                                  children: [
                                    TableRow(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Kargo Miktarı",
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(datam
                                                  .urunkargo!.perakendeAdet
                                                  .toString() +
                                              " / ${datam.birimSembol}"),
                                        )
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Kargolama Süresi",
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(datam
                                              .urunkargo!.perakende!.adi
                                              .toString()),
                                        )
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Kargo Türü",
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(datam.urunkargo!
                                              .perakende!.gonderim!.title
                                              .toString()),
                                        )
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Kargo Şartı",
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(datam.urunkargo!
                                              .perakende!.gonderim!.gonderimAdi
                                              .toString()),
                                        )
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Kargo Firması",
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(datam
                                              .urunkargo!
                                              .perakende!
                                              .kargo!
                                              .gonderimKargoFirmasiAdi!
                                              .firmaAdi
                                              .toString()),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                visible: (datam.uruntezgah!.perakende == "1" &&
                                        datam.urunkargo!
                                                .perakendeKargoUcretiFiyat !=
                                            null)
                                    ? true
                                    : false,
                              ),
                            ]),
                        const Divider(),
                        ExpansionTile(
                            title: Text("Avantajlı Kargolama"),
                            children: <Widget>[
                              Visibility(
                                child: const Text(
                                  " ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                visible: (datam.uruntezgah!.toptan == "1" &&
                                        datam.urunkargo!
                                                .toptanKargoUcretiFiyat !=
                                            null)
                                    ? true
                                    : false,
                              ),
                              Visibility(
                                child: Table(
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.top,
                                  border: TableBorder.all(
                                      width: 0.0, color: Colors.grey),
                                  children: [
                                    TableRow(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Kargo Miktarı",
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(datam
                                                  .urunkargo!.toptanAdet
                                                  .toString() +
                                              " / ${datam.birimSembol}"),
                                        )
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Kargolama Süresi",
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(datam
                                              .urunkargo!.toptan!.adi
                                              .toString()),
                                        )
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Kargo Türü",
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(datam.urunkargo!.toptan!
                                              .gonderim!.title
                                              .toString()),
                                        )
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Kargo Şartı",
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: (datam.urunkargo!.toptan!
                                                      .gonderim !=
                                                  null)
                                              ? Text(datam.urunkargo!.toptan!
                                                  .gonderim!.gonderimAdi
                                                  .toString())
                                              : const Text(""),
                                        )
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Kargo Firması",
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: (datam
                                                      .urunkargo!
                                                      .toptan!
                                                      .kargo!
                                                      .gonderimKargoFirmasiAdi !=
                                                  null)
                                              ? Text(datam
                                                  .urunkargo!
                                                  .toptan!
                                                  .kargo!
                                                  .gonderimKargoFirmasiAdi!
                                                  .firmaAdi
                                                  .toString())
                                              : const Text(""),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                visible: (datam.uruntezgah!.toptan == "1" &&
                                        datam.urunkargo!
                                                .toptanKargoUcretiFiyat !=
                                            null)
                                    ? true
                                    : false,
                              ),
                            ]),
                        const Divider(),
                        ExpansionTile(title: Text("Jet Kargolama "), children: <
                            Widget>[
                          Visibility(
                            child: const Text(
                              " ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                            visible: (datam.uruntezgah!.express == "1" &&
                                    datam.urunkargo!.expressKargoUcretiFiyat !=
                                        null)
                                ? true
                                : false,
                          ),
                          Visibility(
                            child: Table(
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.top,
                              border: TableBorder.all(
                                  width: 0.0, color: Colors.grey),
                              children: [
                                TableRow(
                                  children: [
                                    const Text(
                                      "Kargo Miktarı",
                                    ),
                                    Text(datam.urunkargo!.expressAdet
                                            .toString() +
                                        " / ${datam.birimSembol}")
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    const Text(
                                      "Kargolama Süresi",
                                    ),
                                    Text(datam.urunkargo!.express!.adi
                                        .toString())
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    const Text(
                                      "Kargo Türü",
                                    ),
                                    Text((datam.urunkargo!.express!.gonderim !=
                                            null)
                                        ? datam
                                            .urunkargo!.express!.gonderim!.title
                                            .toString()
                                        : ""),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    const Text(
                                      "Kargo Şartı",
                                    ),
                                    Text((datam.urunkargo!.express!.gonderim !=
                                            null)
                                        ? datam.urunkargo!.express!.gonderim!
                                            .gonderimAdi
                                            .toString()
                                        : ""),
                                  ],
                                ),
                                TableRow(
                                  children: [
                                    const Text(
                                      "Kargo Firması",
                                    ),
                                    Text((datam.urunkargo!.express!.kargo!
                                                .gonderimKargoFirmasiAdi !=
                                            null)
                                        ? datam.urunkargo!.express!.kargo!
                                            .gonderimKargoFirmasiAdi!.firmaAdi
                                            .toString()
                                        : ""),
                                  ],
                                ),
                              ],
                            ),
                            visible: (datam.uruntezgah!.express == "1" &&
                                    datam.urunkargo!.expressKargoUcretiFiyat !=
                                        null)
                                ? true
                                : false,
                          ),
                        ])
                      ],
                    )),
                  ],
                ),
              );
            } else {
              return const Center(
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }

  Future<List<Urundetay>> urunGetir(String link, String id) async {
    var veriler = await Config().getMethod("urunler/detay/${link}/${id}", {});
    var body = json.decode(veriler) as List;
    // print(body);
    return body.map((e) => Urundetay.fromJson(e)).toList();
  }
}
