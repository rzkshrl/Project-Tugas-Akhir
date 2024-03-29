// ignore_for_file: unnecessary_brace_in_string_interps, use_build_context_synchronously, unnecessary_overrides, invalid_use_of_protected_member, deprecated_member_use

import 'dart:convert';
import 'package:monitorpresensi/app/data/models/firestorejamkerjamodel.dart';
import 'package:monitorpresensi/app/data/models/firestorepengecualianmodel.dart';
import 'package:monitorpresensi/app/utils/stringGlobal.dart';
import 'package:universal_html/html.dart' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:iconly/iconly.dart';
import 'package:monitorpresensi/app/data/models/allscanlogmodel.dart';
import 'package:monitorpresensi/app/data/models/deviceinfomodel.dart';

import '../data/models/devicemodel.dart';
import '../data/models/firestorehariliburmodel.dart';
import '../data/models/firestorescanlogmodel.dart';
import '../theme/textstyle.dart';
import '../utils/dialogDefault.dart';
import '../utils/urlHTTP.dart';

import 'dart:async';

import 'fcm_controller.dart';

class APIController extends GetxController {
  late BuildContext context1;
  APIController({required this.context1});

  final dio = Dio();

  var isLoading = false.obs;

  var deviceData = DeviceModel().obs;
  var deviceInfo = DeviceInfoModel().obs;
  var allScanlog = <AllScanlogModel>[].obs;
  var liburData = <LiburModel>[].obs;
  var kepgData = KepegawaianModel().obs;
  var jamKerjaData = JamKerjaModel().obs;
  var pengecualianData = PengecualianModel().obs;
  var pengecualianDataLibur = PengecualianModel().obs;
  var presensiList = [].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final fcmC = Get.put(FCMController());

  showLoadingDialog() {
    Get.dialog(
      dialogAlertOnlySingleMsgAnimation('assets/lootie/loading.json',
          'Memuat...', getTextAlert(Get.context!)),
      barrierDismissible: false,
    );
  }

  showFinishDialog() {
    Get.dialog(
      dialogAlertOnlySingleMsgAnimation(
          'assets/lootie/finish.json', 'Selesai!', getTextAlert(Get.context!)),
      barrierDismissible: true,
    );
  }

  Future<void> getLiburData(String year) async {
    if (kDebugMode) {
      print(year);
    }

    final response =
        await dio.get('https://api-harilibur.vercel.app/api?year=${year}');
    try {
      showLoadingDialog();

      final List<dynamic> responseData = response.data;

      for (var data in responseData) {
        LiburModel libur = LiburModel.fromJson(data);
        liburData.add(libur);
      }

      liburData.removeWhere((e) => e.isNationalDay == false);

      for (var libur in liburData) {
        // var formatter = DateFormat("yyyy-MM-dd");
        List<String> tanggal = libur.holidayDate!.split('-');
        String liburDate =
            '${tanggal[0]}-${tanggal[1]}-${tanggal[2].padLeft(2, '0')}';
        final liburCol = firestore.collection('Holiday').doc();
        final checkData = await liburCol.get();
        if (checkData.exists == false) {
          await liburCol.set({
            'name': libur.holidayName,
            'date': liburDate,
            'id': liburCol.id
          });
        }
      }
      Get.back();
      showFinishDialog();
    } catch (e) {
      Get.back();
      if (e is DioError) {
        if (kDebugMode) {
          print(e);
        }
        Get.dialog(dialogAlertOnlyAnimation(
            'assets/lootie/warning.json',
            "Terjadi Kesalahan.",
            "Tidak dapat tersambung dengan internet.",
            getTextAlert(Get.context!),
            getTextAlertSub(Get.context!)));
      }
      if (kDebugMode) {
        print(e);
        Get.dialog(dialogAlertOnlyAnimation(
            'assets/lootie/warning.json',
            "Terjadi Kesalahan.",
            "$e",
            getTextAlert(Get.context!),
            getTextAlertSub(Get.context!)));
      }
    }
  }

