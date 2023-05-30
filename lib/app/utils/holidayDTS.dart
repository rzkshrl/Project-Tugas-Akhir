// ignore_for_file: file_names, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/utils/dialogTextField.dart';
import 'package:project_tugas_akhir/app/utils/textfield.dart';
import 'package:sizer/sizer.dart';

import '../data/models/firestorehariliburmodel.dart';
import '../modules/hari_libur/controllers/hari_libur_controller.dart';
import '../theme/textstyle.dart';
import '../theme/theme.dart';
import 'package:intl/intl.dart';

import 'btnDefault.dart';

class HolidayDTS extends DataTableSource {
  final List<HolidayModel> holidayList;

  HolidayDTS(this.holidayList);

  final c = Get.put(HariLiburController());

  @override
  DataRow getRow(int index) {
    HolidayModel data = holidayList[index];
    var formatter = DateFormat('d MMMM yyyy', 'id-ID');
    return DataRow(
      cells: [
        DataCell(Text(
          "${data.name}",
          style: getTextTableData(Get.context!),
        )),
        DataCell(Text(
          "${formatter.format(DateTime.parse("${data.date!}"))}",
          style: getTextTableData(Get.context!),
        )),
        DataCell(IconButton(
            onPressed: () {
              c.deleteHariLibur(data.date!);
            },
            icon: Icon(
              IconlyLight.delete,
              color: Blue1,
            ))),
        DataCell(IconButton(
            onPressed: () {
              textC.addNamaLiburC.text = data.name!;
              textC.datepickerC.text =
                  formatter.format(DateTime.parse(data.date!));
              Get.dialog(
                dialogAddLibur(
                    Get.context!,
                    btnDefaultIcon1(10.w, Blue4, IconlyLight.tick_square,
                        Yellow1, "Kirim", getTextBtnAction(Get.context!), () {
                      textC.addLiburC.clear();
                      textC.addNamaLiburC.clear();
                      if (textC.addNamaLiburKey.value.currentState!
                              .validate() &&
                          textC.datepickerKey.value.currentState!.validate()) {
                        c.editHariLibur(data.date!, textC.addNamaLiburC.text,
                            textC.datepickerC.text);
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
  int get rowCount => holidayList.length;

  @override
  int get selectedRowCount => 0;
}
