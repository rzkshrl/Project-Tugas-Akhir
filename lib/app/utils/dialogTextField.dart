// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitorpresensi/app/web/hari_libur/controllers/hari_libur_controller.dart';
import 'package:monitorpresensi/app/theme/textstyle.dart';
import 'package:monitorpresensi/app/utils/datePicker.dart';
import 'package:monitorpresensi/app/utils/dropdownTextField.dart';
import 'package:monitorpresensi/app/utils/textfield.dart';
import 'package:monitorpresensi/app/utils/timepickerC.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../web/jam_kerja/controllers/jam_kerja_controller.dart';
import '../web/pengecualian/controllers/pengecualian_controller.dart';
import '../web/super-admin/controllers/super_admin_controller.dart';
import '../theme/theme.dart';
import 'dialogDefault.dart';

final timepickerC = Get.put(TimePickerController(), permanent: true);
final dayPickC = Get.put(JamKerjaController());
final hariLiburC = Get.put(HariLiburController());
final superAdminC = Get.put(SuperAdminController());
final pengecualianC = Get.put(PengecualianController());

Widget dialogTextFieldSevenField(
    BuildContext context, Widget btnAction, bool enabled) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Blue1,
    content: SizedBox(
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
              Yellow1,
              false),
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
              Yellow1,
              enabled),
          SizedBox(
            height: 1.5.h,
          ),
          dropdownNormalField(
              context, 45.4.w, cDropdown.kepgTambahDataPegKey.value, (value) {
            if (value != null) {
              cDropdown.kepgTambahDataPegC.text = value;
            }
          },
              ['PNS', 'NON-PNS'],
              null,
              "Pilih Jenis Kepegawaian...",
              Colors.transparent,
              Yellow1,
              Yellow1,
              Yellow1,
              cDropdown.kepgTambahDataPegC.text == ''
                  ? null
                  : cDropdown.kepgTambahDataPegC.text),
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
            false,
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
                'Kepala Sekolah',
                'Operator Sekolah',
                'Guru Kelas',
                'Guru Mapel'
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
          // textformDialogWeb(
          //     context,
          //     textC.emailTambahDataPegKey.value,
          //     45.4.w,
          //     textC.emailTambahDataPegC,
          //     textC.emailValidator,
          //     null,
          //     null,
          //     null,
          //     null,
          //     "Masukkan email pegawai...",
          //     Colors.transparent,
          //     Yellow1,
          //     Yellow1,
          //     false),
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

