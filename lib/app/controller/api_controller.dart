// ignore_for_file: unnecessary_brace_in_string_interps, use_build_context_synchronously, unnecessary_overrides, invalid_use_of_protected_member

import 'dart:convert';
import 'package:project_tugas_akhir/app/data/models/firestorejamkerjamodel.dart';
import 'package:universal_html/html.dart' as html;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/data/models/allscanlogmodel.dart';
import 'package:project_tugas_akhir/app/data/models/deviceinfomodel.dart';

import '../data/models/devicemodel.dart';
import '../data/models/firestorescanlogmodel.dart';
import '../theme/textstyle.dart';
import '../utils/dialogDefault.dart';
import '../utils/stringGlobal.dart';
import '../utils/urlHTTP.dart';

import 'dart:async';

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
  var presensiList = [].obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
        final liburCol = firestore.collection('Holiday').doc(liburDate);
        final checkData = await liburCol.get();
        if (checkData.exists == false) {
          await liburCol.set({
            'name': libur.holidayName,
            'date': liburDate,
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
        Get.dialog(dialogAlertOnly(
            IconlyLight.danger,
            "Terjadi Kesalahan.",
            "Tidak dapat tersambung dengan internet.",
            getTextAlert(Get.context!),
            getTextAlertSub(Get.context!)));
      }
      if (kDebugMode) {
        print(e);
        Get.dialog(dialogAlertOnly(IconlyLight.danger, "Terjadi Kesalahan.",
            "$e", getTextAlert(Get.context!), getTextAlertSub(Get.context!)));
      }
    }
  }

  Future<void> getDeviceInfo(BuildContext context) async {
    isLoading.value = true;
    CollectionReference users = firestore.collection("Device");
    final devices = await users.doc('mesin-1').get();
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

      var res = await Future.wait([dio.post(urlGet)]);

      if (kDebugMode) {
        print('HASIL DEVINFO : ${res[0].data['Result']}');
        // print('BODY : ${res[0].data['DEVINFO']}');
      }

      if (res[0].data['Result'] == 'false') {
        Get.dialog(dialogAlertOnly(
            IconlyLight.danger,
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

        Get.back();
        showFinishDialog();
      }
    } catch (e) {
      Get.back();
      if (e is DioError) {
        if (kDebugMode) {
          print(e);
        }
        Get.dialog(dialogAlertOnly(
            IconlyLight.danger,
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
      Get.dialog(dialogAlertOnly(
          IconlyLight.danger,
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

    CollectionReference users = firestore.collection("Device");
    final devices = await users.doc('mesin-1').get();
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

    final String url = "http://$ip:$port$urlGetScanlogWithPaging?sn=${sn}";
    final List<dynamic> res = [];
    int pageNumber = 0;

    try {
      showLoadingDialog();

      getDeviceInfo2(ip, port, sn, allPresensi, newPresensi);

      while (true) {
        var response =
            await Future.wait([dio.post('$url&page=$pageNumber&limit=100')]);
        final data = response[0].data['Data'];

        res.addAll(data);

        if (data.length < 100) {
          break;
        }

        pageNumber++;
      }
      if (kDebugMode) {
        print('Jumlah Data Response API : ${res.length}');
      }

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

      if (kDebugMode) {
        exportData(groupedData.value);
      }

      RxList<PresensiKepgModel> presenceData = <PresensiKepgModel>[].obs;

      List<PresensiKepgModel> presenceModels = [];

      groupedMap.forEach((pin, presenceList) {
        List<PresenceModel> presenceDates = [];

        for (var presence in presenceList) {
          List<ScanInDayModel> scans = [];

          presence['scanInDay'].forEach((scan) {
            scans.add(ScanInDayModel(scan: DateTime.parse(scan['scan'])));
          });

          presenceDates.add(PresenceModel(
            date: presence['date'],
            scanInDay: scans,
          ));
        }

        presenceModels.add(PresensiKepgModel(
          pin: pin,
          presence: presenceDates,
        ));
      });

      presenceData.value = presenceModels;

      final stopwatch = Stopwatch()..start();

      for (var data in presenceData) {
        final pin = data.pin;
        final presence = data.presence;

        final kepegQuerySnapshot = await firestore
            .collection('Kepegawaian')
            .where('pin', isEqualTo: pin)
            .get();

        final jamKerjaQuerySnapshot = await firestore
            .collection('JamKerja')
            .where('kepegawaian', isEqualTo: kepgData.value.kepegawaian)
            .get();

        if (kepegQuerySnapshot.size > 0) {
          DocumentSnapshot documentSnapshot = kepegQuerySnapshot.docs[0];
          kepgData.value = KepegawaianModel.fromSnapshot(documentSnapshot);
        }

        if (jamKerjaQuerySnapshot.size > 0) {
          DocumentSnapshot documentSnapshot = jamKerjaQuerySnapshot.docs[0];
          jamKerjaData.value = JamKerjaModel.fromJson(documentSnapshot);
        }

        for (var presenceData in presence!) {
          // final date = presenceData.date!;
          final scanInDay = presenceData.scanInDay;

          for (var scanInDayData in scanInDay!) {
            final scan = scanInDayData.scan!;
            var formatterDoc = DateFormat('d MMMM yyyy', 'id-ID');
            var datePresensi =
                formatterDoc.format(DateTime.parse(scan.toIso8601String()));
            final hour = scan.hour;

            final jamKerja = jamKerjaData.value;

            bool isMasuk =
                hour >= int.parse(jamKerja.batasAwalMasuk!.split(':')[0]) &&
                    hour <= int.parse(jamKerja.batasAkhirMasuk!.split(':')[0]);

            bool isKeluar =
                hour >= int.parse(jamKerja.batasAwalKeluar!.split(':')[0]) &&
                    hour <= int.parse(jamKerja.batasAkhirKeluar!.split(':')[0]);

            String doc = '';
            if (isMasuk) {
              doc = '$datePresensi Masuk';
            } else if (isKeluar) {
              doc = '$datePresensi Keluar';
            } else {
              doc = datePresensi;
            }

            String status = '';
            if (isMasuk) {
              status = 'Masuk';
            } else if (isKeluar) {
              status = 'Keluar';
            } else {
              status = 'Tanpa Keterangan';
            }

            String dateTime = '';
            if (isMasuk || isKeluar) {
              dateTime = scan.toIso8601String();
            } else {
              dateTime = '';
            }

            final scanlogPegawai = firestore
                .collection('Kepegawaian')
                .doc(pin)
                .collection('Presensi')
                .doc(
                  doc,
                );
            final checkData = await scanlogPegawai.get();
            if (pin != null) {
              // if (checkData.exists == false) {
              //   await scanlogPegawai.set({
              //     'pin': pin,
              //     'date_time': hour >= 6 && hour <= 8
              //         ? scan.toIso8601String()
              //         : hour >= 9 && hour <= 17
              //             ? scan.toIso8601String()
              //             : scan.toIso8601String(),
              //     'status': hour >= 6 && hour <= 8
              //         ? 'Masuk'
              //         : hour >= 9 && hour <= 17
              //             ? 'Keluar'
              //             : 'Tanpa Keterangan'
              //   });
              // } else {
              //   await scanlogPegawai.update({
              //     'pin': pin,
              //     'date_time': hour >= 6 && hour <= 8
              //         ? scan.toIso8601String()
              //         : hour >= 9 && hour <= 17
              //             ? scan.toIso8601String()
              //             : scan.toIso8601String(),
              //     'status': hour >= 6 && hour <= 8
              //         ? 'Masuk'
              //         : hour >= 9 && hour <= 17
              //             ? 'Keluar'
              //             : 'Tanpa Keterangan'
              //   });
              // }
              if (kepgData.value.kepegawaian == "PNS") {
                switch (scan.weekday) {
                  case DateTime.monday:
                    if (jamKerjaData.value.hariKerja == senin) {
                      if (checkData.exists == false) {
                        await scanlogPegawai.set({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      } else {
                        await scanlogPegawai.update({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      }
                    }
                    break;
                  case DateTime.tuesday:
                    if (jamKerjaData.value.hariKerja == selasa) {
                      if (checkData.exists == false) {
                        await scanlogPegawai.set({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      } else {
                        await scanlogPegawai.update({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      }
                    }
                    break;
                  case DateTime.wednesday:
                    if (jamKerjaData.value.hariKerja == rabu) {
                      if (checkData.exists == false) {
                        await scanlogPegawai.set({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      } else {
                        await scanlogPegawai.update({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      }
                    }
                    break;
                  case DateTime.thursday:
                    if (jamKerjaData.value.hariKerja == kamis) {
                      if (checkData.exists == false) {
                        await scanlogPegawai.set({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      } else {
                        await scanlogPegawai.update({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      }
                    }
                    break;
                  case DateTime.friday:
                    if (jamKerjaData.value.hariKerja == jumat) {
                      if (checkData.exists == false) {
                        await scanlogPegawai.set({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      } else {
                        await scanlogPegawai.update({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      }
                    }
                    break;
                  case DateTime.saturday:
                    if (jamKerjaData.value.hariKerja == sabtu) {
                      if (checkData.exists == false) {
                        await scanlogPegawai.set({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      } else {
                        await scanlogPegawai.update({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      }
                    }
                    break;
                  default:
                    null;
                }
              } else if (kepgData.value.kepegawaian == "NON-PNS") {
                switch (scan.weekday) {
                  case DateTime.monday:
                    if (jamKerjaData.value.hariKerja == senin) {
                      if (checkData.exists == false) {
                        await scanlogPegawai.set({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      } else {
                        await scanlogPegawai.update({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      }
                    }
                    break;
                  case DateTime.tuesday:
                    if (jamKerjaData.value.hariKerja == selasa) {
                      if (checkData.exists == false) {
                        await scanlogPegawai.set({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      } else {
                        await scanlogPegawai.update({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      }
                    }
                    break;
                  case DateTime.wednesday:
                    if (jamKerjaData.value.hariKerja == rabu) {
                      if (checkData.exists == false) {
                        await scanlogPegawai.set({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      } else {
                        await scanlogPegawai.update({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      }
                    }
                    break;
                  case DateTime.thursday:
                    if (jamKerjaData.value.hariKerja == kamis) {
                      if (checkData.exists == false) {
                        await scanlogPegawai.set({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      } else {
                        await scanlogPegawai.update({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      }
                    }
                    break;
                  case DateTime.friday:
                    if (jamKerjaData.value.hariKerja == jumat) {
                      if (checkData.exists == false) {
                        await scanlogPegawai.set({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      } else {
                        await scanlogPegawai.update({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      }
                    }
                    break;
                  case DateTime.saturday:
                    if (jamKerjaData.value.hariKerja == sabtu) {
                      if (checkData.exists == false) {
                        await scanlogPegawai.set({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      } else {
                        await scanlogPegawai.update({
                          'pin': pin,
                          'date_time': dateTime,
                          'status': status
                        });
                      }
                    }
                    break;
                  default:
                    null;
                }
              }
            }
          }
        }
      }

      isLoading.value = false;

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
        Get.dialog(dialogAlertOnly(
            IconlyLight.danger,
            "Terjadi Kesalahan.",
            "Tidak dapat tersambung dengan mesin.",
            getTextAlert(context),
            getTextAlertSub(context)));
      }
      if (kDebugMode) {
        print(e);
        Get.dialog(dialogAlertOnly(IconlyLight.danger, "Terjadi Kesalahan.",
            "$e", getTextAlert(context), getTextAlertSub(context)));
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
