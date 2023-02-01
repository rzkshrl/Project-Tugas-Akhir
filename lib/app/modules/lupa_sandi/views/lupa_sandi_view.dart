import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/lupa_sandi_controller.dart';

class LupaSandiView extends GetView<LupaSandiController> {
  const LupaSandiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LupaSandiView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'LupaSandiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
