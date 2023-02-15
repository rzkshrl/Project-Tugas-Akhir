import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/routes/app_pages.dart';

import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../controllers/login_controller.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    final bodyHeight = MediaQuery.of(context).size.height;
    final bodyWidth = MediaQuery.of(context).size.width;

    // LOGIN ADMIN WEB
    if (kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.linux ||
            defaultTargetPlatform == TargetPlatform.macOS ||
            defaultTargetPlatform == TargetPlatform.windows)) {
      return Scaffold(
        backgroundColor: light,
        body: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
                  // reverse: true,
                  // padding: EdgeInsets.only(
                  //   left: bodyWidth * 0.05,
                  //   right: bodyWidth * 0.05,
                  // ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: bodyHeight * 0.03,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/icons/logo.png',
                          width: 332,
                          height: 294,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Login ",
                            style: getTextLogin(context),
                          ),
                          Text("Admin", style: getTextAdmin(context))
                        ],
                      )),
                      SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: controller.emailKey.value,
                        child: Container(
                          width: 344,
                          height: 65,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            validator: controller.emailValidator,
                            controller: controller.emailC,
                            style: getTextLogin(context),
                            // onTap: () {
                            //   FocusScopeNode currentFocus =
                            //       FocusScope.of(context);

                            //   if (!currentFocus.hasPrimaryFocus) {
                            //     currentFocus.unfocus();
                            //   }

                            //   // controller.iconEmail.value =
                            //   //     !controller.iconEmail.value;
                            // },
                            // onChanged: (value) {
                            //   controller.isFormEmpty.isFalse;
                            // },
                            decoration: InputDecoration(
                                helperText: ' ',
                                helperStyle: getTextErrorFormLogin(context),
                                isDense: true,
                                contentPadding: EdgeInsets.all(20),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                    left: bodyWidth * 0.01,
                                    right: bodyWidth * 0.008,
                                  ),
                                  child: Align(
                                      widthFactor: 0.5,
                                      heightFactor: 0.5,
                                      child: Icon(
                                        IconlyLight.message,
                                        color: Blue1,
                                        size: 26,
                                      )),
                                ),
                                focusColor: Blue1,
                                fillColor: light,
                                filled: true,
                                errorStyle: getTextErrorFormLogin(context),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: errorBg, width: 1.8),
                                    borderRadius: BorderRadius.circular(12),
                                    gapPadding: 2),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: error, width: 1.8),
                                    borderRadius: BorderRadius.circular(12)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Blue1, width: 1.8),
                                    borderRadius: BorderRadius.circular(12)),
                                hintText: 'Email',
                                hintStyle: getTextHintFormLogin(context),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 1, color: dark),
                                    borderRadius: BorderRadius.circular(12))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: bodyHeight * 0.045,
                      ),
                      Form(
                        key: controller.passKey.value,
                        child: Obx(
                          () => Container(
                            width: 344,
                            height: 65,
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: getTextLogin(context),
                              // onChanged: (_) async {
                              //   controller.fixEdgePasswordRevealButton(
                              //       passwordFocusNode);
                              // },
                              // focusNode: passwordFocusNode,
                              // onTap: () {
                              //   FocusScopeNode currentFocus =
                              //       FocusScope.of(context);

                              //   if (!currentFocus.hasPrimaryFocus) {
                              //     currentFocus.unfocus();
                              //   }

                              //   // controller.iconPass.value =
                              //   //     !controller.iconPass.value;
                              // },
                              validator: controller.passValidator,
                              obscureText: controller.isPasswordHidden.value,
                              controller: controller.passC,
                              decoration: InputDecoration(
                                  helperText: ' ',
                                  helperStyle: getTextErrorFormLogin(context),
                                  isDense: true,
                                  contentPadding: EdgeInsets.all(20),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(
                                      left: bodyWidth * 0.01,
                                      right: bodyWidth * 0.008,
                                    ),
                                    child: Align(
                                        widthFactor: 0.5,
                                        heightFactor: 0.5,
                                        child: Icon(
                                          IconlyLight.lock,
                                          color: Blue1,
                                          size: 26,
                                        )),
                                  ),
                                  hintText: 'Kata Sandi',
                                  hintStyle: getTextHintFormLogin(context),
                                  fillColor: light,
                                  filled: true,
                                  errorStyle: getTextErrorFormLogin(context),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: errorBg, width: 1.8),
                                      borderRadius: BorderRadius.circular(12),
                                      gapPadding: 2),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: error, width: 1.8),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Blue1, width: 1.8),
                                      borderRadius: BorderRadius.circular(12)),
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.only(
                                      right: bodyWidth * 0.0035,
                                    ),
                                    child: IconButton(
                                      color: Blue1,
                                      splashRadius: 1,
                                      iconSize: 20,
                                      icon: Icon(
                                          controller.isPasswordHidden.value
                                              ? FontAwesomeIcons.eye
                                              : FontAwesomeIcons.eyeSlash),
                                      onPressed: () {
                                        controller.isPasswordHidden.value =
                                            !controller.isPasswordHidden.value;
                                      },
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(width: 1, color: dark),
                                      borderRadius: BorderRadius.circular(12))),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: bodyHeight * 0.04,
                      ),
                      Container(
                        width: 211,
                        height: 49,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Blue1,
                        ),
                        child: TextButton(
                          onPressed: () {
                            // if (controller.emailKey.value.currentState!
                            //         .validate() &&
                            //     controller.passKey.value.currentState!
                            //         .validate()) {
                            //   authC.login(
                            //       controller.emailC.text, controller.passC.text);
                            // }
                            Get.toNamed(Routes.RIWAYAT_PRESENSI);
                          },
                          child: Text(
                            'Masuk',
                            style: getTextLoginBtnActive(context),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: bodyHeight * 0.03,
                      ),
                      TextButton(
                        onPressed: () => Get.toNamed(Routes.LUPA_SANDI),
                        child: Text('Lupa Sandi?',
                            style: getTextLupaSandi(context)),
                      ),
                      SizedBox(
                        height: bodyHeight * 0.03,
                      ),
                    ],
                  ),
                )),
      );
    } else {
      // WELCOME SCREEN MOBILE
      return Scaffold(
        body: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: bodyHeight * 0.2,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/icons/logo.png',
                          width: bodyWidth * 0.5,
                          height: bodyWidth * 0.5,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text("MonitorPresence"),
                      SizedBox(
                        height: bodyHeight * 0.015,
                      ),
                      Text("Pantau Presensi Anda secara Langsung"),
                      SizedBox(
                        height: bodyHeight * 0.3,
                      ),
                      Container(
                        width: bodyWidth * 0.58,
                        height: bodyHeight * 0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Blue1,
                        ),
                        child: TextButton(
                          onPressed: () {
                            // if (controller.emailKey.value.currentState!
                            //         .validate() &&
                            //     controller.passKey.value.currentState!
                            //         .validate()) {
                            //   authC.login(
                            //       controller.emailC.text, controller.passC.text);
                            // }
                          },
                          child: Text(
                            'Masuk',
                            style: getTextLoginBtnActiveMobile(context),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: bodyHeight * 0.02,
                      ),
                      TextButton(
                        onPressed: () => Get.toNamed(Routes.LUPA_SANDI),
                        child: Text('Sudah punya akun? Masuk',
                            style: getTextLupaSandiMobile(context)),
                      ),
                    ],
                  ),
                )),
      );
    }
  }
}
