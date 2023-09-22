import 'dart:async';
import 'dart:convert';

import 'package:biorganikpazar/components/app_bar.dart';
import 'package:biorganikpazar/components/urun_blog.dart';
import 'package:biorganikpazar/config/config.dart';
import 'package:biorganikpazar/models/urunliste_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';

// ignore: camel_case_types
class Urun_liste extends StatefulWidget {
  final String kategorim;
  const Urun_liste({Key? key, this.kategorim = "44"}) : super(key: key);

  @override
  State<Urun_liste> createState() => _Urun_listeState();
}

// ignore: camel_case_types
class _Urun_listeState extends State<Urun_liste> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final StreamController<List<Urunliste_model>> _streamController =
      StreamController();
  final ScrollController _scrollController = ScrollController();
  final List<Urunliste_model> urunlsitem = [];
  String siralama = "ozel";
  int adet = 0;
  bool scroldurum = true;
  @override
  void initState() {
    getUrunliste(widget.kategorim, adet);
    _scrollController.addListener(_onscrol);
    super.initState();
  }

  @override
  void dispose() {
    urunlsitem.clear();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: App_bar(
        scfkey: _scaffoldKey,
      ),
      body: StreamBuilder<List<Urunliste_model>>(
        stream: _streamController.stream,
        builder: (context, snapdata) {
          switch (snapdata.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  width: 32,
                  height: 32,
                ),
              );
            default:
              if (snapdata.hasError) {
                return const Center(
                  child: Text('Yükleniyor...'),
                );
              } else {
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.white,
                      pinned: true,
                      floating: true,
                      elevation: 0,
                      expandedHeight: 42,
                      title: Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.black,
                                alignment: Alignment.center,
                              ),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(FontAwesome.sliders),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Filtrele "),
                                  ]),
                              onPressed: () {
                                print("tıklanmadı");
                              },
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.black,
                              ),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(FontAwesome.sort),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text("Sıralama"),
                                  ]),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const SizedBox(
                                          width: 40,
                                          child: Divider(
                                              height: 3,
                                              thickness: 3,
                                              color: Colors.grey),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            urunlsitem.clear();
                                            setState(() {
                                              siralama = "ozel";
                                            });
                                            getUrunliste(widget.kategorim, 0);
                                          },
                                          title: const Text("Özel Sıralama"),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            urunlsitem.clear();
                                            setState(() {
                                              siralama = "edf";
                                            });
                                            getUrunliste(widget.kategorim, 0);
                                          },
                                          title: const Text("En Düşük Fiyat"),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            urunlsitem.clear();
                                            setState(() {
                                              siralama = "eyf";
                                            });
                                            getUrunliste(widget.kategorim, 0);
                                          },
                                          title: const Text("En Yüksek Fiyat"),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            urunlsitem.clear();
                                            setState(() {
                                              siralama = "uagaz";
                                            });
                                            getUrunliste(widget.kategorim, 0);
                                          },
                                          title:
                                              const Text("Ürün Adına Göre A-Z"),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            urunlsitem.clear();
                                            setState(() {
                                              siralama = "uagza";
                                            });
                                            getUrunliste(widget.kategorim, 0);
                                          },
                                          title:
                                              const Text("Ürün Adına Göre Z-A"),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            urunlsitem.clear();
                                            setState(() {
                                              siralama = "ecd";
                                            });
                                            getUrunliste(widget.kategorim, 0);
                                          },
                                          title: const Text(
                                              "En Çok Değerlendirilen"),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            urunlsitem.clear();
                                            setState(() {
                                              siralama = "yeu";
                                            });
                                            getUrunliste(widget.kategorim, 0);
                                          },
                                          title: const Text(
                                              "Yeni Eklenen Ürünler"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.black,
                              ),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (Config.kanal == "perakende")
                                      Icon(FontAwesome.cube),
                                    if (Config.kanal == "toptan")
                                      Icon(FontAwesome.cubes),
                                    if (Config.kanal == "express")
                                      Icon(FontAwesome.motorcycle),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    if (Config.kanal == "perakende")
                                      Text("Taze"),
                                    if (Config.kanal == "toptan")
                                      Text("Avantaj"),
                                    if (Config.kanal == "express") Text("Jet"),
                                  ]),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const SizedBox(
                                          width: 40,
                                          child: Divider(
                                              height: 3,
                                              thickness: 3,
                                              color: Colors.grey),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            urunlsitem.clear();
                                            setState(() {
                                              getUrunliste(
                                                  widget.kategorim, adet);

                                              Config.kanal = "perakende";
                                            });
                                            Navigator.pop(context);
                                          },
                                          title: const Text("Taze"),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            urunlsitem.clear();
                                            setState(() {
                                              getUrunliste(
                                                  widget.kategorim, adet);

                                              Config.kanal = "toptan";
                                            });
                                            Navigator.pop(context);
                                          },
                                          title: const Text("Avantajlı"),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            urunlsitem.clear();

                                            Config.kanal = "express";
                                            getUrunliste(
                                                widget.kategorim, adet);
                                            Navigator.pop(context);
                                          },
                                          title: const Text("Jet"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (itemWidth / itemHeight),
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          var body = snapdata.data![index];
                          return Urun_Blog(
                            title: body.urunAdi.toString(),
                            img: body.vitrinResim.toString(),
                            kargo: body.kargoDurum.toString(),
                            fiyat: body.urunFiyat.toString(),
                            link: body.urunLink.toString(),
                            kanal: Config.kanal,
                            urunkodu: body.urunKodu.toString(),
                            tip: body.urunAdet.toString(),
                            birimdeger: body.birimSembol.toString(),
                            degerlendirme: body.puanlama.toString(),
                            yorumadet: body.yorumadet.toString(),
                            id: body.id.toString(),
                          );
                        },
                        childCount: snapdata.data?.length,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: (scroldurum)
                          ? const Center(
                              child: SizedBox(
                                child: CircularProgressIndicator(),
                                width: 32,
                                height: 32,
                              ),
                            )
                          : const Text(""),
                    )
                  ],
                );
              }
          }
        },
      ),
    );
  }

  Future<void> getUrunliste(String kategorim, int adet) async {
    // Urunliste_model urunliste_model = new Urunliste_model();
    var data = {
      "konum": Config.konum,
    };
    var dersler = await Config().postMethod(
        "urunler/liste/?kategorim=" +
            kategorim +
            "&siparis=" +
            Config.kanal +
            "&basla=" +
            adet.toString() +
            "&bitis=10&sirala=$siralama&degerlendirme=0",
        data);

    var body = json.decode(dersler) as List;

    List<Urunliste_model> geturunliste =
        body.map((e) => Urunliste_model.fromJson(e)).toList();
    urunlsitem.addAll(geturunliste);
    if (geturunliste.isNotEmpty) {
      _streamController.add(urunlsitem);
      if (geturunliste.length < 10) {
        setState(() {
          scroldurum = false;
        });
      } else {
        setState(() {
          scroldurum = true;
        });
      }
    } else {
      setState(() {
        scroldurum = false;
      });
    }
  }

  void _onscrol() {
    if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels &&
        scroldurum) {
      adet = adet + 10;
      getUrunliste(widget.kategorim, adet);
    }
  }
}
