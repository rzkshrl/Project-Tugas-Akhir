import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../../../utils/textfield.dart';
import '../controllers/lupa_sandi_mobile_controller.dart';

class LupaSandiMobileView extends GetView<LupaSandiMobileController> {
  const LupaSandiMobileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());
    return Scaffold(
        backgroundColor: light,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 8.h,
              ),
              Center(
                child: Image.asset(
                  'assets/assets/logo_splash.png',
                  width: 225,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: 3.5.h,
              ),
              textformNormalMobile(
                  context,
                  textC.emailMobileResetPassKey.value,
                  textC.emailMobileResetPassC,
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
                    if (textC.emailMobileResetPassKey.value.currentState!
                        .validate()) {
                      authC.lupaSandi(
                          textC.emailMobileResetPassC.text, context);
                    }
                  },
                  child: Text(
                    'Kirim',
                    style: getTextLoginBtnActiveMobile(context),
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed(Routes.LOGIN_MOBILE);
                },
                child: Text('Tidak Lupa Sandi? Masuk',
                    style: getTextLupaSandiMobile(context)),
              ),
            ],
          ),
        ));
  }
}
