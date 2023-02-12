import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/jam_kerja_controller.dart';

class JamKerjaView extends GetView<JamKerjaController> {
  const JamKerjaView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JamKerjaView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'JamKerjaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