Widget dialogTextFieldDataUser(
    BuildContext context, Widget btnAction, bool enabled) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Blue1,
    content: SizedBox(
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
              textC.namaDataUserKey.value,
              45.4.w,
              textC.namaDataUserC,
              textC.normalValidator,
              null,
              null,
              null,
              null,
              "Masukkan nama pegawai...",
              Colors.transparent,
              Yellow1,
              Yellow1,
              false),
          SizedBox(
            height: 1.5.h,
          ),
          dropdownNormalField3(
              context,
              45.4.w,
              cDropdown.roleDataUserKey.value,
              (value) {
                if (value != null) {
                  cDropdown.roleDataUserC.text = value;
                }
              },
              superAdminC.itemRoleUser,
              (item) {
                int index = superAdminC.itemRoleUser.indexOf(item!);
                return superAdminC.itemRoleView[index];
              },
              null,
              "Pilih Role Pegawai...",
              Colors.transparent,
              Yellow1,
              Yellow1,
              cDropdown.roleDataUserC.text == ''
                  ? null
                  : cDropdown.roleDataUserC.text),
          SizedBox(
            height: 4.5.h,
          ),
          dropdownNormalField(
              context, 45.4.w, cDropdown.jabatanDataUserKey.value, (value) {
            if (value != null) {
              cDropdown.jabatanDataUserC.text = value;
            }
          },
              [
                'Kepala Sekolah',
                'Operator Sekolah',
                'Guru Kelas',
                'Guru Mapel'
              ],
              null,
              "Pilih Jabatan Pegawai...",
              Colors.transparent,
              Yellow1,
              Yellow1,
              Yellow1,
              cDropdown.jabatanDataUserC.text == ''
                  ? null
                  : cDropdown.jabatanDataUserC.text),
          SizedBox(
            height: 4.5.h,
          ),
          textformDialogWeb(
              context,
              textC.emailDataUserKey.value,
              45.4.w,
              textC.emailDataUserC,
              textC.emailValidator,
              null,
              null,
              null,
              null,
              "Masukkan email pegawai...",
              Colors.transparent,
              Yellow1,
              Yellow1,
              false),
          SizedBox(
            height: 1.5.h,
          ),
          textformDialogWeb(
              context,
              textC.pinDataUserKey.value,
              45.4.w,
              textC.pinDataUserC,
              textC.normalValidator,
              null,
              null,
              null,
              null,
              "Masukkan PIN pegawai...",
              Colors.transparent,
              Yellow1,
              Yellow1,
              false),
          SizedBox(
            height: 1.5.h,
          ),
          textformPassWebDialog(
            context,
            textC.passDataUserKey.value,
            textC.passDataUserC,
            null,
            null,
            'Masukkan password pegawai',
            enabled,
            enabled == true ? false : true,
            45.4.w,
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

Widget dialogTextFieldEditDataUser(
    BuildContext context, Widget btnAction, bool enabled) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Blue1,
    content: SizedBox(
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
              textC.namaDataUserKey.value,
              45.4.w,
              textC.namaDataUserC,
              textC.normalValidator,
              null,
              null,
              null,
              null,
              "Masukkan nama pegawai...",
              Colors.transparent,
              Yellow1,
              Yellow1,
              false),
          SizedBox(
            height: 1.5.h,
          ),
          dropdownNormalField3(
              context,
              45.4.w,
              cDropdown.roleDataUserKey.value,
              (value) {
                if (value != null) {
                  cDropdown.roleDataUserC.text = value;
                }
              },
              superAdminC.itemRoleUser,
              (item) {
                int index = superAdminC.itemRoleUser.indexOf(item!);
                return superAdminC.itemRoleView[index];
              },
              null,
              "Pilih Role Pegawai...",
              Colors.transparent,
              Yellow1,
              Yellow1,
              cDropdown.roleDataUserC.text == ''
                  ? null
                  : cDropdown.roleDataUserC.text),
          SizedBox(
            height: 4.5.h,
          ),
          dropdownNormalField(
              context, 45.4.w, cDropdown.jabatanDataUserKey.value, (value) {
            if (value != null) {
              cDropdown.jabatanDataUserC.text = value;
            }
          },
              [
                'Kepala Sekolah',
                'Operator Sekolah',
                'Guru Kelas',
                'Guru Mapel'
              ],
              null,
              "Pilih Jabatan Pegawai...",
              Colors.transparent,
              Yellow1,
              Yellow1,
              Yellow1,
              cDropdown.jabatanDataUserC.text == ''
                  ? null
                  : cDropdown.jabatanDataUserC.text),
          SizedBox(
            height: 4.5.h,
          ),
          textformDialogWeb(
              context,
              textC.emailDataUserKey.value,
              45.4.w,
              textC.emailDataUserC,
              textC.emailValidator,
              null,
              null,
              null,
              null,
              "Masukkan email pegawai...",
              Colors.transparent,
              Yellow1,
              Yellow1,
              false),
          SizedBox(
            height: 1.5.h,
          ),
          textformDialogWeb(
              context,
              textC.pinDataUserKey.value,
              45.4.w,
              textC.pinDataUserC,
              textC.normalValidator,
              null,
              null,
              null,
              null,
              "Masukkan PIN pegawai...",
              Colors.transparent,
              Yellow1,
              Yellow1,
              false),
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

Widget dialogTextJamKerja(bool isEdit, BuildContext context, Widget btnAction) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Blue1,
    content: Obx(
      () => SizedBox(
        width: 120.h,
        height: 90.h,
        child: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 3.w,
                ),
                Text(
                  "Tambah Data",
                  style: getTextDialogFieldHeader2(context),
                ),
              ],
            ),
            SizedBox(
              height: 2.5.h,
            ),
            textformDialogWeb(
                context,
                textC.namaJamKerjaKey.value,
                45.4.w,
                textC.namaJamKerjaC,
                textC.normalValidator,
                null,
                null,
                null,
                null,
                "Masukkan nama jam kerja...",
                Colors.transparent,
                Yellow1,
                Yellow1,
                false),
            // SizedBox(
            //   height: 1.5.h,
            // ),
            dropdownNormalField(
                context, 45.4.w, cDropdown.kepgTambahDataPegKey.value, (value) {
              if (value != null) {
                cDropdown.kepgTambahDataPegC.text = value;
              }
            },
                ['PNS', 'NON-PNS'],
                null,
                "Pilih Jenis Kepegawaian...",
                Colors.transparent,
                Yellow1,
                Yellow1,
                Yellow1,
                cDropdown.kepgTambahDataPegC.text == ''
                    ? null
                    : cDropdown.kepgTambahDataPegC.text),
            SizedBox(
              height: 3.h,
            ),
            textformDialogWeb(
              context,
              textC.ketJamKerjaKey.value,
              45.4.w,
              textC.ketJamKerjaC,
              textC.normalValidator,
              null,
              null,
              null,
              null,
              "Masukkan keterangan jam kerja...",
              Colors.transparent,
              Yellow1,
              Yellow1,
              false,
            ),
            // SizedBox(
            //   height: 1.5.h,
            // ),
            SingleChildScrollView(
              child: Container(
                width: 60.4.w,
                height: 42.5.h,
                decoration: BoxDecoration(
                    border: Border.all(color: Yellow1),
                    borderRadius: BorderRadius.circular(22)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 12.4.w,
                      height: 35.h,
                      child: StatefulBuilder(builder: (context, setState) {
                        return ListView.builder(
                          itemCount: dayPickC.daysOfWeek.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(bottom: 0),
                          itemBuilder: (context, index) {
                            final day = dayPickC.daysOfWeek[index];
                            return Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: light,
                                radioTheme: RadioThemeData(
                                  fillColor: fillColorRadioButton,
                                ),
                              ),
                              child: RadioListTile<String>(
                                title: Text(
                                  day,
                                  style: getTextFormDialog(context),
                                ),
                                value: day,
                                groupValue: dayPickC.selectedDay.value,
                                onChanged: (String? value) {
                                  setState(() {
                                    dayPickC.selectedDay.value = value!;
                                  });
                                },
                              ),
                            );
                          },
                        );
                      }),
                    ),
                    SizedBox(
                      width: 40.4.w,
                      height: 35.h,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      'Jadwal Jam Masuk',
                                      style: getTextItemSubMenu(context),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    textformTimePicker(
                                        textC.masukJamKerjaKey.value,
                                        textC.masukJamKerjaC, () {
                                      if (isEdit == false) {
                                        timepickerC.timePicker(
                                          context,
                                          textC.masukJamKerjaC,
                                        );
                                      } else if (isEdit == true) {
                                        timepickerC.timePickerEdit(
                                          context,
                                          textC.masukJamKerjaC,
                                        );
                                      }
                                    }),
                                  ],
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      'Keterlambatan',
                                      style: getTextItemSubMenu(context),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    textformTimePicker(
                                        textC.terlambatJamKerjaKey.value,
                                        textC.terlambatJamKerjaC, () {
                                      if (isEdit == false) {
                                        timepickerC.timePicker(
                                          context,
                                          textC.terlambatJamKerjaC,
                                        );
                                      } else if (isEdit == true) {
                                        timepickerC.timePickerEdit(
                                          context,
                                          textC.terlambatJamKerjaC,
                                        );
                                      }
                                    }),
                                  ],
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 0.5.h,
                                    ),
                                    Text(
                                      'Jadwal Jam Keluar',
                                      style: getTextItemSubMenu(context),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    textformTimePicker(
                                        textC.keluarJamKerjaKey.value,
                                        textC.keluarJamKerjaC, () {
                                      if (isEdit == false) {
                                        timepickerC.timePicker(
                                          context,
                                          textC.keluarJamKerjaC,
                                        );
                                      } else if (isEdit == true) {
                                        timepickerC.timePickerEdit(
                                          context,
                                          textC.keluarJamKerjaC,
                                        );
                                      }
                                    }),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Batas Awal Jam Masuk',
                                      style: getTextItemSubMenu(context),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    textformTimePicker(
                                        textC.batasAwalmasukJamKerjaKey.value,
                                        textC.batasAwalmasukJamKerjaC, () {
                                      if (isEdit == false) {
                                        timepickerC.timePicker(
                                          context,
                                          textC.batasAwalmasukJamKerjaC,
                                        );
                                      } else if (isEdit == true) {
                                        timepickerC.timePickerEdit(
                                          context,
                                          textC.batasAwalmasukJamKerjaC,
                                        );
                                      }
                                    }),
                                  ],
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 2.5.h,
                                    ),
                                    Text(
                                      'Pulang Lebih Awal',
                                      style: getTextItemSubMenu(context),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    textformTimePicker(
                                        textC.pulLebihAwalJamKerjaKey.value,
                                        textC.pulLebihAwalJamKerjaC, () {
                                      if (isEdit == false) {
                                        timepickerC.timePicker(
                                          context,
                                          textC.pulLebihAwalJamKerjaC,
                                        );
                                      } else if (isEdit == true) {
                                        timepickerC.timePickerEdit(
                                          context,
                                          textC.pulLebihAwalJamKerjaC,
                                        );
                                      }
                                    }),
                                  ],
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Batas Akhir Jam Masuk',
                                      style: getTextItemSubMenu(context),
                                    ),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    textformTimePicker(
                                        textC.batasAkhirmasukJamKerjaKey.value,
                                        textC.batasAkhirmasukJamKerjaC, () {
                                      if (isEdit == false) {
                                        timepickerC.timePicker(
                                          context,
                                          textC.batasAkhirmasukJamKerjaC,
                                        );
                                      } else if (isEdit == true) {
                                        timepickerC.timePickerEdit(
                                          context,
                                          textC.batasAkhirmasukJamKerjaC,
                                        );
                                      }
                                    }),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Batas Awal Jam Keluar',
                                      style: getTextItemSubMenu(context),
                                    ),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    textformTimePicker(
                                        textC.batasAwalkeluarJamKerjaKey.value,
                                        textC.batasAwalkeluarJamKerjaC, () {
                                      if (isEdit == false) {
                                        timepickerC.timePicker(
                                          context,
                                          textC.batasAwalkeluarJamKerjaC,
                                        );
                                      } else if (isEdit == true) {
                                        timepickerC.timePickerEdit(
                                          context,
                                          textC.batasAwalkeluarJamKerjaC,
                                        );
                                      }
                                    }),
                                  ],
                                ),
                                SizedBox(
                                  width: 4.5.w,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Batas Akhir Jam Keluar',
                                      style: getTextItemSubMenu(context),
                                    ),
                                    SizedBox(
                                      height: 1.5.h,
                                    ),
                                    textformTimePicker(
                                        textC.batasAkhirkeluarJamKerjaKey.value,
                                        textC.batasAkhirkeluarJamKerjaC, () {
                                      if (isEdit == false) {
                                        timepickerC.timePicker(
                                          context,
                                          textC.batasAkhirkeluarJamKerjaC,
                                        );
                                      } else if (isEdit == true) {
                                        timepickerC.timePickerEdit(
                                          context,
                                          textC.batasAkhirkeluarJamKerjaC,
                                        );
                                      }
                                    }),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
    ),
  );
}

