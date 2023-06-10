// ignore_for_file: file_names, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/utils/dialogTextField.dart';
import 'package:project_tugas_akhir/app/utils/dropdownTextField.dart';
import 'package:project_tugas_akhir/app/utils/textfield.dart';
import 'package:sizer/sizer.dart';

import '../data/models/firestorepengecualianmodel.dart';
import '../theme/textstyle.dart';
import '../theme/theme.dart';
import 'package:intl/intl.dart';

import '../web/pengecualian/controllers/pengecualian_controller.dart';
import 'btnDefault.dart';

class PengecualianDTS extends DataTableSource {
  final List<PengecualianModel> pengecualianList;

  PengecualianDTS(this.pengecualianList);

  final c = Get.put(PengecualianController());

  int sortColumnIndex = 0;
  bool sortAscending = true;

  void sortData() {
    pengecualianList.sort((a, b) {
      int result = 0;
      switch (c.sortColumnIndex.value) {
        case 0:
          result = a.nama!.compareTo(b.nama!);
          break;
        case 1:
          result = a.statusPengecualian!.compareTo(b.statusPengecualian!);
          break;
        case 2:
          result = a.dateStart!.compareTo(b.dateStart!);
          break;
        case 3:
          result = a.dateEnd!.compareTo(b.dateEnd!);
          break;
      }
      return c.sortAscending.value ? result : -result;
    });
  }

  @override
  DataRow getRow(int index) {
    sortData();
    PengecualianModel data = pengecualianList[index];
    var formatter = DateFormat('d MMMM yyyy', 'id-ID');
    return DataRow(
      cells: [
        DataCell(Text(
          "${data.nama}",
          style: getTextTableData(Get.context!),
        )),
        DataCell(Text(
          "${data.statusPengecualian}",
          style: getTextTableData(Get.context!),
        )),
        DataCell(Text(
          "${formatter.format(data.dateStart!)}",
          style: getTextTableData(Get.context!),
        )),
        DataCell(Text(
          "${formatter.format(data.dateEnd!)}",
          style: getTextTableData(Get.context!),
        )),
        DataCell(IconButton(
            onPressed: () {
              c.deletePengecualian(data.id!);
            },
            icon: Icon(
              IconlyLight.delete,
              color: Blue1,
            ))),
        DataCell(IconButton(
            onPressed: () {
              textC.addPengecualianC.text = data.nama!;
              cDropdown.addPengecualianStatusLiburC.text =
                  data.statusPengecualian!;
              textC.datepickerC.text =
                  "${formatter.format(data.dateStart!)} - ${formatter.format(data.dateEnd!)}";
              Get.dialog(
                dialogAddPengecualian(
                    Get.context!,
                    btnDefaultIcon1(10.w, Blue4, IconlyLight.tick_square,
                        Yellow1, "Kirim", getTextBtnAction(Get.context!), () {
                      if (textC.addPengecualianKey.value.currentState!
                              .validate() &&
                          cDropdown
                              .addPengecualianStatusLiburKey.value.currentState!
                              .validate() &&
                          textC.datepickerKey.value.currentState!.validate()) {
                        c.editPengecualian(
                            data.id!,
                            textC.addPengecualianC.text,
                            cDropdown.addPengecualianStatusLiburC.text);
                      }
                    })),
              );
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
  int get rowCount => pengecualianList.length;

  @override
  int get selectedRowCount => 0;
}