  Future<void> getDeviceInfo(BuildContext context) async {
    isLoading.value = true;
    final devices = await firestore.collection("Device").doc('mesin-1').get();
    final deviceDataDB = devices.data() as Map<String, dynamic>;

    deviceData(DeviceModel.fromJson(deviceDataDB));

    deviceData.refresh();

    var sn = deviceData.value.deviceSn;
    var ip = deviceData.value.serverIp;
    var port = deviceData.value.serverPort;
    var allPresensi = deviceData.value.allPresensi;
    var newPresensi = deviceData.value.newPresensi;

    if (kDebugMode) {
      print("Serial Number : $sn");
      print("IP server dan Port : $ip:$port");
      print("All Presensi : $allPresensi");
      print("New Presensi : $newPresensi");
    }

    try {
      showLoadingDialog();

      String urlGet = "http://$ip:$port$urlGetDeviceInfo?sn=${sn}";

      var res = await Future.wait([
        dio.post(
          urlGet,
        )
      ]);

      // ignore: avoid_print
      print('request berhasil');

      if (kDebugMode) {
        print('HASIL DEVINFO : ${res[0].data['Result']}');
        // print('BODY : ${res[0].data['DEVINFO']}');
      }

      if (res[0].data['Result'] == 'false') {
        Get.dialog(dialogAlertOnlyAnimation(
            'assets/lootie/warning.json',
            "Terjadi Kesalahan.",
            "Tidak dapat mengambil data dari mesin.",
            getTextAlert(context),
            getTextAlertSub(context)));
      } else {
        Map<String, dynamic> data = res[0].data['DEVINFO'];
        deviceInfo(DeviceInfoModel.fromJson(data));
        deviceInfo.refresh();
        if (allPresensi != deviceInfo.value.allPresensi) {
          firestore
              .collection('Device')
              .doc("mesin-1")
              .update({'allPresensi': deviceInfo.value.allPresensi});
        } else if (newPresensi != deviceInfo.value.newPresensi) {
          firestore
              .collection('Device')
              .doc("mesin-1")
              .update({'newPresensi': deviceInfo.value.newPresensi});
        }
        isLoading.value = false;

        // fcmC.sendNotificationToAllUser(titleNotif, messageNotif);

        Get.back();
        showFinishDialog();
      }
    } catch (e) {
      Get.back();
      if (e is DioError) {
        if (kDebugMode) {
          print(e);
        }
        Get.dialog(dialogAlertOnlyAnimation(
            'assets/lootie/warning.json',
            "Terjadi Kesalahan.",
            "Tidak dapat tersambung dengan mesin.",
            getTextAlert(context),
            getTextAlertSub(context)));
      }
      if (kDebugMode) {
        print(e);
      }
      Get.dialog(dialogAlertOnly(IconlyLight.danger, "Terjadi Kesalahan.", "$e",
          getTextAlert(context), getTextAlertSub(context)));
    }
  }

  Future<void> getDeviceInfo2(String? ip, int? port, int? sn,
      String? allPresensi, String? newPresensi) async {
    String urlGet = "http://$ip:$port$urlGetDeviceInfo?sn=${sn}";

    var res = await Future.wait([dio.post(urlGet)]);

    if (kDebugMode) {
      print('HASIL DEVINFO : ${res[0].data['Result']}');
      // print('BODY : ${res[0].data['DEVINFO']}');
    }

    if (res[0].data['Result'] == 'false') {
      Get.dialog(dialogAlertOnlyAnimation(
          'assets/lootie/warning.json',
          "Terjadi Kesalahan.",
          "Tidak dapat mengambil data dari mesin.",
          getTextAlert(Get.context!),
          getTextAlertSub(Get.context!)));
    } else {
      Map<String, dynamic> data = res[0].data['DEVINFO'];
      deviceInfo(DeviceInfoModel.fromJson(data));
      deviceInfo.refresh();
      if (allPresensi != deviceInfo.value.allPresensi) {
        firestore
            .collection('Device')
            .doc("mesin-1")
            .update({'allPresensi': deviceInfo.value.allPresensi});
      } else if (newPresensi != deviceInfo.value.newPresensi) {
        firestore
            .collection('Device')
            .doc("mesin-1")
            .update({'newPresensi': deviceInfo.value.newPresensi});
      }
    }
  }

