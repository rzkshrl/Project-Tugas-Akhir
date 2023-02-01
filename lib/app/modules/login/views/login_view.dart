import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../theme/theme.dart';
import '../controllers/login_controller.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    final textScale = MediaQuery.of(context).textScaleFactor;
    final bodyHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
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
                        height: bodyHeight * 0.3,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/icons/logo.png',
                          width: bodyWidth * 0.3,
                          height: bodyHeight * 0.3,
                        ),
                      ),
                      SizedBox(
                        height: bodyHeight * 0.08,
                      ),
                      Form(
                        key: controller.emailKey.value,
                        child: Container(
                          width: bodyWidth * 0.3,
                          height: bodyHeight * 0.085,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            validator: controller.emailValidator,
                            controller: controller.emailC,
                            style: TextStyle(color: dark),
                            // onTap: () {
                            //   FocusScopeNode currentFocus =
                            //       FocusScope.of(context);

                            //   if (!currentFocus.hasPrimaryFocus) {
                            //     currentFocus.unfocus();
                            //   }

                            //   // controller.iconEmail.value =
                            //   //     !controller.iconEmail.value;
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
                                errorStyle: TextStyle(
                                  fontSize: 13.5 * textScale,
                                  color: light,
                                  background: Paint()
                                    ..strokeWidth = 20
                                    ..color = errorBg
                                    ..style = PaintingStyle.stroke
                                    ..strokeJoin = StrokeJoin.round,
                                ),
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
                                hintStyle: heading6.copyWith(
                                    color: Grey1, fontSize: 14 * textScale),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(width: 1, color: dark),
                                    borderRadius: BorderRadius.circular(14))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: bodyHeight * 0.01,
                      ),
                      Form(
                        key: controller.passKey.value,
                        child: Obx(
                          () => Container(
                            width: bodyWidth * 0.3,
                            height: bodyHeight * 0.085,
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: TextStyle(color: dark),
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
                                  hintStyle: heading6.copyWith(
                                      color: Grey1, fontSize: 14 * textScale),
                                  fillColor: light,
                                  filled: true,
                                  errorStyle: TextStyle(
                                    fontSize: 13.5 * textScale,
                                    color: light,
                                    background: Paint()
                                      ..strokeWidth = 20
                                      ..color = errorBg
                                      ..style = PaintingStyle.stroke
                                      ..strokeJoin = StrokeJoin.round,
                                  ),
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
                      )
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
