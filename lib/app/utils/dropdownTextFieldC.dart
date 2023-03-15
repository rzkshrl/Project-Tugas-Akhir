import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropdownTextFieldController extends GetxController {
  final pinTambahDataPegKey = GlobalKey<FormState>().obs;
  final jadkerTambahDataPegKey = GlobalKey<FormState>().obs;
  final bidangTambahDataPegKey = GlobalKey<FormState>().obs;

  final TextEditingController pinTambahDataPegC = TextEditingController();
  final TextEditingController jadkerTambahDataPegC = TextEditingController();
  final TextEditingController bidangTambahDataPegC = TextEditingController();

  late var pinCon = "".obs;
  void setPin(String pin) {
    pinCon.value = pin;
    // log(divisiCon.value);
  }
}
