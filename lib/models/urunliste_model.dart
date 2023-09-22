import 'dart:convert';
import '../config/config.dart';

// ignore: camel_case_types
class Urunliste_model {
  String? id;
  String? urunKodu;
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
  String? indirim;
  String? perakende;
  String? toptan;
  String? express;
  String? indirimTarihKontrol;
  String? indirimBaslamaTarihi;
  String? indirimBitisTarihi;
  String? reklammi;
  String? ureticiAdi;
  String? ureticiIcon;
  String? statuAdi;
  String? statuRenk;
  String? statuIcon;
  String? uretimAdi;
  String? uretimIcon;
  String? birimAdi;
  String? birimSembol;
  String? urunFiyat;
  int? urunAdet;
  String? kargoUcreti;
  String? kargoSuresi;
  String? kargoDurum;
  String? kargoTitle;
  String? kargoRenk;
  int? yorumadet;
  int? puanlama;
  String? reklamdurummu;

  Urunliste_model(
      {id,
      urunKodu,
      urunAdi,
      urunLink,
      urunKisaAciklama,
      urunUzunAciklama,
      urunEtiketleri,
      tezgahId,
      tezgahKodu,
      kategoriId,
      kategoriKodu,
      statu,
      statuSertifika,
      kimden,
      uretim,
      uretimIl,
      birim,
      stokKontrol,
      stokKodu,
      stokAdeti,
      varyasyon,
      durum,
      yDurum,
      zaman,
      vitrinResim,
      gosterimPuan,
      icerik,
      tumkategori,
      indirim,
      perakende,
      toptan,
      express,
      indirimTarihKontrol,
      indirimBaslamaTarihi,
      indirimBitisTarihi,
      reklammi,
      ureticiAdi,
      ureticiIcon,
      statuAdi,
      statuRenk,
      statuIcon,
      uretimAdi,
      uretimIcon,
      birimAdi,
      birimSembol,
      urunFiyat,
      urunAdet,
      kargoUcreti,
      kargoSuresi,
      kargoDurum,
      kargoTitle,
      kargoRenk,
      yorumadet,
      puanlama,
      reklamdurummu});

  Urunliste_model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    urunKodu = json['urun_kodu'];
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
    indirim = json['indirim'];
    perakende = json['perakende'];
    toptan = json['toptan'];
    express = json['express'];
    indirimTarihKontrol = json['indirim_tarih_kontrol'];
    indirimBaslamaTarihi = json['indirim_baslama_tarihi'];
    indirimBitisTarihi = json['indirim_bitis_tarihi'];
    reklammi = json['reklammi'];
    ureticiAdi = json['ureticiAdi'];
    ureticiIcon = json['ureticiIcon'];
    statuAdi = json['statuAdi'];
    statuRenk = json['statuRenk'];
    statuIcon = json['statuIcon'];
    uretimAdi = json['uretimAdi'];
    uretimIcon = json['uretimIcon'];
    birimAdi = json['birimAdi'];
    birimSembol = json['birimSembol'];
    urunFiyat = json['urunFiyat'];
    urunAdet = json['urunAdet'];
    kargoUcreti = json['kargoUcreti'];
    kargoSuresi = json['kargoSuresi'];
    kargoDurum = json['kargoDurum'];
    kargoTitle = json['kargoTitle'];
    kargoRenk = json['kargoRenk'];
    yorumadet = json['yorumadet'];
    puanlama = json['puanlama'];
    reklamdurummu = json['reklamdurummu'];
  }
}

Future<List<Urunliste_model>> getUrungruplari(String tip) async {
  var data = {};
  var dersler = await Config()
      .getMethod("urunler/urungruplari/" + tip + "?basla=0&bitis=10", data);
  var body = json.decode(dersler) as List;
  return body.map((e) => Urunliste_model.fromJson(e)).toList();
}
