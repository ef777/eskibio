import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:biorganikpazar/components/adetinput.dart';
import 'package:biorganikpazar/config/config.dart';
import 'package:biorganikpazar/models/urundetay_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Detaysatiskanalitoptan extends StatelessWidget {
  final Urundetay datam;
  final String tip;
  late int adet = 1;
  Detaysatiskanalitoptan({Key? key, required this.tip, required this.datam})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      child: Column(
        children: [
          Visibility(
            child: Text(
              "Bu ürün ₺${datam.urunkargo!.toptanKargoUcretiAltLimit.toString()} altı ₺${datam.urunkargo!.toptanKargoUcretiFiyat} üzeri ücretsiz kargo olarak, ${datam.urunkargo!.toptan!.adi} kargoda.",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.red),
            ),
            visible:
                (datam.urunkargo!.toptan!.gonderim!.id == "3") ? true : false,
          ),
          Visibility(
            child: Text(
              "Bu ürün Ücretsiz Kargo olarak, ${datam.urunkargo!.toptan!.adi} kargoda.",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.red),
            ),
            visible:
                (datam.urunkargo!.toptan!.gonderim!.id == "1") ? true : false,
          ),
          Visibility(
            child: Text(
              "Bu ürün ₺${datam.urunkargo!.toptanKargoUcretiFiyat} ücretli kargo olarak, ${datam.urunkargo!.toptan!.adi} kargoda.",
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
                child: RichText(
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
                        text: ': ₺${datam.urunkargo!.toptanFiyat}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      TextSpan(
                        text:
                            ' / ${datam.urunkargo!.toptanAdet} ${datam.birimSembol}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 175,
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
                    "kargo": "Avantajlı Kargo",
                    "adet": adet,
                    "link": datam.urunLink,
                    "urunKodu": datam.urunKodu,
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
      visible: (datam.uruntezgah!.toptan == "1" &&
              datam.urunkargo!.toptanKargoUcretiFiyat != null)
          ? true
          : false,
    );
  }
}
