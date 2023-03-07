import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mesin_controller.dart';

class MesinView extends GetView<MesinController> {
  const MesinView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MesinView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'MesinView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
