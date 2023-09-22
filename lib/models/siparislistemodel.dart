class Siparislistemodel {
  String? id;
  String? anaSiparisKodu;
  String? siparisKodu;
  String? tezgahKodu;
  String? kanal;
  String? kullaniciKimlik;
  String? tutar;
  String? odemeYontemi;
  String? odemeOnayi;
  String? teslimatAdresi;
  String? faturaAdresi;
  String? tarih;
  String? ip;
  String? kargoFirmasi;
  String? kargoTakipKodu;
  String? durum;
  String? tezgahBildirimler;
  String? stokKontrolu;
  String? odemeIadesiYapildi;
  String? tezgahOdemeTalebi;
  String? iadeKargoFirmasi;
  String? iadeKargoKodu;
  String? iadeKargoZaman;
  String? kuryeNo;
  String? kuryeTel;
  List<Urunler>? urunler;

  Siparislistemodel(
      {this.id,
      this.anaSiparisKodu,
      this.siparisKodu,
      this.tezgahKodu,
      this.kanal,
      this.kullaniciKimlik,
      this.tutar,
      this.odemeYontemi,
      this.odemeOnayi,
      this.teslimatAdresi,
      this.faturaAdresi,
      this.tarih,
      this.ip,
      this.kargoFirmasi,
      this.kargoTakipKodu,
      this.durum,
      this.tezgahBildirimler,
      this.stokKontrolu,
      this.odemeIadesiYapildi,
      this.tezgahOdemeTalebi,
      this.iadeKargoFirmasi,
      this.iadeKargoKodu,
      this.iadeKargoZaman,
      this.kuryeNo,
      this.kuryeTel,
      this.urunler});

  Siparislistemodel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    anaSiparisKodu = json['ana_siparis_kodu'];
    siparisKodu = json['siparis_kodu'];
    tezgahKodu = json['tezgah_kodu'];
    kanal = json['kanal'];
    kullaniciKimlik = json['kullanici_kimlik'];
    tutar = json['tutar'];
    odemeYontemi = json['odeme_yontemi'];
    odemeOnayi = json['odeme_onayi'];
    teslimatAdresi = json['teslimat_adresi'];
    faturaAdresi = json['fatura_adresi'];
    tarih = json['tarih'];
    ip = json['ip'];
    kargoFirmasi = json['kargo_firmasi'];
    kargoTakipKodu = json['kargo_takip_kodu'];
    durum = json['durum'];
    tezgahBildirimler = json['tezgah_bildirimler'];
    stokKontrolu = json['stok_kontrolu'];
    odemeIadesiYapildi = json['odeme_iadesi_yapildi'];
    tezgahOdemeTalebi = json['tezgah_odeme_talebi'];
    iadeKargoFirmasi = json['iade_kargo_firmasi'];
    iadeKargoKodu = json['iade_kargo_kodu'];
    iadeKargoZaman = json['iade_kargo_zaman'];
    kuryeNo = json['kurye_no'];
    kuryeTel = json['kurye_tel'];
    if (json['urunler'] != null) {
      urunler = <Urunler>[];
      json['urunler'].forEach((v) {
        urunler!.add(Urunler.fromJson(v));
      });
    }
  }
}

class Urunler {
  String? id;
  String? anaSiparisKodu;
  String? siparisKodu;
  String? tezgahKodu;
  String? urunKodu;
  String? kategoriKodu;
  String? siparisKanali;
  String? birim;
  String? birimMiktar;
  String? adet;
  String? fiyat;
  String? total;
  String? durum;
  String? tarih;
  String? teslimatSuresi;
  String? kargoUcreti;
  String? kargoDurum;
  String? stokKontrolu;
  String? urunAdi;
  String? vitrinResim;

  Urunler(
      {this.id,
      this.anaSiparisKodu,
      this.siparisKodu,
      this.tezgahKodu,
      this.urunKodu,
      this.kategoriKodu,
      this.siparisKanali,
      this.birim,
      this.birimMiktar,
      this.adet,
      this.fiyat,
      this.total,
      this.durum,
      this.tarih,
      this.teslimatSuresi,
      this.kargoUcreti,
      this.kargoDurum,
      this.stokKontrolu,
      this.urunAdi,
      this.vitrinResim});

  Urunler.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    anaSiparisKodu = json['ana_siparis_kodu'];
    siparisKodu = json['siparis_kodu'];
    tezgahKodu = json['tezgah_kodu'];
    urunKodu = json['urun_kodu'];
    kategoriKodu = json['kategori_kodu'];
    siparisKanali = json['siparis_kanali'];
    birim = json['birim'];
    birimMiktar = json['birim_miktar'];
    adet = json['adet'];
    fiyat = json['fiyat'];
    total = json['total'];
    durum = json['durum'];
    tarih = json['tarih'];
    teslimatSuresi = json['teslimat_suresi'];
    kargoUcreti = json['kargo_ucreti'];
    kargoDurum = json['kargo_durum'];
    stokKontrolu = json['stok_kontrolu'];
    urunAdi = json['urun_adi'];
    vitrinResim = json['vitrin_resim'];
  }
}
