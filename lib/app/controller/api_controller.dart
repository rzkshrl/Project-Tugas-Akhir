import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:project_tugas_akhir/app/data/models/reqresapimodel.dart';

class APIController extends GetxController {
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

  Future getDataSDK() async {
    Uri url = Uri.parse("https:192.168.8.2:5005/dev/info");
    var response = await http.get(url);

    print(response);

    // if (response.statusCode != 200) {
    //   print("GAGAL MENDAPAT DATA DARI SERVER");
    //   return null;
    // } else {
    //   print(response.body);
    //   Map<String, dynamic> data =
    //       (json.decode(response.body) as Map<String, dynamic>);
    //   return data;
    // }
  }
}
