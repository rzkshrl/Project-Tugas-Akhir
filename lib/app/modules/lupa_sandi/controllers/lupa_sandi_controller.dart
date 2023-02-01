import 'package:flutter/widgets.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

class LupaSandiController extends GetxController {
  //TODO: Implement LupaSandiController

  final emailC = TextEditingController();

  final emailKey = GlobalKey<FormState>().obs;

  final emailValidator = MultiValidator([
    EmailValidator(errorText: "Email tidak valid"),
    RequiredValidator(errorText: "Kolom harus diisi")
  ]);

  final count = 0.obs;
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

  void increment() => count.value++;
}
