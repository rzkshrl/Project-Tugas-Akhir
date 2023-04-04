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

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> getDeviceInfo(BuildContext context) async {
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

    try {
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
        }
      }
    } catch (e) {
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

    if (allScanlogList.isNotEmpty) {
      null;
    } else {
      final String url = "http://$ip:$port$urlGetScanlogWithPaging?sn=${sn}";
      final List<dynamic> res = [];
      int pageNumber = 0;

      final DateFormat formatter = DateFormat('yyyy-MM-dd');

      try {
        while (true) {
          var response = await Future.wait(
              [dio.post(url + '&page=$pageNumber&limit=100')]);
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
          print('JUMLAH DATA MODEL : ${allScanlogList.length}');
        }

        // final Map<String, List<dynamic>> groupedByPin = {};

        // for (final item in res) {
        //   final pin = item['PIN'];
        //   if (!groupedByPin.containsKey(pin)) {
        //     groupedByPin[pin] = [];
        //   }
        //   groupedByPin[pin]!.add(item);
        // }

        // res.sort((a, b) => DateTime.parse(a['ScanDate'])
        //     .compareTo(DateTime.parse(b['ScanDate'])));
        // final DateTime firstDate = allScanlogList.first.scanDate!;
        // if (kDebugMode) {
        //   print('firstDate : ${firstDate}');
        // }
        // final DateTime lastDate = allScanlogList.last.scanDate!;
        // if (kDebugMode) {
        //   print('lastDate : ${lastDate}');
        // }

        // final List<DateTime> allDates = List.generate(
        //   lastDate.difference(firstDate).inDays + 1,
        //   (i) => firstDate.add(Duration(days: i)),
        // );

        // final Iterable<Map<String, dynamic>> presensiByDate = allDates
        //     .map((date) {
        //       final presensiForDate = res
        //           .where((data) =>
        //               DateTime.parse(data['ScanDate']).isAtSameMomentAs(date))
        //           .toList();
        //       return presensiForDate.isNotEmpty
        //           ? presensiForDate[0]
        //           : {'ScanDate': date.toString()};
        //     })
        //     .toList()
        //     .cast<Map<String, dynamic>>();

        // allScanlogList = List.from(presensiByDate)
        //     .map((e) => AllScanlogModel.fromJson(e))
        //     .toList();

        // if (kDebugMode) {
        //   print('JUMLAH DATA MODEL : ${allScanlogList.length}');
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
            final scanlogPegawai = firestore
                .collection('Kepegawaian')
                .doc(scanlog.pin)
                .collection('Presensi')
                .doc(datePresensi);
            final checkData = await scanlogPegawai.get();
            if (!checkData.exists) {
              final hour = scanlog.scanDate!.hour;
              if (scanlog.pin != null) {
                await scanlogPegawai.set({
                  'pin': scanlog.pin,
                  'date': scanlog.scanDate!.toIso8601String(),
                  'masuk': hour >= 6 && hour <= 9
                      ? Timestamp.fromDate(scanlog.scanDate!)
                      : '',
                  'keluar': hour >= 9 && hour <= 16
                      ? Timestamp.fromDate(scanlog.scanDate!)
                      : '',
                  'keterangan': hour >= 6 && hour <= 8
                      ? 'Hadir'
                      : hour >= 9 && hour <= 16
                          ? 'Hadir'
                          : 'Tanpa Keterangan'
                });
              }
            } else {
              final hour = scanlog.scanDate!.hour;
              if (scanlog.pin != null) {
                await scanlogPegawai.update({
                  'pin': scanlog.pin,
                  'date': scanlog.scanDate!.toIso8601String(),
                  'masuk': hour >= 6 && hour <= 9
                      ? Timestamp.fromDate(scanlog.scanDate!)
                      : '',
                  'keluar': hour >= 9 && hour <= 16
                      ? Timestamp.fromDate(scanlog.scanDate!)
                      : '',
                  'keterangan': hour >= 6 && hour <= 8
                      ? 'Hadir'
                      : hour >= 9 && hour <= 16
                          ? 'Hadir'
                          : 'Tanpa Keterangan'
                });
              }
            }
          }
        }

        final DateFormat formatter = DateFormat('d MMMM yyyy', 'id-ID');

        final List<String> allPins =
            List.from(res).map((e) => e['PIN'].toString()).toList();

        List<String> listPin = [];

        for (var scanlog in allScanlogList) {
          if (!listPin.contains(scanlog.pin)) {
            listPin.add(scanlog.pin!);
          }
        }

        for (var pin in listPin) {
          // Mengambil data presensi dari Firestore
          final firestoreData = await firestore
              .collection('Kepegawaian')
              .doc(pin)
              .collection('Presensi')
              .get();

          // Mengubah data Firestore menjadi List<DateTime>
          final List<DateTime> existingDates =
              firestoreData.docs.map((doc) => formatter.parse(doc.id)).toList();

          // Memeriksa setiap tanggal dalam data presensi dari API
          for (var data in res) {
            final DateTime date = DateTime.parse(data['ScanDate']);
            final String dateStr = formatter.format(date);

            // Jika tanggal tidak ada dalam data presensi dari Firestore, maka tambahkan data presensi kosong ke Firestore
            if (!existingDates.contains(date)) {
              final scanlogPegawai = firestore
                  .collection('Kepegawaian')
                  .doc(pin)
                  .collection('Presensi')
                  .doc(dateStr);
              await scanlogPegawai.set({
                'pin': pin,
                'date': date.toIso8601String(),
                'masuk': '',
                'keluar': '',
                'keterangan': 'Tanpa Keterangan'
              });
            }
          }
        }

        stopwatch.stop();
        if (kDebugMode) {
          print('Waktu sinkron data mesin -> firebase : ${stopwatch.elapsed}');
        }

        if (kDebugMode) {
          print('Sinkron Data Mesin -> Firebase : Selesai');
        }
      } catch (e) {
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

  // Future<void> getFirestorePresenceData(BuildContext context) async {
  //   try {
  //     firestoreScanlogList = firestore
  //         .collection('Kepegawaian')
  //         .snapshots()
  //         .map((snap) => snap.docs
  //             .map((doc) => KepegawaianModel.fromSnapshot(doc))
  //             .toList());
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //     Get.dialog(dialogAlertOnly(IconlyLight.danger, "Terjadi Kesalahan.", "$e",
  //         getTextAlert(context), getTextAlertSub(context)));
  //   }
  // }

  // @override
  // void onInit() {
  //   super.onInit();
  //   getDeviceInfo(context1);
  // }
}
