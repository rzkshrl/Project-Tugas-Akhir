import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project_tugas_akhir/app/data/models/reqresapimodel.dart';

import '../data/models/devicemodel.dart';

class APIController extends GetxController {
  final _connect = GetConnect();

  final client = http.Client();

  final dio = Dio();

  var deviceData = DeviceModel().obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<ReqResAPIModel?> getDataAPI() async {
    Uri url = Uri.parse("https://reqres.in/api/users/1");
    var response = await http.get(url);

    print(response.statusCode);

    if (response.statusCode != 200) {
      print("GAGAL MENDAPAT DATA DARI SERVER");
      return null;
    } else {
      print(response.body);
      Map<String, dynamic> data =
          (json.decode(response.body) as Map<String, dynamic>);
      return ReqResAPIModel.fromJson(data);
    }
  }

  void getDataSDK() async {
    CollectionReference users = firestore.collection("Device");
    final devices = await users.doc('mesin-1').get();
    final deviceDataDB = devices.data() as Map<String, dynamic>;

    deviceData(DeviceModel(
      deviceSn: deviceDataDB['device_sn'],
      serverIp: deviceDataDB['server_ip'],
      serverPort: deviceDataDB['server_port'],
    ));

    deviceData.refresh();

    var sn = deviceData.value.deviceSn;
    var ip = deviceData.value.serverIp;
    var port = deviceData.value.serverPort;

    String urlGet = "http://$ip:$port/dev/settime?sn=${sn}";

    var res = await Future.wait([dio.post(urlGet)]);

    if (kDebugMode) {
      print('${res[0].data}');
    }
  }
}