Widget dialogAPILibur(BuildContext context, Widget btnAction) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Blue1,
    content: SizedBox(
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
              Yellow1,
              false),
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

Widget dialogAddLibur(BuildContext context, Widget btnAction) {
  return Obx(
    () => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Blue1,
      content: SizedBox(
        width: 35.w,
        height: 37.h,
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 2.w,
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
                textC.addNamaLiburKey.value,
                42.4.w,
                textC.addNamaLiburC,
                textC.normalValidator,
                null,
                null,
                null,
                null,
                "Masukkan nama hari libur...",
                Colors.transparent,
                Yellow1,
                Yellow1,
                false),
            SizedBox(
              height: 1.5.h,
            ),
            textformDatePicker(
              hariLiburC.selectedDate.value.isAtSameMomentAs(DateTime.now())
                  ? TextEditingController(text: '')
                  : textC.datepickerC,
              () {
                Get.dialog(datePickerDialog(DateRangePickerSelectionMode.single,
                    (value) {
                  if (value != null) {
                    hariLiburC.selectDateHariLibur;
                    Get.back();
                  }
                }, hariLiburC.selectDateHariLibur,
                    hariLiburC.datePickerController));
              },
              42.4.w,
              Colors.transparent,
              Yellow1,
              Yellow1,
              Yellow1,
              getTextFormDialog(context),
              null,
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
    ),
  );
}

