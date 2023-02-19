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
                  child: Image.asset(
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
                          c.emailWebKey.value,
                          c.emailWebC,
                          const [AutofillHints.email],
                          TextInputType.emailAddress,
                          IconlyLight.message,
                          Blue1,
                          "Email"),
                      SizedBox(
                        height: 4.2.h,
                      ),
                      textformPassWeb(context, const [AutofillHints.password],
                          IconlyLight.lock, Blue1, "Kata Sandi", () {
                        TextInput.finishAutofillContext();
                      }),
                      SizedBox(
                        height: 4.h,
                      ),
                    ],
                  ),
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
                      if (c.emailWebKey.value.currentState!.validate() &&
                          c.passWebKey.value.currentState!.validate()) {
                        authC.login(c.emailWebC.text, c.passWebC.text, context);
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
        body: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/icons/logo.png',
                          width: 50.w,
                          height: 50.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Text("MonitorPresence"),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text("Pantau Presensi Anda secara Langsung"),
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                        width: 580.w,
                        height: 60.h,
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
                        height: 20.h,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.offAllNamed(Routes.LUPA_SANDI);
                        },
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
