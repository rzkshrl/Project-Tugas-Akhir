import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(
          title: Text('HomeView'),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            'Ini WEB',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('HomeView'),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            'HALO Ini MOBILE',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }
  }
}
