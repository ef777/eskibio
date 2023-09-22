import 'package:biorganikpazar/models/ilcemodel.dart';
import 'package:biorganikpazar/models/ilmodel.dart';
import 'package:biorganikpazar/models/mahallemodel.dart';
import 'package:flutter/material.dart';

class Ilgetir extends StatefulWidget {
  const Ilgetir({Key? key}) : super(key: key);

  @override
  State<Ilgetir> createState() => _IlgetirState();
}

class _IlgetirState extends State<Ilgetir> {
  late final Future<List<Ilmodel>> illiste;
  @override
  void initState() {
    illiste = getIlgetir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Ilmodel>>(
        builder: (context, snaphost) {
          if (snaphost.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                var datam = snaphost.data![index];
                List<String> avatar = datam.il!.split("");
                return ListTile(
                  onTap: () {
                    Navigator.pop(context, {
                      "title": datam.il.toString(),
                      "plaka": datam.plaka.toString()
                    });
                  },
                  leading: CircleAvatar(child: Text(avatar[0])),
                  title: Text(datam.il.toString()),
                );
              },
              itemCount: snaphost.data!.length,
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
        future: illiste,
      ),
    );
  }
}

class Ilcegetir extends StatefulWidget {
  final String plaka;
  const Ilcegetir({Key? key, required this.plaka}) : super(key: key);

  @override
  State<Ilcegetir> createState() => _IlcegetirState();
}

class _IlcegetirState extends State<Ilcegetir> {
  late final Future<List<Ilcemodel>> ilceliste;
  @override
  void initState() {
    ilceliste = getIlceGetir(widget.plaka);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Ilcemodel>>(
        builder: (context, snaphost) {
          if (snaphost.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                var datam = snaphost.data![index];
                List<String> avatar = datam.ilce!.split("");
                return ListTile(
                  onTap: () {
                    Navigator.pop(context, {
                      "title": datam.ilce.toString(),
                      "plaka": datam.ilceKey.toString()
                    });
                  },
                  leading: CircleAvatar(child: Text(avatar[0])),
                  title: Text(datam.ilce.toString()),
                );
              },
              itemCount: snaphost.data!.length,
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
        future: ilceliste,
      ),
    );
  }
}

class Mahallegetir extends StatefulWidget {
  final String ilcekey;
  const Mahallegetir({Key? key, required this.ilcekey}) : super(key: key);

  @override
  State<Mahallegetir> createState() => _MahallegetirState();
}

class _MahallegetirState extends State<Mahallegetir> {
  late final Future<List<Mahallemodel>> mahalleliste;
  @override
  void initState() {
    mahalleliste = getMahalleGetir(widget.ilcekey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Mahallemodel>>(
        builder: (context, snaphost) {
          if (snaphost.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                var datam = snaphost.data![index];
                List<String> avatar = datam.mahalle!.split("");
                return ListTile(
                  onTap: () {
                    Navigator.pop(context, {
                      "title": datam.mahalle.toString(),
                      "plaka": datam.mahalleKey.toString()
                    });
                  },
                  leading: CircleAvatar(child: Text(avatar[0])),
                  title: Text(datam.mahalle.toString()),
                );
              },
              itemCount: snaphost.data!.length,
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
        future: mahalleliste,
      ),
    );
  }
}
