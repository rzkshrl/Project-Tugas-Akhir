import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../data/models/allscanlogmodel.dart';
import '../data/models/firestorescanlogmodel.dart';

class ScanlogDTS extends DataTableSource {
  final List<KepegawaianModel> kepegawaianList;

  ScanlogDTS(this.kepegawaianList);

  @override
  DataRow2 getRow(int index) {
    final data = kepegawaianList[index];

    return DataRow2.byIndex(index: index, cells: [
      DataCell(Text(data != null ? "${data.nama}" : "-")),
      DataCell(Text(data != null ? "${data.nip}" : "-")),
      DataCell(Text(data != null ? "${data.pin}" : "-")),
      // DataCell(Column(
      //     children: presensiList.map((presensi) {
      //   return Text(presensi != null ? "${presensi.masuk}" : "-");
      // }).toList())),
      // DataCell(Column(
      //     children: presensiList.map((presensi) {
      //   return Text(presensi != null ? "${presensi.keluar}" : "-");
      // }).toList())),
      // DataCell(Column(
      //     children: presensiList.map((presensi) {
      //   return Text(presensi != null ? "${presensi.date}" : "-");
      // }).toList())),
      // DataCell(Column(
      //     children: presensiList.map((presensi) {
      //   return Text(presensi != null ? "${presensi.keterangan}" : "-");
      // }).toList())),
      DataCell(IconButton(onPressed: () {}, icon: Icon(IconlyLight.edit))),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => kepegawaianList.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
