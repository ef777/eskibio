import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:biorganikpazar/components/il_ilce_mahalle.dart';
import 'package:biorganikpazar/config/config.dart';
import 'package:biorganikpazar/models/adreslistemodel.dart';
import 'package:flutter/material.dart';

import '../../components/Input.dart';

class Adresislem extends StatefulWidget {
  final String adresId;
  final Adreslistemode? adresdata;
  const Adresislem({Key? key, this.adresId = "", this.adresdata})
      : super(key: key);

  @override
  State<Adresislem> createState() => _AdresislemState();
}

class _AdresislemState extends State<Adresislem> {
  late String baslik,
      ad,
      soyad,
      ilid,
      ilceid,
      mahalleid,
      postakodu,
      tc,
      iladi,
      ilceadi,
      adres,
      adresId,
      mahalleadi;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    adresId = widget.adresId;
    baslik = widget.adresdata?.adi ?? "";
    ad = widget.adresdata?.aliciAdi ?? "";
    soyad = widget.adresdata?.aliciSoyadi ?? "";
    ilid = widget.adresdata?.il ?? "";
    mahalleid = widget.adresdata?.mahalle ?? "";
    postakodu = widget.adresdata?.postakodu ?? "";
    ilceid = widget.adresdata?.ilce ?? "";
    tc = widget.adresdata?.aliciTc ?? "";
    iladi = widget.adresdata?.ilAdi ?? "İl Seçin";
    ilceadi = widget.adresdata?.ilceAdi ?? "İlçe Seçin";
    adres = widget.adresdata?.adres ?? "";
    mahalleadi = widget.adresdata?.mahalleAdi ?? "Mahalle Seçin";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Adres İşlem")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Input(
                label: "Adres başlık",
                inputype: TextInputType.text,
                borderColors: Colors.grey,
                inputValue: baslik,
                textval: (text) => {baslik = text},
                errorText: "Adres başlık boş olamaz",
              ),
              Input(
                label: "Alıcı Adı",
                inputype: TextInputType.text,
                borderColors: Colors.grey,
                inputValue: ad,
                textval: (text) => {ad = text},
                errorText: "Alıcı Adı Boş olamaz",
              ),
              Input(
                label: "Alıcı Soyadı",
                inputype: TextInputType.text,
                borderColors: Colors.grey,
                inputValue: soyad,
                textval: (text) => {soyad = text},
                errorText: "Alıcı Soyadı Boş Olamaz",
              ),
              Input(
                label: "Alıcı TC No",
                inputype: TextInputType.phone,
                borderColors: Colors.grey,
                inputValue: tc,
                textval: (text) => {tc = text},
                errorText: "Tc Alanı Boş Olamaz",
              ),
              Input(
                label: "Adres",
                inputype: TextInputType.text,
                borderColors: Colors.grey,
                inputValue: adres,
                textval: (text) => {adres = text},
                errorText: "Adres Alanı Boş Olamaz",
              ),
              Input(
                label: "Posta Kodu",
                inputype: TextInputType.text,
                borderColors: Colors.grey,
                inputValue: postakodu,
                textval: (text) => {postakodu = text},
                errorText: "Posta Alanı Boş Olamaz",
              ),
              Container(
                  width: MediaQuery.of(context).size.width - 30,
                  height: 42,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: Colors.grey),
                    color: Colors.white,
                  ),
                  child: InkWell(
                    onTap: () async {
                      var sonuc = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Ilgetir(),
                        ),
                      );
                      if (sonuc != null) {
                        setState(() {
                          iladi = sonuc["title"] ?? "İl Seçin";
                          ilid = sonuc["plaka"] ?? "";
                          ilceadi = "İlçe Seçin";
                          ilceid = "";
                          mahalleadi = "Mahalle Seçin";
                          mahalleid = "";
                        });
                      }
                    },
                    child: Text(iladi),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 30,
                height: 42,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.grey),
                  color: Colors.white,
                ),
                child: InkWell(
                  onTap: () async {
                    var sonuc = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Ilcegetir(
                          plaka: ilid,
                        ),
                      ),
                    );
                    if (sonuc != null) {
                      setState(() {
                        ilceadi = sonuc["title"] ?? "İl Seçin";
                        ilceid = sonuc["plaka"] ?? "";
                        mahalleadi = "Mahalle Seçin";
                        mahalleid = "";
                      });
                    }
                  },
                  child: Text(ilceadi),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 30,
                height: 42,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.grey),
                  color: Colors.white,
                ),
                child: InkWell(
                  onTap: () async {
                    var sonuc = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Mahallegetir(
                          ilcekey: ilceid,
                        ),
                      ),
                    );
                    if (sonuc != null) {
                      setState(() {
                        mahalleadi = sonuc["title"] ?? "İl Seçin";
                        mahalleid = sonuc["plaka"] ?? "";
                      });
                    }
                  },
                  child: Text(mahalleadi),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.green,
                width: MediaQuery.of(context).size.width - 30,
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _adreskayit();
                    }
                  },
                  child: const Text("Güncelle & Kaydet",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _adreskayit() async {
    var data = {
      "adi": baslik,
      "adres": adres,
      "il": ilid,
      "ilce": ilceid,
      "mahalle": mahalleid,
      "postakodu": postakodu,
      "adiniz": ad,
      "soyad": soyad,
      "kullaniciId": Config.kullaniciid,
      "tc": tc
    };
    var sonuc =
        await Config().postMethod("kullanici/adreskayit/$adresId", data);
    if (sonuc == false) {
    } else {
      ArtDialogResponse response = await ArtSweetAlert.show(
        context: context,
        artDialogArgs: ArtDialogArgs(
          confirmButtonText: "Tamam",
          type: ArtSweetAlertType.success,
          title: "Başarılı",
          text: "Başarıyla İşleminiz Yapıldı",
        ),
      );
      if (response == null) {
        return;
      }

      if (response.isTapConfirmButton) {
        Navigator.pop(context);
        return;
      }
    }
  }
}
