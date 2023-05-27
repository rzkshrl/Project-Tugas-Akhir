// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/data/models/firestorescanlogmodel.dart';
import 'package:project_tugas_akhir/app/theme/theme.dart';
import 'package:project_tugas_akhir/app/utils/dialogTextField.dart';
import 'package:project_tugas_akhir/app/utils/textfield.dart';
import 'package:sizer/sizer.dart';

import '../modules/data_pegawai/controllers/data_pegawai_controller.dart';
import '../theme/textstyle.dart';
import 'btnDefault.dart';
import 'dropdownTextField.dart';

class KepegawaianDTS extends DataTableSource {
  final List<KepegawaianModel> kepegawaianList;
  final c = Get.put(DataPegawaiController());

  KepegawaianDTS(this.kepegawaianList);

  @override
  DataRow getRow(int index) {
    KepegawaianModel data = kepegawaianList[index];
    return DataRow(
      cells: [
        DataCell(Text(
          "${data.pin}",
          style: getTextTableData(Get.context!),
        )),
        DataCell(Text(
          "${data.nip}",
          style: getTextTableData(Get.context!),
        )),
        DataCell(Text(
          "${data.nama}",
          style: getTextTableData(Get.context!),
        )),
        DataCell(Text(
          "${data.kepegawaian}",
          style: getTextTableData(Get.context!),
        )),
        DataCell(Text(
          "${data.bidang}",
          style: getTextTableData(Get.context!),
        )),
        DataCell(IconButton(
            onPressed: () {
              c.deleteDoc(data.pin!);
            },
            icon: Icon(
              IconlyLight.delete,
              color: Blue1,
            ))),
        DataCell(IconButton(
            onPressed: () {
              textC.namaTambahDataPegC.text = data.nama!;
              textC.pinTambahDataPegC.text = data.pin!;
              cDropdown.kepgTambahDataPegC.text = data.kepegawaian!;
              textC.nipTambahDataPegC.text = data.nip!;
              cDropdown.bidangTambahDataPegC.text = data.bidang!;
              Get.dialog(dialogTextFieldSevenField(
                  Get.context!,
                  btnDefaultIcon1(10.w, Blue4, IconlyLight.tick_square, Yellow1,
                      "Kirim", getTextBtnAction(Get.context!), () {
                    if (textC.namaTambahDataPegKey.value.currentState!
                            .validate() &&
                        cDropdown.kepgTambahDataPegKey.value.currentState!
                            .validate() &&
                        textC.nipTambahDataPegKey.value.currentState!
                            .validate() &&
                        cDropdown.bidangTambahDataPegKey.value.currentState!
                            .validate() &&
                        textC.emailTambahDataPegKey.value.currentState!
                            .validate()) {
                      c.editPegawai(
                        data.pin!,
                        Get.context!,
                        textC.namaTambahDataPegC.text,
                        cDropdown.kepgTambahDataPegC.text,
                        textC.nipTambahDataPegC.text,
                        cDropdown.bidangTambahDataPegC.text,
                      );
                    }
                  }),
                  true));
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
  int get rowCount => kepegawaianList.length;

  @override
  int get selectedRowCount => 0;
}
