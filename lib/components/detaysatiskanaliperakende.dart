import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:biorganikpazar/components/adetinput.dart';
import 'package:biorganikpazar/config/config.dart';
import 'package:biorganikpazar/models/urundetay_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Detaysatiskanaliperakende extends StatelessWidget {
  final Urundetay datam;
  final String tip;
  late int adet = 1;
  Detaysatiskanaliperakende({Key? key, required this.tip, required this.datam})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: Column(
        children: [
          Visibility(
            child: Text(
              "Bu ürün ₺${datam.urunkargo!.perakendeKargoUcretiAltLimit.toString()} altı ₺${datam.urunkargo!.perakendeKargoUcretiFiyat} üzeri ücretsiz kargo olarak, ${datam.urunkargo!.perakende!.adi}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.red),
            ),
            visible: (datam.urunkargo!.perakende!.gonderim!.id == "3")
                ? true
                : false,
          ),
          Visibility(
            child: Text(
              "Bu ürün Ücretsiz Kargo olarak,${datam.urunkargo!.perakende!.adi} kargoda.",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.red),
            ),
            visible: (datam.urunkargo!.perakende!.gonderim!.id == "1")
                ? true
                : false,
          ),
          Visibility(
            child: Text(
              "Bu ürün ₺${datam.urunkargo!.perakendeKargoUcretiFiyat} ücretli kargo olarak, ${datam.urunkargo!.perakende!.adi} kargoda.",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.red),
            ),
            visible: (datam.urunkargo!.perakende!.gonderim!.id == "2")
                ? true
                : false,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    maxLines: 3,
                    text: TextSpan(
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'FİYAT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        TextSpan(
                          text: ': ₺${datam.urunkargo!.perakendeFiyat}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' / ${datam.urunkargo!.perakendeAdet} ${datam.birimSembol}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 150,
                child: Adetinput(
                  ilkadet: adet,
                  maxadet: 10,
                  minadet: 1,
                  adetgetir: (val) {
                    adet = int.parse(val.toString());
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: const Text("Sepete Ekle"),
              onPressed: () {
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
                var durun = Config().sepetekle(urun);

                ArtSweetAlert.show(
                  context: context,
                  artDialogArgs: ArtDialogArgs(
                    confirmButtonText: "Tamam",
                    type: (durun)
                        ? ArtSweetAlertType.success
                        : ArtSweetAlertType.danger,
                    title: (durun) ? "Başarılı" : "Hatalı",
                    text: (durun)
                        ? "Başarıyla ürün Sepete Eklendi"
                        : "Lütfen Bir adet Girin",
                  ),
                );
              },
            ),
          )
        ],
      ),
      visible: (datam.uruntezgah!.perakende == "1" &&
              datam.urunkargo!.perakendeKargoUcretiFiyat != null)
          ? true
          : false,
    );
  }
}
