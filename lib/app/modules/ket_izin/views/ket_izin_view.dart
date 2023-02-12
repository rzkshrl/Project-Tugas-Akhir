import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ket_izin_controller.dart';

class KetIzinView extends GetView<KetIzinController> {
  const KetIzinView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KetIzinView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'KetIzinView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
