// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/auth_controller.dart';
import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../../../utils/btnDefault.dart';
import '../../../utils/textfield.dart';
import '../controllers/ubah_sandi_mobile_controller.dart';

class UbahSandiMobileView extends GetView<UbahSandiMobileController> {
  const UbahSandiMobileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    String? profile = authC.userData.value.photoUrl;
    String? nama = authC.userData.value.name;
    var defaultImage =
        "https://ui-avatars.com/api/?name=${nama}&background=fff38a&color=5175c0&font-size=0.33&size=256";

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
              padding: EdgeInsets.only(right: 6.w),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        IconlyLight.arrow_left,
                        color: Blue1,
                        size: 25,
                      )),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ubah Sandi',
                        style: getTextHeaderWelcomeScreen(context, 16),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        'Ubah Kata Sandi Anda',
                        style: getTextSubHeaderWelcomeScreen(context, 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.5.h,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: 3.w, left: 3.w),
                child: ClipOval(
                  child: Image.network(
                    profile != null
                        ? profile != ''
                            ? profile
                            : defaultImage
                        : defaultImage,
                    width: 35.w,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 3.5.h,
            ),
            Center(
              child: textformPassMobile2(
                context,
                null,
                textC.sandiAwalUbahSandiKey.value,
                textC.sandiAwalUbahSandiC,
                null,
                IconlyLight.lock,
                Blue1,
                "Kata Sandi Lama",
              ),
            ),
            SizedBox(
              height: 2.2.h,
            ),
            Center(
              child: textformPassMobile2(
                context,
                null,
                textC.sandiBaruUbahSandiKey.value,
                textC.sandiBaruUbahSandiC,
                null,
                IconlyLight.lock,
                Blue1,
                "Kata Sandi Baru",
              ),
            ),
            SizedBox(
              height: 2.5.h,
            ),
            Center(
              child: btnMobile(Blue1, () {
                if (textC.sandiAwalUbahSandiKey.value.currentState!
                        .validate() &&
                    textC.sandiBaruUbahSandiKey.value.currentState!
                        .validate()) {
                  controller.ubahSandi(
                    textC.sandiAwalUbahSandiC.text,
                    textC.sandiBaruUbahSandiC.text,
                  );
                }
              }, "Kirim"),
            )
          ],
        ),
      ),
    );
  }
}
