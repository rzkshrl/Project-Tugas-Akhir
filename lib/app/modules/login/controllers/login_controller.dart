import 'dart:js' as js;

import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final emailC = TextEditingController();
  final passC = TextEditingController();

  final emailKey = GlobalKey<FormState>().obs;
  final passKey = GlobalKey<FormState>().obs;

  final emailValidator = MultiValidator([
    EmailValidator(errorText: "Email tidak valid"),
    RequiredValidator(errorText: "Kolom harus diisi")
  ]);
  final passValidator = MultiValidator([
    RequiredValidator(errorText: "Kolom harus diisi"),
    MinLengthValidator(6, errorText: "Kata sandi kurang dari 6 karakter"),
  ]);

  final isPasswordHidden = true.obs;

  var isForm = "".obs;

  void fixEdgePasswordRevealButton(FocusNode passwordFocusNode) {
    passwordFocusNode.unfocus();
    Future.microtask(() {
      passwordFocusNode.requestFocus();
      js.context.callMethod("fixPasswordCss", []);
    });
  }
  // var isFormEmpty = true.obs;

  // void setEmptyEmail() {
  //   emailC.addListener(() {
  //     isForm.value = emailC.text.isEmpty as String;
  //   });
  // }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
