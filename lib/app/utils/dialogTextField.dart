import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/theme/textstyle.dart';
import 'package:project_tugas_akhir/app/utils/btnDefault.dart';
import 'package:project_tugas_akhir/app/utils/dropdownTextField.dart';
import 'package:project_tugas_akhir/app/utils/textfield.dart';
import 'package:sizer/sizer.dart';

import '../theme/theme.dart';

Widget dialogTextFieldSevenField(BuildContext context, Widget btnAction) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Blue1,
    child: Container(
      width: 140.h,
      height: 90.h,
      child: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 3.w,
              ),
              Text(
                "Tambah Data",
                style: getTextDialogFieldHeader(context),
              ),
            ],
          ),
          SizedBox(
            height: 2.5.h,
          ),
          textformDialogWeb(
              context,
              textC.namaTambahDataPegKey.value,
              45.4.w,
              textC.namaTambahDataPegC,
              textC.normalValidator,
              null,
              null,
              null,
              null,
              "Masukkan nama pegawai...",
              Colors.transparent,
              Yellow1,
              Yellow1),
          SizedBox(
            height: 1.5.h,
          ),
          dropdownNormalField(
              context, 45.4.w, cDropdown.pinTambahDataPegKey.value, (value) {
            if (value != null) {
              cDropdown.setPin(value);
            }
          }, ['1', '2', '3', '4'], null, "Pilih PIN Pegawai...",
              Colors.transparent, Yellow1, Yellow1, Yellow1),
          SizedBox(
            height: 4.5.h,
          ),
          dropdownNormalField(
              context, 45.4.w, cDropdown.jadkerTambahDataPegKey.value, (value) {
            if (value != null) {
              cDropdown.setPin(value);
            }
          },
              ['JPC', 'JPR', 'JDK', 'JRR'],
              null,
              "Pilih Kode Jadwal Kerja Pegawai...",
              Colors.transparent,
              Yellow1,
              Yellow1,
              Yellow1),
          SizedBox(
            height: 4.5.h,
          ),
          textformDialogWeb(
            context,
            textC.nipTambahDataPegKey.value,
            45.4.w,
            textC.nipTambahDataPegC,
            textC.normalValidator,
            null,
            null,
            null,
            null,
            "Masukkan NIP/PEGID pegawai...",
            Colors.transparent,
            Yellow1,
            Yellow1,
          ),
          SizedBox(
            height: 1.5.h,
          ),
          dropdownNormalField(
              context, 45.4.w, cDropdown.bidangTambahDataPegKey.value, (value) {
            if (value != null) {
              cDropdown.setPin(value);
            }
          }, [
            'Guru Kelas',
            'Operator Sekolah',
            'Guru Mapel',
            'Kepala Sekolah'
          ], null, "Pilih Bidang Kerja Pegawai...", Colors.transparent, Yellow1,
              Yellow1, Yellow1),
          SizedBox(
            height: 4.5.h,
          ),
          textformDialogWeb(
            context,
            textC.emailTambahDataPegKey.value,
            45.4.w,
            textC.emailTambahDataPegC,
            textC.normalValidator,
            null,
            null,
            null,
            null,
            "Masukkan email pegawai...",
            Colors.transparent,
            Yellow1,
            Yellow1,
          ),
          SizedBox(
            height: 1.5.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: 3.8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                btnAction,
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
