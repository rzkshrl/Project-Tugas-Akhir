// ignore_for_file: file_names, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:monitorpresensi/app/utils/dialogTextField.dart';
import 'package:monitorpresensi/app/utils/textfield.dart';
import 'package:sizer/sizer.dart';

import '../data/models/firestorehariliburmodel.dart';
import '../web/hari_libur/controllers/hari_libur_controller.dart';
import '../theme/textstyle.dart';
import '../theme/theme.dart';
import 'package:intl/intl.dart';

import 'btnDefault.dart';

class HolidayDTS extends DataTableSource {
  final List<HolidayModel> holidayList;

  HolidayDTS(this.holidayList);

  final c = Get.put(HariLiburController());

  int sortColumnIndex = 0;
  bool sortAscending = true;

  void sortData() {
    holidayList.sort((a, b) {
      int result = 0;
      switch (c.sortColumnIndex.value) {
        case 0:
          result = a.name!.compareTo(b.name!);
          break;
        case 1:
          result = a.date!.compareTo(b.date!);
          break;
      }
      return c.sortAscending.value ? result : -result;
    });
  }

  @override
  DataRow getRow(int index) {
    sortData();
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
              c.deleteHariLibur(data.id!);
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
                      if (textC.addNamaLiburKey.value.currentState!
                              .validate() &&
                          textC.datepickerKey.value.currentState!.validate()) {
                        c.editHariLibur(data.id!, textC.addNamaLiburC.text,
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
