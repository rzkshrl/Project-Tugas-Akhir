import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_tugas_akhir/app/data/models/allscanlogmodel.dart';

class RiwayatPresensiController extends GetxController {
  //TODO: Implement RiwayatPresensiController

  var rowPerPage = PaginatedDataTable.defaultRowsPerPage.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class DataScanlog extends DataTableSource {
  late List<AllScanlogModel> allScanlogModel;
  var allScanlog = AllScanlogModel().obs;

  DataRow getRow(int index) {
    final data = allScanlogModel[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(Text('${allScanlog.value.pin}')),
      DataCell(Text('${allScanlog.value.scanDate}'))
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => true;

  @override
  // TODO: implement rowCount
  int get rowCount => 100;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
