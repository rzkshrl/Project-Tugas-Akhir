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
  setPin(String pin) {
    pinCon.value = pin;
    // log(divisiCon.value);
  }

  late var jadkerCon = "".obs;
  setJadker(String jadker) {
    jadkerCon.value = jadker;
    // log(divisiCon.value);
  }

  late var bidangCon = "".obs;
  setBidang(String bidang) {
    bidangCon.value = bidang;
    // log(divisiCon.value);
  }

  @override
  void onInit() {
    setPin(String pin) {
      pinCon.value = pin;
      // log(divisiCon.value);
    }

    setJadker(String jadker) {
      jadkerCon.value = jadker;
      // log(divisiCon.value);
    }

    setBidang(String bidang) {
      bidangCon.value = bidang;
      // log(divisiCon.value);
    }

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pinCon.close();
    jadkerCon.close();
    bidangCon.close();

    super.onClose();
  }
}
