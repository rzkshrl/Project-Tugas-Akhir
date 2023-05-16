import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/routes/app_pages.dart';
import 'package:project_tugas_akhir/app/utils/textfield.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/auth_controller.dart';
import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../../../utils/textfieldC.dart';
import '../controllers/login_controller.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final authC = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    // LOGIN ADMIN WEB
    if (kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.linux ||
            defaultTargetPlatform == TargetPlatform.macOS ||
            defaultTargetPlatform == TargetPlatform.windows)) {
      return Scaffold(
        backgroundColor: light,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 3.h,
                ),
                Center(
                  child: Image.network(
                    'assets/icons/logo.png',
                    width: 312,
                    height: 274,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 3.h,
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
                  height: 3.h,
                ),
                AutofillGroup(
                  child: Column(
                    children: [
                      textformNormalWeb(
                          context,
                          textC.emailWebKey.value,
                          textC.emailWebC,
                          textC.emailValidator,
                          const [AutofillHints.email],
                          TextInputType.emailAddress,
                          IconlyLight.message,
                          Blue1,
                          "Email",
                          light,
                          dark,
                          Blue1),
                      SizedBox(
                        height: 4.2.h,
                      ),
                      textformPassWeb(context, const [AutofillHints.password],
                          IconlyLight.lock, Blue1, "Kata Sandi", () {
                        TextInput.finishAutofillContext();
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4.h,
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
                      if (textC.emailWebKey.value.currentState!.validate() &&
                          textC.passWebKey.value.currentState!.validate()) {
                        authC.login(
                            textC.emailWebC.text, textC.passWebC.text, context);
                      }
                    },
                    child: Text(
                      'Masuk',
                      style: getTextLoginBtnActive(context),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                TextButton(
                  onPressed: () => Get.toNamed(Routes.LUPA_SANDI),
                  child: Text('Lupa Sandi?', style: getTextLupaSandi(context)),
                ),
                SizedBox(
                  height: 4.h,
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      // WELCOME SCREEN MOBILE
      return Scaffold(
          backgroundColor: light,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 25.h,
                ),
                Center(
                  child: Image.network(
                    'assets/icons/logo.png',
                    width: 255,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "MonitorPresence",
                  style: getTextHeaderWelcomeScreen(context, 16),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "Pantau Presensi Anda secara Langsung",
                  style: getTextSubHeaderWelcomeScreen(context, 15),
                ),
                SizedBox(
                  height: 28.h,
                ),
                Container(
                  width: 58.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Blue1,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.LOGIN_MOBILE);
                    },
                    child: Text(
                      'Masuk',
                      style: getTextLoginBtnActiveMobile(context),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LUPA_SANDI_MOBILE);
                  },
                  child: Text('Lupa Sandi?',
                      style: getTextLupaSandiMobile(context)),
                ),
              ],
            ),
          ));
    }
  }
}
