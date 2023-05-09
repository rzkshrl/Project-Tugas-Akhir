import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/theme/textstyle.dart';
import 'package:project_tugas_akhir/app/utils/btnDefault.dart';
import 'package:project_tugas_akhir/app/utils/dropdownTextField.dart';
import 'package:project_tugas_akhir/app/utils/textfield.dart';
import 'package:sizer/sizer.dart';

import '../theme/theme.dart';

Widget dialogTextFieldSevenField(BuildContext context, Widget btnAction) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Blue1,
    content: Container(
      width: 120.h,
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
          textformDialogWeb(
              context,
              textC.pinTambahDataPegKey.value,
              45.4.w,
              textC.pinTambahDataPegC,
              textC.normalValidator,
              null,
              null,
              null,
              null,
              "Masukkan PIN pegawai...",
              Colors.transparent,
              Yellow1,
              Yellow1),
          SizedBox(
            height: 1.5.h,
          ),
          dropdownNormalField(
              context, 45.4.w, cDropdown.jadkerTambahDataPegKey.value, (value) {
            if (value != null) {
              cDropdown.jadkerTambahDataPegC.text = value;
            }
          },
              ['JPC', 'JPR', 'JDK', 'JRR'],
              null,
              "Pilih Kode Jadwal Kerja Pegawai...",
              Colors.transparent,
              Yellow1,
              Yellow1,
              Yellow1,
              cDropdown.jadkerTambahDataPegC.text == ''
                  ? null
                  : cDropdown.jadkerTambahDataPegC.text),
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
              cDropdown.bidangTambahDataPegC.text = value;
            }
          },
              [
                'Guru Kelas',
                'Operator Sekolah',
                'Guru Mapel',
                'Kepala Sekolah'
              ],
              null,
              "Pilih Bidang Kerja Pegawai...",
              Colors.transparent,
              Yellow1,
              Yellow1,
              Yellow1,
              cDropdown.bidangTambahDataPegC.text == ''
                  ? null
                  : cDropdown.bidangTambahDataPegC.text),
          SizedBox(
            height: 4.5.h,
          ),
          textformDialogWeb(
            context,
            textC.emailTambahDataPegKey.value,
            45.4.w,
            textC.emailTambahDataPegC,
            textC.emailValidator,
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

Widget dialogAPILibur(BuildContext context, Widget btnAction) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Blue1,
    content: Container(
      width: 350,
      height: 274.07,
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
              textC.yearAPILiburKey.value,
              45.4.w,
              textC.yearAPILiburC,
              textC.normalValidator,
              null,
              null,
              null,
              null,
              "Masukkan tahun... (Contoh: 2023)",
              Colors.transparent,
              Yellow1,
              Yellow1),
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
