import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

late Stream<List<KepegawaianModel>> firestoreScanlogList;

List<KepegawaianModel> kepegawaianList = [];

class PresensiModel {
  String? pin;
  String? masuk;
  String? keluar;

  PresensiModel({
    this.pin,
    this.masuk,
    this.keluar,
  });

  factory PresensiModel.fromJson(Map<String, dynamic> json) {
    return (PresensiModel(
      pin: json['pin'],
      masuk: json['masuk'],
      keluar: json['keluar'],
    ));
  }

  Map<String, dynamic> toJson() {
    return {
      "pin": pin,
      "masuk": masuk,
      "keluar": keluar,
    };
  }
}

class KepegawaianModel {
  String? pin;
  String? nip;
  String? nama;
  String? jadker;
  String? email;
  String? bidang;
  List<PresensiModel>? presensi;

  KepegawaianModel(
      {this.pin,
      this.nip,
      this.nama,
      this.jadker,
      this.email,
      this.bidang,
      this.presensi});

  factory KepegawaianModel.fromSnapshot(DocumentSnapshot json) {
    final data = json.data() as Map<String, dynamic>;
    final presensi = (data['Presensi'] as List)
        .map((presence) => PresensiModel.fromJson(presence))
        .toList();
    return KepegawaianModel(
        pin: data['pin'],
        nip: data['nip'],
        nama: data['nama'],
        jadker: data['jadker'],
        email: data['email'],
        bidang: data['bidang'],
        presensi: presensi);
  }
}
