import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/data_pegawai_controller.dart';

class DataPegawaiView extends GetView<DataPegawaiController> {
  const DataPegawaiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DataPegawaiView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DataPegawaiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
