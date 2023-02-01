import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/routes/app_pages.dart';

import '../../../theme/textstyle.dart';
import '../../../theme/theme.dart';
import '../controllers/login_controller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    final bodyHeight = MediaQuery.of(context).size.height;
    final bodyWidth = MediaQuery.of(context).size.width;
    // LOGIN ADMIN WEB
    if (kIsWeb) {
      return Scaffold(
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
                        height: bodyHeight * 0.15,
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
                          height: bodyHeight * 0.1,
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
                                prefixIcon: Padding(
                                  padding: EdgeInsets.only(
                                    left: bodyWidth * 0.01,
                                    right: bodyWidth * 0.006,
                                  ),
                                  child: Align(
                                      widthFactor: 1.0,
                                      heightFactor: 1.0,
                                      child: Icon(
                                        IconlyLight.message,
                                        color: Blue1,
                                      )),
                                ),
                                focusColor: Blue1,
                                fillColor: light,
                                filled: true,
                                errorStyle: getTextErrorFormLogin(context),
                                errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: errorBg, width: 1.8),
                                    borderRadius: BorderRadius.circular(14),
                                    gapPadding: 2),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: error, width: 1.8),
                                    borderRadius: BorderRadius.circular(14)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Blue1, width: 1.8),
                                    borderRadius: BorderRadius.circular(14)),
                                hintText: 'Email',
                                hintStyle: getTextHintFormLogin(context),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 1, color: dark),
                                    borderRadius: BorderRadius.circular(14))),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: bodyHeight * 0.003,
                      // ),
                      Form(
                        key: controller.passKey.value,
                        child: Obx(
                          () => Container(
                            width: 344,
                            height: bodyHeight * 0.1,
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: getTextLogin(context),
                              // onTap: () {
                              //   FocusScopeNode currentFocus =
                              //       FocusScope.of(context);

                              //   if (!currentFocus.hasPrimaryFocus) {
                              //     currentFocus.unfocus();
                              //   }

                              //   // controller.iconPass.value =
                              //   //     !controller.iconPass.value;
                              // },
                              // onChanged: (value) {
                              //   controller.isFormEmpty.isFalse;
                              // },
                              validator: controller.passValidator,
                              obscureText: controller.isPasswordHidden.value,
                              controller: controller.passC,
                              decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(
                                      left: bodyWidth * 0.01,
                                      right: bodyWidth * 0.006,
                                    ),
                                    child: Align(
                                        widthFactor: 1.0,
                                        heightFactor: 1.0,
                                        child: Icon(
                                          IconlyLight.lock,
                                          color: Blue1,
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
                                      borderRadius: BorderRadius.circular(14),
                                      gapPadding: 2),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: error, width: 1.8),
                                      borderRadius: BorderRadius.circular(14)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Blue1, width: 1.8),
                                      borderRadius: BorderRadius.circular(14)),
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.only(
                                      right: bodyWidth * 0.01,
                                    ),
                                    child: IconButton(
                                      color: Colors.black26,
                                      splashRadius: 1,
                                      icon: Icon(
                                          controller.isPasswordHidden.value
                                              ? Icons.visibility_rounded
                                              : Icons.visibility_off_rounded),
                                      onPressed: () {
                                        controller.isPasswordHidden.value =
                                            !controller.isPasswordHidden.value;
                                      },
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(width: 1, color: dark),
                                      borderRadius: BorderRadius.circular(14))),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 211,
                        height: bodyHeight * 0.05,
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
                    ],
                  ),
                )),
      );
    } else {
      // WELCOME SCREEN MOBILE
      return Scaffold(
        appBar: AppBar(
          title: Text('HomeView'),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            'HALO Ini MOBILE',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }
  }
}
