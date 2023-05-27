import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_mobile_controller.dart';

class ProfileMobileView extends GetView<ProfileMobileController> {
  const ProfileMobileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileMobileView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProfileMobileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
