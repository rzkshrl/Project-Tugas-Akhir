import 'package:cloud_firestore/cloud_firestore.dart';

List<PengecualianModel> holidayList = [];

class PengecualianModel {
  String? nama;
  String? statusPengecualian;
  DateTime? dateStart;
  DateTime? dateEnd;
  String? id;

  PengecualianModel(
      {this.nama,
      this.statusPengecualian,
      this.dateStart,
      this.dateEnd,
      this.id});

  factory PengecualianModel.fromJson(DocumentSnapshot json) {
    final data = json.data() as Map<String, dynamic>;
    return (PengecualianModel(
        nama: data['nama'],
        statusPengecualian: data['statusPengecualian'],
        dateStart: DateTime.parse(data['dateStart']),
        dateEnd: DateTime.parse(data['dateEnd']),
        id: data['id']));
  }

  Map<String, dynamic> toJson() {
    return {
      "nama": nama,
      "statusPengecualian": statusPengecualian,
      "dateStart": dateStart,
      "dateEnd": dateEnd,
    };
  }
}