Widget dialogAddPengecualian(BuildContext context, Widget btnAction) {
  return Obx(
    () => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Blue1,
      content: SizedBox(
        width: 35.w,
        height: 45.h,
        child: Column(
          children: [
            SizedBox(
              height: 2.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 2.w,
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
                textC.addPengecualianKey.value,
                42.4.w,
                textC.addPengecualianC,
                textC.normalValidator,
                null,
                null,
                null,
                null,
                "Masukkan nama pengecualian...",
                Colors.transparent,
                Yellow1,
                Yellow1,
                false),
            dropdownNormalField(
                context, 45.4.w, cDropdown.addPengecualianStatusLiburKey.value,
                (value) {
              if (value != null) {
                cDropdown.addPengecualianStatusLiburC.text = value;
              }
            },
                [
                  'Ya',
                  'Bukan',
                ],
                null,
                "Pilih Status Libur Pengecualian...",
                Colors.transparent,
                Yellow1,
                Yellow1,
                Yellow1,
                cDropdown.addPengecualianStatusLiburC.text == ''
                    ? null
                    : cDropdown.addPengecualianStatusLiburC.text),
            SizedBox(
              height: 2.5.h,
            ),
            textformDatePicker(
              pengecualianC.end.value.isAtSameMomentAs(DateTime.now())
                  ? TextEditingController(text: '')
                  : textC.datepickerC,
              () {
                Get.dialog(datePickerDialog(DateRangePickerSelectionMode.range,
                    (value) {
                  if (value != null) {
                    if ((value as PickerDateRange).endDate != null) {
                      pengecualianC.pickRangeDate(
                          value.startDate!, value.endDate!);
                      Get.back();
                    } else {
                      Get.dialog(dialogAlertOnlyAnimation(
                          'assets/lootie/warning.json',
                          "Terjadi Kesalahan.",
                          "Pilih tanggal jangkauan\n(Senin-Sabtu, dsb)\n(tekan tanggal dua kali \nuntuk memilih tanggal yang sama)",
                          getTextAlert(context),
                          getTextAlertSub(context)));
                    }
                  } else {
                    Get.dialog(dialogAlertOnlyAnimation(
                        'assets/lootie/warning.json',
                        "Terjadi Kesalahan.",
                        "Tanggal tidak dipilih.",
                        getTextAlert(context),
                        getTextAlertSub(context)));
                  }
                }, null, null));
              },
              42.4.w,
              Colors.transparent,
              Yellow1,
              Yellow1,
              Yellow1,
              getTextFormDialog(context),
              null,
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
    ),
  );
}
