import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../data/models/allscanlogmodel.dart';
import '../data/models/firestorescanlogmodel.dart';

class ScanlogDTS extends DataTableSource {
  final List<KepegawaianModel> _kepg;

  ScanlogDTS(this._kepg);

  @override
  DataRow2 getRow(int index) {
    final data = _kepg[index];
    return DataRow2.byIndex(index: index, cells: [
      DataCell(Text(data != null ? "${data.nama}" : "Tidak ada data")),
      DataCell(Text(data != null ? "${data.nip}" : "Tidak ada data")),
      DataCell(Text(data != null ? "${data.pin}" : "Tidak ada data")),
      DataCell(Text(data != null ? "${data.pin}" : "Tidak ada data")),
      DataCell(Text(data != null ? "${data.nip}" : "Tidak ada data")),
      DataCell(
          Text(data != null ? "scanDate : ${data.nip}" : "Tidak ada data")),
      DataCell(
          Text(data != null ? "scanDate : ${data.nip}" : "Tidak ada data")),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _kepg.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
