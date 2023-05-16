import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/utils/textfield.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_pages.dart';
import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../controllers/login_mobile_controller.dart';

class LoginMobileView extends GetView<LoginMobileController> {
  const LoginMobileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: light,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 8.h,
            ),
            Center(
              child: Image.network(
                'assets/icons/logo_splash.png',
                width: 225,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 3.5.h,
            ),
            AutofillGroup(
              child: Column(
                children: [
                  textformNormalMobile(
                      context,
                      textC.emailMobileKey.value,
                      textC.emailMobileC,
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
                    height: 2.2.h,
                  ),
                  textformPassMobile(context, const [AutofillHints.password],
                      IconlyLight.lock, Blue1, "Kata Sandi", () {
                    TextInput.finishAutofillContext();
                  })
                ],
              ),
            ),
            SizedBox(
              height: 2.5.h,
            ),
            Container(
              width: 68.5.w,
              height: 6.2.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Blue1,
              ),
              child: TextButton(
                onPressed: () {
                  Get.toNamed(Routes.HOME);
                },
                child: Text(
                  'Masuk',
                  style: getTextLoginBtnActiveMobile(context),
                ),
              ),
            ),
            SizedBox(
              height: 28.h,
            ),
            TextButton(
              onPressed: () {
                Get.toNamed(Routes.LUPA_SANDI_MOBILE);
              },
              child:
                  Text('Lupa Sandi?', style: getTextLupaSandiMobile(context)),
            ),
          ],
        ),
      ),
    );
  }
}
