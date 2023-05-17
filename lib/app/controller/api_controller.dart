import 'dart:convert';
import 'package:universal_html/html.dart' as html;
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:http/http.dart' as http;
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/data/models/allscanlogmodel.dart';
import 'package:project_tugas_akhir/app/data/models/deviceinfomodel.dart';

import '../data/models/devicemodel.dart';
import '../data/models/firestorescanlogmodel.dart';
import '../theme/textstyle.dart';
import '../utils/dialogDefault.dart';
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
    print('${year}');
    final response =
        await dio.get('https://api-harilibur.vercel.app/api?year=${year}');
    try {
      showLoadingDialog();
      List<LiburModel> liburList = [];

      final List<dynamic> responseData = response.data;

      for (var data in responseData) {
        LiburModel libur = LiburModel.fromJson(data);
        liburData.add(libur);
      }

      liburData.removeWhere((e) => e.isNationalDay == false);

      for (var libur in liburData) {
        var formatter = DateFormat("yyyy-MM-dd");
        List<String> tanggal = libur.holidayDate!.split('-');
        String liburDate =
            tanggal[0] + '-' + tanggal[1] + '-' + tanggal[2].padLeft(2, '0');
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
      print("All Presensi : ${allPresensi}");
      print("New Presensi : ${newPresensi}");
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

    if (kDebugMode) {
      print("Serial Number : $sn");
      print("IP server dan Port : $ip:$port");
      print("All Presensi : ${allPresensi}");
    }

    final String url = "http://$ip:$port$urlGetScanlogWithPaging?sn=${sn}";
    final List<dynamic> res = [];
    int pageNumber = 0;

    try {
      showLoadingDialog();
      while (true) {
        var response =
            await Future.wait([dio.post(url + '&page=$pageNumber&limit=100')]);
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

      // var presensiMasukMap = Map<String, String>();
      // var presensiKeluarMap = Map<String, String>();

      // for (var presensi in allScanlogList) {
      //   var pin = presensi.pin;
      //   var scanDate = presensi.scanDate;

      //   if (!presensiMasukMap.containsKey(pin)) {
      //     presensiMasukMap[pin!] = scanDate.toString();
      //   } else if (scanDate!.isBefore(DateTime.parse(presensiMasukMap[pin]!))) {
      //     presensiMasukMap[pin!] = scanDate.toString();
      //   }

      //   if (!presensiKeluarMap.containsKey(pin)) {
      //     presensiKeluarMap[pin!] = scanDate.toString();
      //   } else if (scanDate!.isAfter(DateTime.parse(presensiKeluarMap[pin]!))) {
      //     presensiKeluarMap[pin!] = scanDate.toString();
      //   }

      //   for (var key in presensiMasukMap.keys) {
      //     var masuk = presensiMasukMap[key];
      //     var keluar = presensiKeluarMap[key];
      //     presensiList.add({'pin': key, 'masuk': masuk, 'keluar': keluar});
      //   }
      // }

      // final presensiMap = <String, Map<String, String>>{};

      // for (final data in allScanlogList) {
      //   final pin = data.pin as String;
      //   final scanDate = data.scanDate!.toIso8601String() as String;
      //   final date = scanDate.split('T')[0];
      //   final time = scanDate.split('T')[1].split('.')[0];

      //   if (!presensiMap.containsKey(date)) {
      //     presensiMap[date] = {};
      //   }

      //   if (!presensiMap[date]!.containsKey(pin)) {
      //     presensiMap[date]![pin] = '';
      //   }

      //   if (presensiMap[date]![pin] != null) {
      //     if (time.compareTo('06:00:00') >= 0 &&
      //         time.compareTo('09:00:00') <= 0) {
      //       presensiMap[date]![pin] =
      //           '${presensiMap[date]![pin]!}masuk $time, ';
      //     } else if (time.compareTo('09:00:00') >= 0 &&
      //         time.compareTo('16:00:00') <= 0) {
      //       presensiMap[date]![pin] =
      //           '${presensiMap[date]![pin]!}keluar $time, ';
      //     }
      //   }
      // }

      // final presensiList = presensiMap.entries
      //     .map((entry) => {'date': entry.key, ...entry.value})
      //     .toList();

      // // Mengirimkan data presensi ke observer
      // this.presensiList.value = presensiList;

      // List<Map<String, dynamic>> filteredData = [];
      // for (int i = 0; i < allScanlogList.length; i++) {
      //   for (int j = i + 1; j < allScanlogList.length; j++) {
      //     final hourA = allScanlogList[i].scanDate!.hour;
      //     final hourB = allScanlogList[j].scanDate!.hour;
      //     final tanggalA = formatterDate.format(allScanlogList[i].scanDate!);
      //     final jamA = hourA >= 6 && hourA <= 9
      //         ? formatterTime.format(allScanlogList[i].scanDate!)
      //         : hourA >= 9 && hourA <= 16
      //             ? formatterTime.format(allScanlogList[i].scanDate!)
      //             : null;
      //     final tanggalB = formatterDate.format(allScanlogList[j].scanDate!);
      //     final jamB = hourB >= 6 && hourB <= 9
      //         ? formatterTime.format(allScanlogList[j].scanDate!)
      //         : hourB >= 9 && hourB <= 16
      //             ? formatterTime.format(allScanlogList[j].scanDate!)
      //             : null;

      //     if (tanggalA == tanggalB && jamA != jamB) {
      //       filteredData.add({
      //         'pin': allScanlogList[i].pin,
      //         'date': tanggalA,
      //         'masuk': jamA,
      //         'keluar': jamB
      //       });
      //     }
      //   }
      // }

      exportData(allScanlogList);

      final stopwatch = Stopwatch()..start();

      for (var scanlog in allScanlogList) {
        if (allScanlogList != null) {
          var dateFormatPresensi =
              DateFormat('d MMMM yyyy - HH:mm:ss', 'id-ID');
          var formatterDoc = DateFormat('d MMMM yyyy', 'id-ID');
          var datePresensi = formatterDoc
              .format(DateTime.parse(scanlog.scanDate!.toIso8601String()));
          final hour = scanlog.scanDate!.hour;
          final scanlogPegawai = firestore
              .collection('Kepegawaian')
              .doc(scanlog.pin)
              .collection('Presensi')
              .doc(
                hour >= 6 && hour <= 9
                    ? datePresensi + ' Masuk'
                    : hour >= 9 && hour <= 16
                        ? datePresensi + ' Keluar'
                        : null,
              );
          final checkData = await scanlogPegawai.get();
          if (scanlog.pin != null) {
            if (checkData.exists == false) {
              await scanlogPegawai.set({
                'pin': scanlog.pin,
                'date_time': hour >= 6 && hour <= 9
                    ? scanlog.scanDate!.toIso8601String()
                    : hour >= 9 && hour <= 16
                        ? scanlog.scanDate!.toIso8601String()
                        : null,
                'status': hour >= 6 && hour <= 9
                    ? 'Masuk'
                    : hour >= 9 && hour <= 16
                        ? 'Keluar'
                        : 'Tanpa Keterangan'
              });
            } else {}
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
