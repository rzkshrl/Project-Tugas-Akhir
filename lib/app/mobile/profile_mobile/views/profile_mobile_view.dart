// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/routes/app_pages.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/auth_controller.dart';
import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../../../utils/dialogDefault.dart';
import '../controllers/profile_mobile_controller.dart';

class ProfileMobileView extends GetView<ProfileMobileController> {
  const ProfileMobileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());

    String? nama = authC.userData.value.name;
    String? email = authC.userData.value.email;
    String? bidang = authC.userData.value.bidang;
    String? profile = authC.userData.value.photoUrl;

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
                padding: EdgeInsets.only(right: 6.w, left: 6.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profil',
                      style: getTextHeaderWelcomeScreen(context, 16),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Text(
                      'Profil Anda',
                      style: getTextSubHeaderWelcomeScreen(context, 15),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Row(
                children: [
                  Padding(
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
                  SizedBox(
                    width: 3.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$nama',
                        style: getTextSemiHeaderWelcomeScreen(context, 15),
                      ),
                      SizedBox(
                        height: 3.3.h,
                      ),
                      Text(
                        '$bidang',
                        style: getTextSubHeaderWelcomeScreen(context, 15),
                      ),
                      Text(
                        '$email',
                        style: getTextSubHeaderWelcomeScreen(context, 15),
                      ),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Text(
                        '81214676130143321',
                        style: getTextSemiHeaderWelcomeScreen(context, 17),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 8.5.h,
              ),
              Row(
                children: [
                  Icon(
                    IconlyLight.filter,
                    size: 20,
                    color: Blue1,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    'Pengaturan Akun',
                    style: getTextSemiHeaderWelcomeScreen(context, 15),
                  )
                ],
              ),
              SizedBox(
                height: 2.5.h,
              ),
              Material(
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.UBAH_PROFIL_MOBILE);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      height: 7.5.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: Blue1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: EdgeInsets.only(right: 6.w, left: 6.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ubah Profil',
                              style:
                                  getTextSemiHeaderWelcomeScreen(context, 15),
                            ),
                            Icon(
                              IconlyLight.edit,
                              size: 30,
                              color: Blue1,
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Material(
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.UBAH_SANDI_MOBILE);
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      height: 7.5.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: Blue1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: EdgeInsets.only(right: 6.w, left: 6.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ubah Sandi',
                              style:
                                  getTextSemiHeaderWelcomeScreen(context, 15),
                            ),
                            Icon(
                              IconlyLight.lock,
                              size: 30,
                              color: Blue1,
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Material(
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () {
                    Get.dialog(dialogAlertDualBtnAnimation(() async {
                      Get.back();
                    }, () async {
                      Get.back();
                      try {
                        authC.logout();
                      } catch (e) {
                        if (kDebugMode) {
                          print(e);
                        }
                        Get.dialog(dialogAlertOnlySingleMsgAnimationMobile(
                            'assets/lootie/warning.json',
                            "Terjadi Kesalahan!.",
                            getTextAlertMobile(Get.context!)));
                      }
                    },
                        'assets/lootie/warning.json',
                        111.29,
                        'Batal',
                        111.29,
                        'OK',
                        'Peringatan!',
                        'Apakah anda yakin ingin keluar?',
                        getTextAlertMobile(Get.context!),
                        getTextAlertSubMobile(Get.context!),
                        getTextAlertBtnMobile(Get.context!),
                        getTextAlertBtn2Mobile(Get.context!)));
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      height: 7.5.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: Blue1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: EdgeInsets.only(right: 6.w, left: 6.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Keluar',
                              style:
                                  getTextSemiHeaderWelcomeScreen(context, 15),
                            ),
                            Icon(
                              IconlyLight.logout,
                              size: 30,
                              color: Blue1,
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
        ));
  }
}
