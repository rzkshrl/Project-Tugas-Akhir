import 'package:data_table_2/data_table_2.dart';
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
          data != null ? "${data.pin}" : "-",
          style: getTextTable(Get.context!),
        )),
        DataCell(Text(
          data != null ? "${data.nip}" : "-",
          style: getTextTable(Get.context!),
        )),
        DataCell(Text(
          data != null ? "${data.nama}" : "-",
          style: getTextTable(Get.context!),
        )),
        DataCell(Text(
          data != null ? "${data.jadker}" : "-",
          style: getTextTable(Get.context!),
        )),
        DataCell(Text(
          data != null ? "${data.email}" : "-",
          style: getTextTable(Get.context!),
        )),
        DataCell(Text(
          data != null ? "${data.bidang}" : "-",
          style: getTextTable(Get.context!),
        )),
        DataCell(IconButton(
            onPressed: () {},
            icon: Icon(
              IconlyLight.delete,
              color: Blue1,
            ))),
        DataCell(IconButton(
            onPressed: () {
              textC.namaTambahDataPegC.text = data.nama!;
              textC.pinTambahDataPegC.text = data.pin!;
              cDropdown.jadkerTambahDataPegC.text = data.jadker!;
              textC.nipTambahDataPegC.text = data.nip!;
              cDropdown.bidangTambahDataPegC.text = data.bidang!;
              textC.emailTambahDataPegC.text = data.email!;
              Get.dialog(dialogTextFieldSevenField(
                  Get.context!,
                  btnDefaultIcon1(10.w, Blue4, IconlyLight.tick_square, Yellow1,
                      "Kirim", getTextBtnAction(Get.context!), () {
                    if (textC.namaTambahDataPegKey.value.currentState!
                            .validate() &&
                        cDropdown.jadkerTambahDataPegKey.value.currentState!
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
                          cDropdown.jadkerTambahDataPegC.text,
                          textC.nipTambahDataPegC.text,
                          cDropdown.bidangTambahDataPegC.text,
                          textC.emailTambahDataPegC.text);
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
  int get rowCount => kepegawaianList.length;

  @override
  int get selectedRowCount => 0;
}
