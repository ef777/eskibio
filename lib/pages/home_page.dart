import 'package:biorganikpazar/components/anabanlist.dart';
import 'package:biorganikpazar/components/app_bar.dart';
import 'package:biorganikpazar/components/kanal_button.dart';
import 'package:biorganikpazar/components/kategoributtons.dart';
import 'package:biorganikpazar/components/urun_blog.dart';
import 'package:biorganikpazar/components/urungrup_title.dart';
import 'package:biorganikpazar/config/config.dart';
import 'package:biorganikpazar/models/banner_model.dart';
import 'package:biorganikpazar/models/urunliste_model.dart';
import 'package:biorganikpazar/pages/urun_liste.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';

// ignore: camel_case_types
class Home_page extends StatefulWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  State<Home_page> createState() => _Home_pageState();
}

// ignore: camel_case_types
class _Home_pageState extends State<Home_page> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<List<BannerModel>> _banner;
  late Future<List<Urunliste_model>> _urungruplari;
  late Future<List<Urunliste_model>> _vitringup;
  int urungrupakitf = 0;
  String urungruptip = "firsat_urunleri";
  int pageview = 0;
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: pageview, viewportFraction: 1 / 2);

    geturungrup(urungruptip);
  }

  geturungrup(String tip) {
    _urungruplari = getUrungruplari(tip);
    _banner = getBannerliste();
    _vitringup = getUrungruplari("vitrin_urunleri");
    setState(() {
      urungruptip = tip;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: App_bar(),
      body: FutureBuilder(
        future: Future.wait([_banner, _urungruplari, _vitringup]),
        builder: (context, AsyncSnapshot<List<dynamic>> snaphost) {
          if (snaphost.hasData) {
            var banner = snaphost.data![0];
            var urungruplari = snaphost.data![1];
            var vitringrup = snaphost.data![2];
            return RefreshIndicator(
              onRefresh: () async {
                geturungrup(urungruptip);
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Visibility(
                      visible: (banner.length > 0) ? true : false,
                      child: SizedBox(
                        height: 250,
                        child: Stack(children: [
                          PageView.builder(
                            padEnds: false,
                            itemBuilder: (context, index) {
                              var body = banner[index];
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(Config().cdnUrl +
                                        "slider/" +
                                        body.resim),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        body.baslik,
                                        style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(body.aciklama),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: banner.length,
                          ),
                        ]),
                      ),
                    ),
                  ),
                  /*  SliverToBoxAdapter(
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0; i < AnabanList.length; i++)
                              CategoryButton(
                                name: AnabanList[i].name,
                                icon: AnabanList[i].icon,
                                onTap: () {},
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                */
                  SliverToBoxAdapter(
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 15, bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Kanalbutton(
                              baslik: "TAZE",
                              btnColor: const Color.fromARGB(255, 129, 194, 66),
                              kanalIcon: FontAwesome.cube,
                              onpress: () {
                                setState(() {
                                  Config.selectedIndex = 2;
                                });
                                Config.kanal = "perakende";
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Urun_liste()));
                              },
                            ),
                          ),
                          Expanded(
                            child: Kanalbutton(
                              baslik: "AVANTAJLI",
                              btnColor: const Color.fromARGB(255, 211, 161, 44),
                              kanalIcon: FontAwesome.cubes,
                              onpress: () {
                                setState(() {
                                  Config.selectedIndex = 1;
                                  Config.kanal = "toptan";
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Urun_liste()));
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: (Config.konum != "")
                                ? Kanalbutton(
                                    baslik: "JET İNCELE",
                                    btnColor:
                                        const Color.fromARGB(255, 77, 2, 114),
                                    kanalIcon: FontAwesome.motorcycle,
                                    onpress: () {
                                      setState(() {
                                        Config.selectedIndex = 1;
                                      });
                                      Config.kanal = "express";
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Urun_liste()));
                                    },
                                  )
                                : Kanalbutton(
                                    baslik: "KONUM",
                                    btnColor:
                                        const Color.fromARGB(255, 77, 2, 114),
                                    kanalIcon: FontAwesome.location,
                                    onpress: () {
                                      Config().displayDialog(context);
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 15, bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Urungrup_title(
                            title: "Fırsat",
                            onpress: () {
                              geturungrup("firsat_urunleri");
                            },
                          ),
                          Urungrup_title(
                            title: "Öne Çıkan",
                            onpress: () {
                              geturungrup("one_cikan_urunler");
                            },
                          ),
                          Urungrup_title(
                            title: "En Çok Satılanlar",
                            onpress: () {
                              geturungrup("cok_satilanlar");
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Visibility(
                      visible: (urungruplari.length > 0) ? true : false,
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 15, bottom: 10),
                        height: 300,
                        child: PageView.builder(
                          controller: _pageController,
                          padEnds: false,
                          itemBuilder: (context, index) {
                            var body = urungruplari![index];
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
                          itemCount: urungruplari.length,
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 15, bottom: 10),
                      child: const Text(
                        "Vitrin",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.60,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        var body = vitringrup![index];
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
                      childCount: vitringrup.length ?? 0,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: SizedBox(
                width: 32,
                height: 32,
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
