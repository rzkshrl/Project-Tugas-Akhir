// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:monitorpresensi/app/utils/btnDefault.dart';
import 'package:monitorpresensi/app/utils/dropdownTextField.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../../../utils/textfield.dart';
import '../../profile_mobile/controllers/profile_mobile_controller.dart';
import '../controllers/ubah_profil_mobile_controller.dart';

class UbahProfilMobileView extends GetView<UbahProfilMobileController> {
  const UbahProfilMobileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final userC = Get.put(ProfileMobileController());

    return Scaffold(
        backgroundColor: light,
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: userC.userNow(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Lottie.asset('assets/lootie/loading2.json',
                        height: 135));
              }
              var data = snap.data!.data()!;
              String nama = data['name'];
              var bidang = data['bidang'];
              var profile = data['profile'];

              cDropdown.bidangUbahProfilC.text = bidang;
              // textC.namaUbahProfilC.text = nama;

              var defaultImage =
                  "https://ui-avatars.com/api/?name=${nama}&background=fff38a&color=5175c0&font-size=0.33&size=256";
              return SingleChildScrollView(
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
                                style:
                                    getTextSubHeaderWelcomeScreen(context, 15),
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
                          null,
                          [AutofillHints.name],
                          TextInputType.name,
                          IconlyLight.user,
                          Blue1,
                          "Masukkan nama pegawai...",
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
                              ? ''
                              : cDropdown.bidangUbahProfilC.text,
                          false),
                    ),
                    SizedBox(
                      height: 2.5.h,
                    ),
                    Center(
                      child: btnMobile(Blue1, () {
                        controller.ubahProfil(
                          textC.namaUbahProfilC.text,
                          cDropdown.bidangUbahProfilC.text,
                        );
                      }, "Kirim"),
                    )
                  ],
                ),
              );
            }));
  }
}
