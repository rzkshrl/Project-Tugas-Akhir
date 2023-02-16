import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

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
    final textScale = MediaQuery.of(context).textScaleFactor;
    final bodyHeight = MediaQuery.of(context).size.height;
    final bodyWidth = MediaQuery.of(context).size.width;
    // LOGIN ADMIN WEB
    if (kIsWeb) {
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
                            "Reset Sandi ",
                            style: getTextLogin(context),
                          ),
                          Text("Admin", style: getTextAdmin(context))
                        ],
                      )),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Verifikasi Reset Sandi akan dikirimkan ke inbox email",
                        style: getText10ptBlue(context),
                      ),
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
                            if (controller.emailKey.value.currentState!
                                .validate()) {
                              authC.lupaSandi(controller.emailC.text, context);
                            }
                          },
                          child: Text(
                            'Kirim',
                            style: getTextLoginBtnActive(context),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: bodyHeight * 0.03,
                      ),
                      TextButton(
                        onPressed: () => Get.offAllNamed(Routes.LOGIN),
                        child: Text('Tidak lupa kata sandi? Masuk?',
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
