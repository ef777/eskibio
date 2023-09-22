import 'package:biorganikpazar/config/config.dart';
import 'package:biorganikpazar/models/siparislistemodel.dart';
import 'package:flutter/material.dart';

class Siparisblog extends StatelessWidget {
  final String? id, siparisKodu, durumu, kanal, toplamtutar, tarih, islem;
  final List<Urunler>? urunler;
  const Siparisblog(
      {Key? key,
      this.id,
      this.siparisKodu,
      this.durumu,
      this.kanal,
      this.toplamtutar,
      this.tarih,
      this.islem,
      this.urunler})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(child: Text("Sipariş No :")),
                Text(siparisKodu.toString())
              ],
            ),
            Row(
              children: [
                const Expanded(child: Text("Sipariş Tarihi :")),
                Text(tarih.toString())
              ],
            ),
            Row(
              children: [
                const Expanded(
                    child: Text(
                  "Ödeme Tutar :",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                Text(toplamtutar.toString())
              ],
            ),
            const Divider(),
            Text("Sipariş Durumu : $durumu"),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var urunbilgi = urunler![index];
                return Row(
                  children: [
                    Image.network(
                      Config().cdnUrl +
                          "urunler/" +
                          urunbilgi.urunKodu.toString() +
                          "/crop/" +
                          urunbilgi.vitrinResim.toString(),
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(urunbilgi.urunAdi.toString()),
                          Row(
                            children: [
                              Expanded(
                                child:
                                    Text(urunbilgi.adet.toString() + " Adet"),
                              ),
                              Text(urunbilgi.fiyat.toString() + " TL"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              itemCount: urunler?.length,
            ),
            const Divider(),
            Row(
              children: const [
                Expanded(child: Text("Sipariş Detayını Gör")),
                Icon(Icons.keyboard_arrow_right)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
