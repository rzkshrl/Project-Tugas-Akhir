import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../data/models/allscanlogmodel.dart';

class ScanlogDTS extends DataTableSource {
  @override
  DataRow2 getRow(int index) {
    return DataRow2.byIndex(index: index, cells: [
      DataCell(Text(allScanlogList != null
          ? "PIN : ${allScanlogList[index].pin}"
          : "Tidak ada data")),
      DataCell(Text(allScanlogList != null
          ? "scanDate : ${allScanlogList[index].scanDate}"
          : "Tidak ada data"))
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => allScanlogList.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