  Future<void> getAllPresenceData(BuildContext context) async {
    isLoading.value = true;

    final devices = await firestore.collection("Device").doc('mesin-1').get();
    final deviceDataDB = devices.data() as Map<String, dynamic>;

    deviceData(DeviceModel.fromJson(deviceDataDB));

    deviceData.refresh();

    var sn = deviceData.value.deviceSn;
    var ip = deviceData.value.serverIp;
    var port = deviceData.value.serverPort;
    var allPresensi = deviceData.value.allPresensi;
    var newPresensi = deviceData.value.newPresensi;

    if (kDebugMode) {
      print("Data Before");
      print("IP server dan Port : $ip:$port");
      print("All Presensi : $allPresensi");
      print("New Presensi : $newPresensi");
    }

    final String url = "http://$ip:$port$urlGetScanlogWithPaging?sn=${sn}";
    // String url = 'https://monitorpresence.web.app/api';
    final List<dynamic> res = [];
    int pageNumber = 0;

    try {
      showLoadingDialog();

      while (true) {
        var response = await Future.wait([
          dio.post(
            '$url&page=$pageNumber&limit=100',
          )
        ]);
        final data = response[0].data['Data'];

        if (data != null) {
          res.addAll(data);

          if (data.length < 100) {
            break;
          }
        }

        pageNumber++;
      }
      if (kDebugMode) {
        print('Jumlah Data Response API : ${res.length}');
      }

      // ignore: avoid_print
      print('request berhasil');

      allScanlogList =
          List.from(res).map((e) => AllScanlogModel.fromJson(e)).toList();

      if (kDebugMode) {
        print('Jumlah Data Model : ${allScanlogList.length}');
      }

      RxList<Map<String, dynamic>> groupedData = <Map<String, dynamic>>[].obs;

      Map<String, List<Map<String, dynamic>>> groupedMap = {};

      for (var item in allScanlogList) {
        final pin = item.pin;
        final scanDate = item.scanDate!.toLocal();
        final date = '${scanDate.year}-${scanDate.month}-${scanDate.day}';
        final time = scanDate.toIso8601String();

        if (groupedMap.containsKey(pin)) {
          final presence = groupedMap[pin]!;

          final presenceIndex = presence.indexWhere((p) => p['date'] == date);

          if (presenceIndex != -1) {
            final scanInDay = presence[presenceIndex]['scanInDay'];

            scanInDay.add({'scan': time});
          } else {
            presence.add({
              'date': date,
              'scanInDay': [
                {'scan': time},
              ],
            });
          }
        } else {
          groupedMap[pin!] = [
            {
              'date': date,
              'scanInDay': [
                {'scan': time},
              ],
            },
          ];
        }
      }

      groupedMap.forEach((pin, presenceList) {
        for (var presence in presenceList) {
          final scanInDay = presence['scanInDay'];
          scanInDay.sort((a, b) => a['scan'].compareTo(b['scan']) as int);
        }
      });

      groupedMap.forEach((pin, presenceList) {
        for (var presence in presenceList) {
          final scanInDay = presence['scanInDay'];

          if (scanInDay.length > 2) {
            scanInDay.removeRange(1, scanInDay.length - 1);
          }
        }
      });

      groupedData.value = groupedMap.entries
          .map((entry) => {
                'pin': entry.key,
                'presence': entry.value,
              })
          .toList();

      List<PresensiKepgModel> presenceData = groupedData.value
          .map((entry) => PresensiKepgModel(
              pin: entry['pin'],
              presence: (entry['presence'] as List<dynamic>)
                  .map((item) => PresenceModel(
                      date: item['date'],
                      scanInDay: (item['scanInDay'] as List<dynamic>)
                          .map((scanItem) => ScanInDayModel(
                              scan: DateTime.parse(scanItem['scan'])))
                          .toList()))
                  .toList()))
          .toList();

      // if (kDebugMode) {
      //   print("data sudah dimasukkan ke dalam model gaes");

      //   exportData(presenceData);
      // }

      final stopwatch = Stopwatch()..start();

      for (var data in presenceData) {
        final presence = data.presence;
        final pin = data.pin;

        final kepegQuerySnapshot =
            await firestore.collection('Kepegawaian').doc(pin).get();

        final KepegawaianModel kepgData =
            KepegawaianModel.fromSnapshot(kepegQuerySnapshot);

        final jamKerjaQuerySnapshot = await firestore
            .collection('JamKerja')
            .where('kepegawaian', isEqualTo: kepgData.kepegawaian)
            .get();

        List<JamKerjaModel2> jamKerjaList = jamKerjaQuerySnapshot.docs
            .map((doc) => JamKerjaModel2.fromJson(doc))
            .toList();

        final pengecualianTahunPresensiQuerySnapshot = await firestore
            .collection('Pengecualian')
            .where('statusPengecualian', isEqualTo: 'Bukan')
            .get();

        List<PengecualianModel> pengecualianList =
            pengecualianTahunPresensiQuerySnapshot.docs
                .map((doc) => PengecualianModel.fromJson(doc))
                .toList();

        // final hariLiburQuerySnapshot = await firestore
        //     .collection('Holiday')
        //     .orderBy('date', descending: true)
        //     .get();

        // List<HolidayModel> hariLiburList = hariLiburQuerySnapshot.docs
        //     .map((doc) => HolidayModel.fromJson(doc))
        //     .toList();

        for (var presenceData in presence!) {
          final scanInDay = presenceData.scanInDay;

          for (var scanInDayData in scanInDay!) {
            final scan = scanInDayData.scan!;

            var formatterDoc = DateFormat('d MMMM yyyy', 'id-ID');
            var hari = DateFormat.EEEE('id_ID').format(scan);

            var datePresensi =
                formatterDoc.format(DateTime.parse(scan.toIso8601String()));

            bool isPengecualian = false;
            // for (var libur in hariLiburList) {
            //   var liburan = DateTime.parse(libur.date!);
            //   if (scan != liburan) {

            //   }
            // }
            for (var pengecualian in pengecualianList) {
              if (scan.isAfter(pengecualian.dateStart!) &&
                  scan.isBefore(pengecualian.dateEnd!) &&
                  kepgData.kepegawaian == 'PNS') {
                // Jika tanggal presensi berada dalam rentang pengecualian
                // Lakukan pengecekan sesuai data jam kerja
                isPengecualian = true;

                for (var jamKerja in jamKerjaList) {
                  if (jamKerja.hariKerja == hari &&
                      jamKerja.nama!
                          .toUpperCase()
                          .contains(ramadhanUpperCase) &&
                      jamKerja.kepg == 'PNS') {
                    final scanMinutes = scan.hour * 60 + scan.minute;

                    final batasAwalMasukMinutes =
                        jamKerja.batasAwalMasuk!.hour * 60 +
                            jamKerja.batasAwalMasuk!.minute;
                    final batasAkhirMasukMinutes =
                        jamKerja.batasAkhirMasuk!.hour * 60 +
                            jamKerja.batasAkhirMasuk!.minute;
                    final batasAwalKeluarMinutes =
                        jamKerja.batasAwalKeluar!.hour * 60 +
                            jamKerja.batasAwalKeluar!.minute;
                    final batasAkhirKeluarMinutes =
                        jamKerja.batasAkhirKeluar!.hour * 60 +
                            jamKerja.batasAkhirKeluar!.minute;

                    var isMasuk = (scanMinutes >= batasAwalMasukMinutes &&
                        scanMinutes <= batasAkhirMasukMinutes);

                    var isKeluar = scanMinutes >= batasAwalKeluarMinutes &&
                        scanMinutes <= batasAkhirKeluarMinutes;

                    var doc = ''.obs;
                    if (isMasuk) {
                      doc.value = '$datePresensi Masuk';
                    } else if (isKeluar) {
                      doc.value = '$datePresensi Keluar';
                    } else {
                      doc.value = '$datePresensi Tanpa Keterangan';
                    }

                    var status = ''.obs;
                    if (isMasuk) {
                      status.value = 'Masuk';
                    } else if (isKeluar) {
                      status.value = 'Keluar';
                    } else {
                      status.value = 'Tanpa Keterangan';
                    }

                    var dateTime = ''.obs;
                    if (isMasuk) {
                      dateTime.value = scan.toIso8601String();
                    } else if (isKeluar) {
                      dateTime.value = scan.toIso8601String();
                    } else {
                      dateTime.value = scan.toIso8601String();
                    }

                    final scanlogPegawai = firestore
                        .collection('Kepegawaian')
                        .doc(pin)
                        .collection('Presensi')
                        .doc(
                          doc.value,
                        );

                    if (pin != null) {
                      await scanlogPegawai.set({
                        'pin': pin,
                        'date_time': dateTime.value,
                        'status': status.value
                      });
                    }
                    break;
                  }
                }
                break;
              }
              if (scan.isAfter(pengecualian.dateStart!) &&
                  scan.isBefore(pengecualian.dateEnd!) &&
                  kepgData.kepegawaian == 'NON-PNS') {
                // Jika tanggal presensi berada dalam rentang pengecualian
                // Lakukan pengecekan sesuai data jam kerja
                isPengecualian = true;

                for (var jamKerja in jamKerjaList) {
                  if (jamKerja.hariKerja == hari &&
                      jamKerja.nama!
                          .toUpperCase()
                          .contains(ramadhanUpperCase) &&
                      jamKerja.kepg == 'NON-PNS') {
                    final scanMinutes = scan.hour * 60 + scan.minute;

                    final batasAwalMasukMinutes =
                        jamKerja.batasAwalMasuk!.hour * 60 +
                            jamKerja.batasAwalMasuk!.minute;
                    final batasAkhirMasukMinutes =
                        jamKerja.batasAkhirMasuk!.hour * 60 +
                            jamKerja.batasAkhirMasuk!.minute;
                    final batasAwalKeluarMinutes =
                        jamKerja.batasAwalKeluar!.hour * 60 +
                            jamKerja.batasAwalKeluar!.minute;
                    final batasAkhirKeluarMinutes =
                        jamKerja.batasAkhirKeluar!.hour * 60 +
                            jamKerja.batasAkhirKeluar!.minute;

                    var isMasuk = (scanMinutes >= batasAwalMasukMinutes &&
                        scanMinutes <= batasAkhirMasukMinutes);

                    var isKeluar = scanMinutes >= batasAwalKeluarMinutes &&
                        scanMinutes <= batasAkhirKeluarMinutes;

                    var doc = ''.obs;
                    if (isMasuk) {
                      doc.value = '$datePresensi Masuk';
                    } else if (isKeluar) {
                      doc.value = '$datePresensi Keluar';
                    } else {
                      doc.value = '$datePresensi Tanpa Keterangan';
                    }

                    var status = ''.obs;
                    if (isMasuk) {
                      status.value = 'Masuk';
                    } else if (isKeluar) {
                      status.value = 'Keluar';
                    } else {
                      status.value = 'Tanpa Keterangan';
                    }

                    var dateTime = ''.obs;
                    if (isMasuk) {
                      dateTime.value = scan.toIso8601String();
                    } else if (isKeluar) {
                      dateTime.value = scan.toIso8601String();
                    } else {
                      dateTime.value = scan.toIso8601String();
                    }

                    final scanlogPegawai = firestore
                        .collection('Kepegawaian')
                        .doc(pin)
                        .collection('Presensi')
                        .doc(
                          doc.value,
                        );

                    if (pin != null) {
                      await scanlogPegawai.set({
                        'pin': pin,
                        'date_time': dateTime.value,
                        'status': status.value
                      });
                    }
                    break;
                  }
                }
                break;
              }
            }
            if (!isPengecualian) {
              // Tidak ada pengecualian, lakukan pengecekan sesuai data jam kerja
              for (var jamKerja in jamKerjaList) {
                if (jamKerja.hariKerja == hari) {
                  final scanMinutes = scan.hour * 60 + scan.minute;

                  final batasAwalMasukMinutes =
                      jamKerja.batasAwalMasuk!.hour * 60 +
                          jamKerja.batasAwalMasuk!.minute;
                  final batasAkhirMasukMinutes =
                      jamKerja.batasAkhirMasuk!.hour * 60 +
                          jamKerja.batasAkhirMasuk!.minute;
                  final batasAwalKeluarMinutes =
                      jamKerja.batasAwalKeluar!.hour * 60 +
                          jamKerja.batasAwalKeluar!.minute;
                  final batasAkhirKeluarMinutes =
                      jamKerja.batasAkhirKeluar!.hour * 60 +
                          jamKerja.batasAkhirKeluar!.minute;

                  var isMasuk = (scanMinutes >= batasAwalMasukMinutes &&
                      scanMinutes <= batasAkhirMasukMinutes);

                  var isKeluar = scanMinutes >= batasAwalKeluarMinutes &&
                      scanMinutes <= batasAkhirKeluarMinutes;

                  var doc = ''.obs;
                  if (isMasuk) {
                    doc.value = '$datePresensi Masuk';
                  } else if (isKeluar) {
                    doc.value = '$datePresensi Keluar';
                  } else {
                    doc.value = '$datePresensi Tanpa Keterangan';
                  }

                  var status = ''.obs;
                  if (isMasuk) {
                    status.value = 'Masuk';
                  } else if (isKeluar) {
                    status.value = 'Keluar';
                  } else {
                    status.value = 'Tanpa Keterangan';
                  }

                  var dateTime = ''.obs;
                  if (isMasuk) {
                    dateTime.value = scan.toIso8601String();
                  } else if (isKeluar) {
                    dateTime.value = scan.toIso8601String();
                  } else {
                    dateTime.value = scan.toIso8601String();
                  }

                  final scanlogPegawai = firestore
                      .collection('Kepegawaian')
                      .doc(pin)
                      .collection('Presensi')
                      .doc(
                        doc.value,
                      );

                  if (pin != null) {
                    await scanlogPegawai.set({
                      'pin': pin,
                      'date_time': dateTime.value,
                      'status': status.value
                    });
                  }
                  break;
                }
              }
            }

            // PENGECEKAN HARDCODE
            // var isMasuk = scan.hour >= 6 && scan.hour <= 9;
            // var isKeluar = scan.hour >= 9 && scan.hour <= 17;

            // var doc = ''.obs;
            // if (isMasuk) {
            //   doc.value = '$datePresensi Masuk';
            // } else if (isKeluar) {
            //   doc.value = '$datePresensi Keluar';
            // } else {
            //   doc.value = '$datePresensi Tanpa Keterangan';
            // }

            // var status = ''.obs;
            // if (isMasuk) {
            //   status.value = 'Masuk';
            // } else if (isKeluar) {
            //   status.value = 'Keluar';
            // } else {
            //   status.value = 'Tanpa Keterangan';
            // }

            // var dateTime = ''.obs;
            // if (isMasuk) {
            //   dateTime.value = scan.toIso8601String();
            // } else if (isKeluar) {
            //   dateTime.value = scan.toIso8601String();
            // } else {
            //   dateTime.value = scan.toIso8601String();
            // }

            // final scanlogPegawai = firestore
            //     .collection('Kepegawaian')
            //     .doc(pin)
            //     .collection('Presensi')
            //     .doc(
            //       doc.value,
            //     );

            // if (pin != null) {
            //   await scanlogPegawai.set({
            //     'pin': pin,
            //     'date_time': dateTime.value,
            //     'status': status.value
            //   });
            // }

            if (kDebugMode) {
              print("perulangan ke berapa huhu}");
            }
          }
        }
      }

      isLoading.value = false;

      fcmC.sendNotificationToAllUser(titleNotif, messageNotif);

      Get.back();
      showFinishDialog();

      stopwatch.stop();
      if (kDebugMode) {
        print('Waktu sinkron data mesin -> firebase : ${stopwatch.elapsed}');
        print('Sinkron Data Mesin -> Firebase : Selesai');
      }
    } catch (e) {
      Get.back();
      if (e is DioError) {
        if (kDebugMode) {
          print(e);
        }
        Get.dialog(dialogAlertOnlyAnimation(
            'assets/lootie/warning.json',
            "Terjadi Kesalahan.",
            "Tidak dapat tersambung dengan mesin.",
            getTextAlert(context),
            getTextAlertSub(context)));
      }
      if (kDebugMode) {
        print(e);
        Get.dialog(dialogAlertOnlyAnimation(
            'assets/lootie/warning.json',
            "Terjadi Kesalahan.",
            "$e",
            getTextAlert(context),
            getTextAlertSub(context)));
      }
    }
  }

  void exportData(List dataList) {
    final content = jsonEncode(dataList);

    final bytes = utf8.encode(content);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'data.txt';

    html.document.body!.children.add(anchor);
    anchor.click();

    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
