import 'package:flutter/material.dart';
import 'package:project_tugas_akhir/app/utils/btnDefault.dart';
import 'package:project_tugas_akhir/app/utils/textfield.dart';
import 'package:sizer/sizer.dart';
import '../modules/jam_kerja/controllers/jam_kerja_controller.dart';
import '../theme/textstyle.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../theme/theme.dart';
import 'package:intl/intl.dart';
import 'package:project_tugas_akhir/app/data/models/firestorejamkerjamodel.dart';

import 'dialogTextField.dart';

class JamKerjaDTS extends DataTableSource {
  final List<JamKerjaModel> jamKerjaList;
  final c = Get.put(JamKerjaController());

  JamKerjaDTS(this.jamKerjaList);

  @override
  DataRow getRow(int index) {
    JamKerjaModel data = jamKerjaList[index];
    return DataRow(
      cells: [
        DataCell(Text(
          data != null ? "${data.nama}" : "-",
          style: getTextTable(Get.context!),
        )),
        DataCell(Text(
          data != null ? "${data.kode}" : "-",
          style: getTextTable(Get.context!),
        )),
        DataCell(Text(
          data != null ? "${data.jadwalMasuk}" : "-",
          style: getTextTable(Get.context!),
        )),
        DataCell(Text(
          data != null ? "${data.jadwalKeluar}" : "-",
          style: getTextTable(Get.context!),
        )),
        DataCell(Text(
          data != null ? "${data.terlambat}" : "-",
          style: getTextTable(Get.context!),
        )),
        DataCell(Text(
          data != null ? "${data.pulangLebihAwal}" : "-",
          style: getTextTable(Get.context!),
        )),
        DataCell(IconButton(
            onPressed: () {
              c.deleteJamKerja(data.kode!);
            },
            icon: Icon(
              IconlyLight.delete,
              color: Blue1,
            ))),
        DataCell(IconButton(
            onPressed: () {
              textC.namaJamKerjaC.text = data.nama!;
              textC.kodeJamKerjaC.text = data.kode!;
              textC.ketJamKerjaC.text = data.ket!;
              textC.masukJamKerjaC.text = data.jadwalMasuk!;
              textC.keluarJamKerjaC.text = data.jadwalKeluar!;
              textC.batasAwalmasukJamKerjaC.text = data.batasAwalMasuk!;
              textC.batasAkhirmasukJamKerjaC.text = data.batasAwalKeluar!;
              textC.batasAwalkeluarJamKerjaC.text = data.batasAkhirMasuk!;
              textC.batasAkhirkeluarJamKerjaC.text = data.batasAkhirKeluar!;
              textC.terlambatJamKerjaC.text = data.terlambat!;
              textC.pulLebihAwalJamKerjaC.text = data.pulangLebihAwal!;
              Get.dialog(dialogTextJamKerja(
                  Get.context!,
                  btnDefaultIcon1(10.w, Blue4, IconlyLight.tick_square, Yellow1,
                      "Kirim", getTextBtnAction(Get.context!), () {
                    if (textC.namaJamKerjaKey.value.currentState!.validate() &&
                        textC.kodeJamKerjaKey.value.currentState!.validate() &&
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
                            .validate() &&
                        c.isAtLeastOneDaySelected()) {
                      c.editJamKerja(
                          data.kode!,
                          textC.namaJamKerjaC.text,
                          textC.kodeJamKerjaC.text,
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
