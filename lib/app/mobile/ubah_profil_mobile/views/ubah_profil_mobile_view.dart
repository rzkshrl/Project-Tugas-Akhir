import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../controllers/ubah_profil_mobile_controller.dart';

class UbahProfilMobileView extends GetView<UbahProfilMobileController> {
  const UbahProfilMobileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: light,
        body: SingleChildScrollView(
          padding: EdgeInsets.only(right: 6.w, left: 6.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 6.h,
              ),
              Padding(
                padding: EdgeInsets.only(right: 6.w, left: 6.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ubah Profil',
                      style: getTextHeaderWelcomeScreen(context, 16),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      'Ubah Foto dan Data Profil Anda',
                      style: getTextSubHeaderWelcomeScreen(context, 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
            ],
          ),
        ));
  }
}
