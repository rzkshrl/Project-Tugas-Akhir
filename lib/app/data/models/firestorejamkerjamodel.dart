import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JamKerjaModel {
  String? nama;
  String? kepg;
  String? ket;
  String? jadwalMasuk;
  String? jadwalKeluar;
  String? batasAwalMasuk;
  String? batasAwalKeluar;
  String? batasAkhirMasuk;
  String? batasAkhirKeluar;
  String? terlambat;
  String? pulangLebihAwal;
  String? hariKerja;
  String? id;

  JamKerjaModel(
      {this.nama,
      this.kepg,
      this.ket,
      this.jadwalMasuk,
      this.jadwalKeluar,
      this.batasAwalMasuk,
      this.batasAwalKeluar,
      this.batasAkhirMasuk,
      this.batasAkhirKeluar,
      this.terlambat,
      this.pulangLebihAwal,
      this.hariKerja,
      this.id});

  factory JamKerjaModel.fromJson(DocumentSnapshot json) {
    final data = json.data() as Map<String, dynamic>;
    return (JamKerjaModel(
        nama: data['nama'],
        kepg: data['kepegawaian'],
        ket: data['ket'],
        jadwalMasuk: data['jadwal_masuk'],
        jadwalKeluar: data['jadwal_keluar'],
        batasAwalMasuk: data['batasAwal_masuk'],
        batasAwalKeluar: data['batasAwal_keluar'],
        batasAkhirMasuk: data['batasAkhir_masuk'],
        batasAkhirKeluar: data['batasAkhir_keluar'],
        terlambat: data['keterlambatan'],
        pulangLebihAwal: data['pulang_awal'],
        hariKerja: data['hariKerja'],
        id: data['id']));
  }

  Map<String, dynamic> toJson() {
    return {
      "nama": nama,
      "kepg": kepg,
      "ket": ket,
      "jadwal_masuk": jadwalMasuk,
      "jadwal_keluar": jadwalKeluar,
      "batasAwal_masuk": batasAwalMasuk,
      "batasAwal_keluar": batasAwalKeluar,
      "batasAkhir_masuk": batasAkhirMasuk,
      "batasAkhir_keluar": batasAkhirKeluar,
      "keterlambatan": terlambat,
      "pulang_awal": pulangLebihAwal,
      "hariKerja": hariKerja
    };
  }
}

class JamKerjaModel2 {
  String? nama;
  String? kepg;
  String? ket;
  TimeOfDay? jadwalMasuk;
  TimeOfDay? jadwalKeluar;
  TimeOfDay? batasAwalMasuk;
  TimeOfDay? batasAwalKeluar;
  TimeOfDay? batasAkhirMasuk;
  TimeOfDay? batasAkhirKeluar;
  TimeOfDay? terlambat;
  TimeOfDay? pulangLebihAwal;
  String? hariKerja;
  String? id;

  JamKerjaModel2(
      {this.nama,
      this.kepg,
      this.ket,
      this.jadwalMasuk,
      this.jadwalKeluar,
      this.batasAwalMasuk,
      this.batasAwalKeluar,
      this.batasAkhirMasuk,
      this.batasAkhirKeluar,
      this.terlambat,
      this.pulangLebihAwal,
      this.hariKerja,
      this.id});

  factory JamKerjaModel2.fromJson(DocumentSnapshot json) {
    final data = json.data() as Map<String, dynamic>;
    return (JamKerjaModel2(
        nama: data['nama'],
        kepg: data['kepegawaian'],
        ket: data['ket'],
        jadwalMasuk: _parseTime(data['jadwal_masuk']),
        jadwalKeluar: _parseTime(data['jadwal_keluar']),
        batasAwalMasuk: _parseTime(data['batasAwal_masuk']),
        batasAwalKeluar: _parseTime(data['batasAwal_keluar']),
        batasAkhirMasuk: _parseTime(data['batasAkhir_masuk']),
        batasAkhirKeluar: _parseTime(data['batasAkhir_keluar']),
        terlambat: _parseTime(data['keterlambatan']),
        pulangLebihAwal: _parseTime(data['pulang_awal']),
        hariKerja: data['hariKerja'],
        id: data['id']));
  }

  // static DateTime _parseTime(String timeString) {
  //   final parts = timeString.split(':');
  //   final hours = int.parse(parts[0]);
  //   final minutes = int.parse(parts[1]);
  //   return DateTime(0, 1, 1, hours, minutes);
  // }

  static TimeOfDay _parseTime(String timeString) {
    final parts = timeString.split(':');
    final hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);
    return TimeOfDay(hour: hours, minute: minutes);
  }
}
