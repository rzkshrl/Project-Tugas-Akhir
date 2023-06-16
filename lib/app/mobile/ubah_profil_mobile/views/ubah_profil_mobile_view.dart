// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/utils/btnDefault.dart';
import 'package:project_tugas_akhir/app/utils/dropdownTextField.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/auth_controller.dart';
import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../../../utils/textfield.dart';
import '../controllers/ubah_profil_mobile_controller.dart';

class UbahProfilMobileView extends GetView<UbahProfilMobileController> {
  const UbahProfilMobileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());

    String? nama = authC.userData.value.name;
    String? profile = authC.userData.value.photoUrl;
    String? bidang = authC.userData.value.bidang;
    textC.namaUbahProfilC.text = nama!;
    cDropdown.bidangUbahProfilC.text = bidang!;

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
                  ],
                ),
              ),
              SizedBox(
                height: 3.5.h,
              ),
              Stack(
                children: [
                  GetBuilder<UbahProfilMobileController>(builder: (c) {
                    if (c.image != null) {
                      return Center(
                        child: ClipOval(
                          child: Image.file(
                            File(c.image!.path),
                            width: 38.5.w,
                          ),
                        ),
                      );
                    } else {
                      return Center(
                        child: ClipOval(
                          child: Image.network(
                            profile != null
                                ? profile != ''
                                    ? profile
                                    : defaultImage
                                : defaultImage,
                            width: 38.5.w,
                          ),
                        ),
                      );
                    }
                  }),
                  Positioned(
                      top: 12.5.h,
                      left: 50.w,
                      child: ClipOval(
                        child: Material(
                          color: Blue1,
                          child: IconButton(
                            onPressed: () {
                              controller.pickImage();
                            },
                            icon: Icon(
                              IconlyLight.camera,
                              color: light,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 3.5.h,
              ),
              Center(
                child: textformNormalMobile(
                    context,
                    textC.namaUbahProfilKey.value,
                    textC.namaUbahProfilC,
                    textC.normalValidator,
                    null,
                    TextInputType.name,
                    IconlyLight.user,
                    Blue1,
                    "Email",
                    light,
                    dark,
                    Blue1),
              ),
              SizedBox(
                height: 2.2.h,
              ),
              Center(
                child: dropdownNormalFieldMobile(
                    context, 68.5.w, cDropdown.bidangUbahProfilKey.value,
                    (value) {
                  if (value != null) {
                    cDropdown.bidangUbahProfilC.text = value;
                  }
                },
                    [
                      'Kepala Sekolah',
                      'Operator Sekolah',
                      'Guru Kelas',
                      'Guru Mapel'
                    ],
                    IconlyLight.user_1,
                    "Pilih Bidang Kerja Pegawai...",
                    Colors.transparent,
                    dark,
                    Blue1,
                    Blue1,
                    cDropdown.bidangUbahProfilC.text == ''
                        ? null
                        : cDropdown.bidangUbahProfilC.text),
              ),
              SizedBox(
                height: 2.5.h,
              ),
              Center(
                child: btnMobile(Blue1, () {
                  if (textC.namaUbahProfilKey.value.currentState!.validate() &&
                      cDropdown.bidangUbahProfilKey.value.currentState!
                          .validate()) {
                    controller.ubahProfil(
                      textC.namaUbahProfilC.text,
                      cDropdown.bidangUbahProfilC.text,
                    );
                  }
                }, "Kirim"),
              )
            ],
          ),
        ));
  }
}
