// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:monitorpresensi/app/utils/btnDefault.dart';
import 'package:monitorpresensi/app/utils/textfield.dart';
import 'package:sizer/sizer.dart';
import '../web/jam_kerja/controllers/jam_kerja_controller.dart';
import '../theme/textstyle.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../theme/theme.dart';
import 'package:monitorpresensi/app/data/models/firestorejamkerjamodel.dart';

import 'dialogTextField.dart';
import 'dropdownTextField.dart';

class JamKerjaDTS extends DataTableSource {
  final List<JamKerjaModel> jamKerjaList;
  final c = Get.put(JamKerjaController());

  JamKerjaDTS(this.jamKerjaList);

  int sortColumnIndex = 0;
  bool sortAscending = true;

  void sortData() {
    jamKerjaList.sort((a, b) {
      int result = 0;
      switch (c.sortColumnIndex.value) {
        case 0:
          result = a.nama!.compareTo(b.nama!);
          break;
        case 1:
          result = a.hariKerja!.compareTo(b.hariKerja!);
          break;
        case 2:
          result = a.jadwalMasuk!.compareTo(b.jadwalMasuk!);
          break;
        case 3:
          result = a.jadwalKeluar!.compareTo(b.jadwalKeluar!);
          break;
        case 4:
          result = a.terlambat!.compareTo(b.terlambat!);
          break;
        case 5:
          result = a.pulangLebihAwal!.compareTo(b.pulangLebihAwal!);
          break;
      }
      return c.sortAscending.value ? result : -result;
    });
  }

  @override
  DataRow getRow(int index) {
    sortData();
    JamKerjaModel data = jamKerjaList[index];
    return DataRow(
      cells: [
        DataCell(Text(
          "${data.nama}",
          style: getTextTableData(Get.context!),
        )),
        DataCell(Text(
          "${data.hariKerja}",
          style: getTextTableData(Get.context!),
        )),
        DataCell(Text(
          "${data.jadwalMasuk}",
          style: getTextTableData(Get.context!),
        )),
        DataCell(Text(
          "${data.jadwalKeluar}",
          style: getTextTableData(Get.context!),
        )),
        DataCell(Text(
          "${data.terlambat}",
          style: getTextTableData(Get.context!),
        )),
        DataCell(Text(
          "${data.pulangLebihAwal}",
          style: getTextTableData(Get.context!),
        )),
        DataCell(IconButton(
            onPressed: () {
              c.deleteJamKerja(data.id!);
            },
            icon: Icon(
              IconlyLight.delete,
              color: Blue1,
            ))),
        DataCell(IconButton(
            onPressed: () {
              textC.namaJamKerjaC.text = data.nama!;
              cDropdown.kepgTambahDataPegC.text = data.kepg!;
              textC.ketJamKerjaC.text = data.ket!;
              textC.masukJamKerjaC.text = data.jadwalMasuk!;
              textC.keluarJamKerjaC.text = data.jadwalKeluar!;
              textC.batasAwalmasukJamKerjaC.text = data.batasAwalMasuk!;
              textC.batasAkhirmasukJamKerjaC.text = data.batasAkhirMasuk!;
              textC.batasAwalkeluarJamKerjaC.text = data.batasAwalKeluar!;
              textC.batasAkhirkeluarJamKerjaC.text = data.batasAkhirKeluar!;
              textC.terlambatJamKerjaC.text = data.terlambat!;
              textC.pulLebihAwalJamKerjaC.text = data.pulangLebihAwal!;
              c.getJamKerja(data.id!);
              Get.dialog(dialogTextJamKerja(
                  true,
                  Get.context!,
                  btnDefaultIcon1(10.w, Blue4, IconlyLight.tick_square, Yellow1,
                      "Kirim", getTextBtnAction(Get.context!), () {
                    if (textC.namaJamKerjaKey.value.currentState!.validate() &&
                        cDropdown.kepgTambahDataPegKey.value.currentState!
                            .validate() &&
                        textC.ketJamKerjaKey.value.currentState!.validate() &&
                        textC.masukJamKerjaKey.value.currentState!.validate() &&
                        textC.keluarJamKerjaKey.value.currentState!
                            .validate() &&
                        textC.batasAwalmasukJamKerjaKey.value.currentState!
                            .validate() &&
                        textC.batasAkhirmasukJamKerjaKey.value.currentState!
                            .validate() &&
                        textC.batasAwalkeluarJamKerjaKey.value.currentState!
                            .validate() &&
                        textC.batasAkhirkeluarJamKerjaKey.value.currentState!
                            .validate() &&
                        textC.terlambatJamKerjaKey.value.currentState!
                            .validate() &&
                        textC.pulLebihAwalJamKerjaKey.value.currentState!
                            .validate()) {
                      c.editJamKerja(
                          data.id!,
                          textC.namaJamKerjaC.text,
                          cDropdown.kepgTambahDataPegC.text,
                          textC.ketJamKerjaC.text,
                          textC.masukJamKerjaC.text,
                          textC.keluarJamKerjaC.text,
                          textC.batasAwalmasukJamKerjaC.text,
                          textC.batasAwalkeluarJamKerjaC.text,
                          textC.batasAkhirmasukJamKerjaC.text,
                          textC.batasAkhirkeluarJamKerjaC.text,
                          textC.terlambatJamKerjaC.text,
                          textC.pulLebihAwalJamKerjaC.text);
                    }
                  })));
            },
            icon: Icon(
              IconlyLight.edit,
              color: Blue1,
            ))),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => jamKerjaList.length;

  @override
  int get selectedRowCount => 0;
}
