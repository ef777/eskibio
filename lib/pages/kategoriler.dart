import 'package:biorganikpazar/components/app_bar.dart';
import 'package:biorganikpazar/models/kategori_model.dart';
import 'package:biorganikpazar/pages/urun_liste.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Kategoriler extends StatefulWidget {
  final String katId;
  const Kategoriler({Key? key, this.katId = "44"}) : super(key: key);

  @override
  State<Kategoriler> createState() => _KategorilerState();
}

class _KategorilerState extends State<Kategoriler> {
  late Future<List<KategorilisteModel>> _kategorileri;
  late String katId;
  @override
  void initState() {
    super.initState();
    katId = widget.katId;
    getKategoriListe(katId);
  }

  getKategoriListe(String kat) {
    _kategorileri = getKategorifulliste(kat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const App_bar(),
      body: SafeArea(
        child: FutureBuilder<List<KategorilisteModel>>(
          future: _kategorileri,
          builder: (context, snap) {
            if (snap.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  var body = snap.data![index];
                  return ListTile(
                    title: Text(body.name.toString()),
                    trailing: SvgPicture.network(
                        "https://www.svgrepo.com/show/415227/whiteboard.svg"),
                    onTap: () {
                      (int.parse(body.mi.toString()) > 0)
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Kategoriler(
                                    katId: body.id.toString(),
                                  )))
                          : Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Urun_liste(
                                    kategorim: body.id.toString(),
                                  )));
                    },
                  );
                },
                itemCount: snap.data?.length,
              );
            } else {
              return const Center(
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
