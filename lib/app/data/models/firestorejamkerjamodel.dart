import 'package:cloud_firestore/cloud_firestore.dart';

class JamKerjaModel {
  String? nama;
  String? kode;
  String? ket;
  String? jadwalMasuk;
  String? jadwalKeluar;
  String? batasAwalMasuk;
  String? batasAwalKeluar;
  String? batasAkhirMasuk;
  String? batasAkhirKeluar;
  String? terlambat;
  String? pulangLebihAwal;

  JamKerjaModel(
      {this.nama,
      this.kode,
      this.ket,
      this.jadwalMasuk,
      this.jadwalKeluar,
      this.batasAwalMasuk,
      this.batasAwalKeluar,
      this.batasAkhirMasuk,
      this.batasAkhirKeluar,
      this.terlambat,
      this.pulangLebihAwal});

  factory JamKerjaModel.fromJson(DocumentSnapshot json) {
    final data = json.data() as Map<String, dynamic>;
    return (JamKerjaModel(
      nama: data['nama'],
      kode: data['kode'],
      ket: data['ket'],
      jadwalMasuk: data['jadwal_masuk'],
      jadwalKeluar: data['jadwal_keluar'],
      batasAwalMasuk: data['batasAwal_masuk'],
      batasAwalKeluar: data['batasAwal_keluar'],
      batasAkhirMasuk: data['batasAkhir_masuk'],
      batasAkhirKeluar: data['batasAkhir_keluar'],
      terlambat: data['keterlambatan'],
      pulangLebihAwal: data['pulang_awal'],
    ));
  }

  Map<String, dynamic> toJson() {
    return {
      "nama": nama,
      "kode": kode,
      "ket": ket,
      "jadwal_masuk": jadwalMasuk,
      "jadwal_keluar": jadwalKeluar,
      "batasAwal_masuk": batasAwalMasuk,
      "batasAwal_keluar": batasAwalKeluar,
      "batasAkhir_masuk": batasAkhirMasuk,
      "batasAkhir_keluar": batasAkhirKeluar,
      "keterlambatan": terlambat,
      "pulang_awal": pulangLebihAwal,
    };
  }
}
