// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_tugas_akhir/app/theme/textstyle.dart';
import 'package:project_tugas_akhir/app/utils/dropdownTextField.dart';
import 'package:project_tugas_akhir/app/utils/textfield.dart';
import 'package:project_tugas_akhir/app/utils/timepickerC.dart';
import 'package:sizer/sizer.dart';

import '../modules/jam_kerja/controllers/jam_kerja_controller.dart';
import '../theme/theme.dart';

var enabled = true.obs;
final timepickerC = Get.put(TimePickerController());
final dayPickC = Get.put(JamKerjaController());

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

Widget dialogTextJadwalKerja(BuildContext context, Widget btnAction) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Blue1,
    content: SizedBox(
      width: 120.h,
      height: 90.h,
      child: Column(
        children: [
          SizedBox(
            height: 3.h,
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
              textC.namaJadwalKerjaKey.value,
              45.4.w,
              textC.namaJadwalKerjaC,
              textC.normalValidator,
              null,
              null,
              null,
              null,
              "Masukkan nama jadwal kerja...",
              Colors.transparent,
              Yellow1,
              Yellow1,
              false),
          SizedBox(
            height: 1.5.h,
          ),
          textformDialogWeb(
              context,
              textC.kodeJadwalKerjaKey.value,
              45.4.w,
              textC.kodeJadwalKerjaC,
              textC.normalValidator,
              null,
              null,
              null,
              null,
              "Masukkan kode jadwal kerja...",
              Colors.transparent,
              Yellow1,
              Yellow1,
              false),
          SizedBox(
            height: 1.5.h,
          ),
          textformDialogWeb(
            context,
            textC.ketJadwalKerjaKey.value,
            45.4.w,
            textC.ketJadwalKerjaC,
            textC.normalValidator,
            null,
            null,
            null,
            null,
            "Masukkan keterangan jadwal kerja...",
            Colors.transparent,
            Yellow1,
            Yellow1,
            false,
          ),
          SizedBox(
            height: 1.5.h,
          ),
          Container(
            width: 45.4.w,
            height: 38.5.h,
            decoration: BoxDecoration(
                border: Border.all(color: Yellow1),
                borderRadius: BorderRadius.circular(22)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Text(
                      'Hari Kerja',
                      style: getTextItemSubMenu(context),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    SizedBox(
                      width: 15.4.w,
                      height: 30.h,
                      child: StatefulBuilder(builder: (context, setState) {
                        return ListView.builder(
                          itemCount: dayPickC.daysOfWeek.length,
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(bottom: 0),
                          itemBuilder: (context, index) {
                            final day = dayPickC.daysOfWeek[index];
                            final isChecked =
                                dayPickC.selectedDays.contains(day);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 0),
                              child: Theme(
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor:
                                      light, // Warna border tidak dipilih
                                  checkboxTheme: CheckboxThemeData(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          5.0), // Ubah radius border
                                      side: BorderSide(
                                          color: light), // Ubah warna border
                                    ),
                                  ),
                                ),
                                child: CheckboxListTile(
                                  title: Text(
                                    day,
                                    style: getTextFormDialog(context),
                                  ),
                                  value: isChecked,
                                  checkColor: light,
                                  activeColor: Blue3,
                                  controlAffinity:
                                      ListTileControlAffinity.trailing,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      dayPickC.toggleDay(day);
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
                // SizedBox(
                //   width: 5.w,
                // ),
                Container(
                  width: 15.4.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: Yellow1),
                      borderRadius: BorderRadius.circular(22)),
                )
              ],
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
  );
}

Widget dialogTextJamKerja(BuildContext context, Widget btnAction) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Blue1,
    content: SizedBox(
      width: 120.h,
      height: 90.h,
      child: Column(
        children: [
          SizedBox(
            height: 2.h,
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
            height: 1.h,
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
          textformDialogWeb(
              context,
              textC.kodeJamKerjaKey.value,
              45.4.w,
              textC.kodeJamKerjaC,
              textC.normalValidator,
              null,
              null,
              null,
              null,
              "Masukkan kode jam kerja...",
              Colors.transparent,
              Yellow1,
              Yellow1,
              false),
          // SizedBox(
          //   height: 1.5.h,
          // ),
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
          Container(
            width: 60.4.w,
            height: 38.5.h,
            decoration: BoxDecoration(
                border: Border.all(color: Yellow1),
                borderRadius: BorderRadius.circular(22)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 12.4.w,
                  height: 30.h,
                  child: StatefulBuilder(builder: (context, setState) {
                    return ListView.builder(
                      itemCount: dayPickC.daysOfWeek.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 0),
                      itemBuilder: (context, index) {
                        final day = dayPickC.daysOfWeek[index];
                        final isChecked = dayPickC.isDaySelected(day);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              unselectedWidgetColor:
                                  light, // Warna border tidak dipilih
                              checkboxTheme: CheckboxThemeData(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      5.0), // Ubah radius border
                                  side: BorderSide(
                                      color: light), // Ubah warna border
                                ),
                              ),
                            ),
                            child: CheckboxListTile(
                              title: Text(
                                day,
                                style: getTextFormDialog(context),
                              ),
                              value: isChecked,
                              checkColor: light,
                              activeColor: Blue3,
                              controlAffinity: ListTileControlAffinity.trailing,
                              onChanged: (bool? value) {
                                setState(() {
                                  dayPickC.toggleDay(day);
                                });
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
                SizedBox(
                  width: 40.4.w,
                  height: 30.h,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 1.5.h,
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
                                  timepickerC.selectedTime.value !=
                                          TimeOfDay.now()
                                      ? TextEditingController(text: '')
                                      : textC.masukJamKerjaC, () {
                                timepickerC.timePicker(
                                    context, textC.masukJamKerjaC);
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
                                height: 1.5.h,
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
                                  timepickerC.selectedTime.value !=
                                          TimeOfDay.now()
                                      ? TextEditingController(text: '')
                                      : textC.terlambatJamKerjaC, () {
                                timepickerC.timePicker(
                                    context, textC.terlambatJamKerjaC);
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
                                height: 1.5.h,
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
                                  timepickerC.selectedTime.value !=
                                          TimeOfDay.now()
                                      ? TextEditingController(text: '')
                                      : textC.keluarJamKerjaC, () {
                                timepickerC.timePicker(
                                    context, textC.keluarJamKerjaC);
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
                                  timepickerC.selectedTime.value !=
                                          TimeOfDay.now()
                                      ? TextEditingController(text: '')
                                      : textC.batasAwalmasukJamKerjaC, () {
                                timepickerC.timePicker(
                                    context, textC.batasAwalmasukJamKerjaC);
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
                                  timepickerC.selectedTime.value !=
                                          TimeOfDay.now()
                                      ? TextEditingController(text: '')
                                      : textC.pulLebihAwalJamKerjaC, () {
                                timepickerC.timePicker(
                                    context, textC.pulLebihAwalJamKerjaC);
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
                                  timepickerC.selectedTime.value !=
                                          TimeOfDay.now()
                                      ? TextEditingController(text: '')
                                      : textC.batasAkhirmasukJamKerjaC, () {
                                timepickerC.timePicker(
                                    context, textC.batasAkhirmasukJamKerjaC);
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
                                  timepickerC.selectedTime.value !=
                                          TimeOfDay.now()
                                      ? TextEditingController(text: '')
                                      : textC.batasAwalkeluarJamKerjaC, () {
                                timepickerC.timePicker(
                                    context, textC.batasAwalkeluarJamKerjaC);
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
                                  timepickerC.selectedTime.value !=
                                          TimeOfDay.now()
                                      ? TextEditingController(text: '')
                                      : textC.batasAkhirkeluarJamKerjaC, () {
                                timepickerC.timePicker(
                                    context, textC.batasAkhirkeluarJamKerjaC);
                              }),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 4.5.h,
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
