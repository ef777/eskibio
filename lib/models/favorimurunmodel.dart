import 'dart:convert';

import 'package:biorganikpazar/config/config.dart';

class Favoriurunmodel {
  String? id;
  String? kanal;
  String? kullaniciId;
  String? urunId;
  String? urunKodu;
  String? tarih;
  String? urunAdi;
  String? urunLink;
  String? urunKisaAciklama;
  String? urunUzunAciklama;
  String? urunEtiketleri;
  String? tezgahId;
  String? tezgahKodu;
  String? kategoriId;
  String? kategoriKodu;
  String? statu;
  String? statuSertifika;
  String? kimden;
  String? uretim;
  String? uretimIl;
  String? birim;
  String? stokKontrol;
  String? stokKodu;
  String? stokAdeti;
  String? varyasyon;
  String? durum;
  String? yDurum;
  String? zaman;
  String? vitrinResim;
  String? gosterimPuan;
  String? icerik;
  String? tumkategori;
  List<Nitelikler>? nitelikler;

  Favoriurunmodel(
      {this.id,
      this.kanal,
      this.kullaniciId,
      this.urunId,
      this.urunKodu,
      this.tarih,
      this.urunAdi,
      this.urunLink,
      this.urunKisaAciklama,
      this.urunUzunAciklama,
      this.urunEtiketleri,
      this.tezgahId,
      this.tezgahKodu,
      this.kategoriId,
      this.kategoriKodu,
      this.statu,
      this.statuSertifika,
      this.kimden,
      this.uretim,
      this.uretimIl,
      this.birim,
      this.stokKontrol,
      this.stokKodu,
      this.stokAdeti,
      this.varyasyon,
      this.durum,
      this.yDurum,
      this.zaman,
      this.vitrinResim,
      this.gosterimPuan,
      this.icerik,
      this.tumkategori,
      this.nitelikler});

  Favoriurunmodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kanal = json['kanal'];
    kullaniciId = json['kullanici_id'];
    urunId = json['urun_id'];
    urunKodu = json['urun_kodu'];
    tarih = json['tarih'];
    urunAdi = json['urun_adi'];
    urunLink = json['urun_link'];
    urunKisaAciklama = json['urun_kisa_aciklama'];
    urunUzunAciklama = json['urun_uzun_aciklama'];
    urunEtiketleri = json['urun_etiketleri'];
    tezgahId = json['tezgah_id'];
    tezgahKodu = json['tezgah_kodu'];
    kategoriId = json['kategori_id'];
    kategoriKodu = json['kategori_kodu'];
    statu = json['statu'];
    statuSertifika = json['statu_sertifika'];
    kimden = json['kimden'];
    uretim = json['uretim'];
    uretimIl = json['uretim_il'];
    birim = json['birim'];
    stokKontrol = json['stok_kontrol'];
    stokKodu = json['stok_kodu'];
    stokAdeti = json['stok_adeti'];
    varyasyon = json['varyasyon'];
    durum = json['durum'];
    yDurum = json['y_durum'];
    zaman = json['zaman'];
    vitrinResim = json['vitrin_resim'];
    gosterimPuan = json['gosterim_puan'];
    icerik = json['icerik'];
    tumkategori = json['tumkategori'];
    if (json['nitelikler'] != null) {
      nitelikler = <Nitelikler>[];
      json['nitelikler'].forEach((v) {
        nitelikler!.add(new Nitelikler.fromJson(v));
      });
    }
  }
}

class Nitelikler {
  String? ad;
  String? icon;

  Nitelikler({this.ad, this.icon});

  Nitelikler.fromJson(Map<String, dynamic> json) {
    ad = json['ad'];
    icon = json['icon'];
  }
}

Future<List<Favoriurunmodel>> getfavoriurunler() async {
  var data = {"kullaniciId": Config.kullaniciid};
  var sonuc = await Config().postMethod("kullanici/favoriurunler", data);
  var body = jsonDecode(sonuc) as List;
  return body.map((e) => Favoriurunmodel.fromJson(e)).toList();
}
