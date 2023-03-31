import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropdownTextFieldController extends GetxController {
  final jadkerTambahDataPegKey = GlobalKey<FormState>().obs;
  final bidangTambahDataPegKey = GlobalKey<FormState>().obs;

  final TextEditingController jadkerTambahDataPegC = TextEditingController();
  final TextEditingController bidangTambahDataPegC = TextEditingController();

  final jadkerCon = "".obs;
  setJadker(String jadker) {
    jadkerCon.value = jadker;
    log(jadkerCon.value);
  }

  final bidangCon = "".obs;
  setBidang(String bidang) {
    bidangCon.value = bidang;
    log(bidangCon.value);
  }

  @override
  void onInit() {
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
    jadkerCon.close();
    bidangCon.close();

    super.onClose();
  }
}
