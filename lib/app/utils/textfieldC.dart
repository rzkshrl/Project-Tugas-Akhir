import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class TextFieldController extends GetxController {
  final isPasswordHidden = true.obs;

  final emailWebC = TextEditingController();
  final emailWebResetPassC = TextEditingController();
  final passWebC = TextEditingController();

  final emailWebKey = GlobalKey<FormState>().obs;
  final emailWebResetPassKey = GlobalKey<FormState>().obs;
  final passWebKey = GlobalKey<FormState>().obs;

  final emailValidator = MultiValidator([
    EmailValidator(errorText: "Email tidak valid"),
    RequiredValidator(errorText: "Kolom harus diisi")
  ]);
  final passValidator = MultiValidator([
    RequiredValidator(errorText: "Kolom harus diisi"),
    MinLengthValidator(6, errorText: "Kata sandi kurang dari 6 karakter"),
  ]);
}
