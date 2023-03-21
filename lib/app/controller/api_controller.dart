import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/data/models/allscanlogmodel.dart';
import 'package:project_tugas_akhir/app/data/models/deviceinfomodel.dart';

import '../data/models/devicemodel.dart';
import '../data/models/listallscanlogmodel.dart';
import '../theme/textstyle.dart';
import '../utils/dialogDefault.dart';
import '../utils/urlHTTP.dart';

import 'dart:async';

class APIController extends GetxController {
  final _connect = GetConnect();

  final client = http.Client();

  late BuildContext context1;

  APIController({required this.context1});

  final dio = Dio();

  var isLoading = false.obs;

  var deviceData = DeviceModel().obs;
  var deviceInfo = DeviceInfoModel().obs;
  var allScanlog = <AllScanlogModel>[].obs;

  var listAllScanlog = ListAllScanlogModel().obs;

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

    print(ip);
    print(sn);
    print(port);

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
        firestore
            .collection('Device')
            .doc("mesin-1")
            .update({'allPresensi': deviceInfo.value.allPresensi});
      }
    } catch (e) {
      if (e is DioError) {
        Get.dialog(dialogAlertOnly(
            IconlyLight.danger,
            "Terjadi Kesalahan.",
            "Tidak dapat tersambung dengan mesin.",
            getTextAlert(context),
            getTextAlertSub(context)));
      }
    }
  }

  // void repeatGetAllPresenceData() {
  //   var period = const Duration(seconds: 1);
  //   Timer.periodic(period, (arg) {
  //     getAllPresenceData(context1);
  //   });
  // }

  Future<void> getAllPresenceData(BuildContext context) async {
    CollectionReference users = firestore.collection("Device");
    final devices = await users.doc('mesin-1').get();
    final deviceDataDB = devices.data() as Map<String, dynamic>;

    deviceData(DeviceModel(
      deviceSn: deviceDataDB['device_sn'],
      serverIp: deviceDataDB['server_ip'],
      serverPort: deviceDataDB['server_port'],
      allPresensi: deviceDataDB['allPresensi'],
    ));

    deviceData.refresh();

    var sn = deviceData.value.deviceSn;
    var ip = deviceData.value.serverIp;
    var port = deviceData.value.serverPort;
    var allPresensi = deviceData.value.allPresensi;

    print(ip);
    print(sn);
    print(port);
    print(allPresensi);

    try {
      String urlGet = "http://$ip:$port$urlGetScanlogWithPaging?sn=${sn}";

      var res = await Future.wait([dio.post(urlGet)]);

      if (kDebugMode) {
        print('HASIL : ${res[0].data['Result']}');
        print('BODY : ${res[0].data['Data'][0]['ScanDate']}');
      }

      if (res[0].data['Result'] == 'false') {
        Get.dialog(dialogAlertOnly(
            IconlyLight.danger,
            "Terjadi Kesalahan.",
            "Tidak dapat mengambil data dari mesin.",
            getTextAlert(context),
            getTextAlertSub(context)));
      } else {
        var data1 = res[0].data['Data'];

        allScanlogList =
            List.from(data1).map((e) => AllScanlogModel.fromJson(e)).toList();

        print('JUMLAH DATA : ${allScanlogList.length}');

        // firestore.collection('Scanlog').doc().set({
        //   'pin': allScanlog.value.pin,
        //   'scanDate': allScanlog.value.scanDate,
        // });
      }
    } catch (e) {
      if (e is DioError) {
        Get.dialog(dialogAlertOnly(
            IconlyLight.danger,
            "Terjadi Kesalahan.",
            "Tidak dapat tersambung dengan mesin.",
            getTextAlert(context),
            getTextAlertSub(context)));
      }
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   getDeviceInfo(context1);
  // }
}
