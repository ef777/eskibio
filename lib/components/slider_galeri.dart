import 'package:biorganikpazar/config/config.dart';
import 'package:biorganikpazar/models/urundetay_model.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Slider_galeri extends StatefulWidget {
  final List<Urunresim>? resimler;
  const Slider_galeri({Key? key, this.resimler}) : super(key: key);

  @override
  State<Slider_galeri> createState() => _Slider_galeriState();
}

// ignore: camel_case_types
class _Slider_galeriState extends State<Slider_galeri> {
  late List<Urunresim>? urunresimleri;
  late String urunId;
  int pageIndex = 0;
  @override
  void initState() {
    super.initState();
    urunresimleri = widget.resimler;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.width / 3 * 2,
      child: Stack(
        children: [
          PageView.builder(
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            itemCount: urunresimleri!.length,
            itemBuilder: (BuildContext context, int itemIndex) {
              var resimitem = urunresimleri![itemIndex];
              return Image.network(
                resimitem.resim.toString(),
                fit: BoxFit.contain,
              );
            },
          ),
          Positioned(
            child: SizedBox(
              height: 15,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width / 10 - 10,
                      height: 10,
                      margin: const EdgeInsets.all(5),
                      color: (pageIndex == index) ? Colors.red : Colors.grey,
                    );
                  },
                  itemCount: urunresimleri?.length,
                ),
              ),
            ),
            bottom: 10,
          ),
        ],
      ),
    );
  }
}
