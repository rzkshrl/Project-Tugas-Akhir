import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/utils/textfield.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../controllers/lupa_sandi_controller.dart';

class LupaSandiView extends GetView<LupaSandiController> {
  LupaSandiView({Key? key}) : super(key: key);
  final authC = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    // LOGIN ADMIN WEB
    if (kIsWeb) {
      return Scaffold(
        backgroundColor: light,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    "Reset Sandi ",
                    style: getTextLogin(context),
                  ),
                  Text("Admin", style: getTextAdmin(context))
                ],
              )),
              SizedBox(
                height: 1.5.h,
              ),
              Text(
                "Verifikasi Reset Sandi akan dikirimkan ke inbox email",
                style: getText10ptBlue(context),
              ),
              SizedBox(
                height: 3.h,
              ),
              textformNormalWeb(
                  context,
                  textC.emailWebResetPassKey.value,
                  textC.emailWebResetPassC,
                  textC.emailValidator,
                  null,
                  TextInputType.emailAddress,
                  IconlyLight.message,
                  Blue1,
                  "Email",
                  light,
                  dark,
                  Blue1),
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
                    if (textC.emailWebResetPassKey.value.currentState!
                        .validate()) {
                      authC.lupaSandi(textC.emailWebResetPassC.text, context);
                    }
                  },
                  child: Text(
                    'Kirim',
                    style: getTextLoginBtnActive(context),
                  ),
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              TextButton(
                onPressed: () {
                  Get.offAllNamed(Routes.LOGIN);
                },
                child: Text('Tidak lupa kata sandi? Masuk?',
                    style: getTextLupaSandi(context)),
              ),
              SizedBox(
                height: 4.h,
              ),
            ],
          ),
        ),
      );
    } else {
      // WELCOME SCREEN MOBILE
      return Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text(
            'HALO Ini MOBILE',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }
  }
}
