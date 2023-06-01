// ignore_for_file: file_names

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

  final emailMobileC = TextEditingController();
  final emailMobileResetPassC = TextEditingController();
  final passMobileC = TextEditingController();
  final emailMobileKey = GlobalKey<FormState>().obs;
  final emailMobileResetPassKey = GlobalKey<FormState>().obs;
  final passMobileKey = GlobalKey<FormState>().obs;

  final namaTambahDataPegC = TextEditingController();
  final pinTambahDataPegC = TextEditingController();
  final nipTambahDataPegC = TextEditingController();
  final emailTambahDataPegC = TextEditingController();
  final bidangTambahDataPegC = TextEditingController();
  final namaTambahDataPegKey = GlobalKey<FormState>().obs;
  final pinTambahDataPegKey = GlobalKey<FormState>().obs;
  final nipTambahDataPegKey = GlobalKey<FormState>().obs;
  final emailTambahDataPegKey = GlobalKey<FormState>().obs;
  final bidangTambahDataPegKey = GlobalKey<FormState>().obs;

  final namaDataUserC = TextEditingController();
  final emailDataUserC = TextEditingController();
  final passDataUserC = TextEditingController();
  final pinDataUserC = TextEditingController();
  final namaDataUserKey = GlobalKey<FormState>().obs;
  final emailDataUserKey = GlobalKey<FormState>().obs;
  final passDataUserKey = GlobalKey<FormState>().obs;
  final pinDataUserKey = GlobalKey<FormState>().obs;

  final yearAPILiburC = TextEditingController();
  final yearAPILiburKey = GlobalKey<FormState>().obs;

  final addLiburC = TextEditingController();
  final addLiburKey = GlobalKey<FormState>().obs;
  final addNamaLiburC = TextEditingController();
  final addNamaLiburKey = GlobalKey<FormState>().obs;

  final datepickerC = TextEditingController();
  final datepickerKey = GlobalKey<FormState>().obs;

  final namaUbahProfilC = TextEditingController();
  final namaUbahProfilKey = GlobalKey<FormState>().obs;

  final namaJamKerjaC = TextEditingController();
  final namaJamKerjaKey = GlobalKey<FormState>().obs;
  final kodeJamKerjaC = TextEditingController();
  final kodeJamKerjaKey = GlobalKey<FormState>().obs;
  final ketJamKerjaC = TextEditingController();
  final ketJamKerjaKey = GlobalKey<FormState>().obs;
  final masukJamKerjaC = TextEditingController();
  final masukJamKerjaKey = GlobalKey<FormState>().obs;
  final keluarJamKerjaC = TextEditingController();
  final keluarJamKerjaKey = GlobalKey<FormState>().obs;
  final batasAwalmasukJamKerjaC = TextEditingController();
  final batasAwalmasukJamKerjaKey = GlobalKey<FormState>().obs;
  final batasAwalkeluarJamKerjaC = TextEditingController();
  final batasAwalkeluarJamKerjaKey = GlobalKey<FormState>().obs;
  final batasAkhirmasukJamKerjaC = TextEditingController();
  final batasAkhirmasukJamKerjaKey = GlobalKey<FormState>().obs;
  final batasAkhirkeluarJamKerjaC = TextEditingController();
  final batasAkhirkeluarJamKerjaKey = GlobalKey<FormState>().obs;
  final terlambatJamKerjaC = TextEditingController();
  final terlambatJamKerjaKey = GlobalKey<FormState>().obs;
  final pulLebihAwalJamKerjaC = TextEditingController();
  final pulLebihAwalJamKerjaKey = GlobalKey<FormState>().obs;

  final emailValidator = MultiValidator([
    EmailValidator(errorText: "Email tidak valid"),
    RequiredValidator(errorText: "Kolom harus diisi")
  ]);
  final normalValidator =
      MultiValidator([RequiredValidator(errorText: "Kolom harus diisi")]);
  final passValidator = MultiValidator([
    RequiredValidator(errorText: "Kolom harus diisi"),
    MinLengthValidator(6, errorText: "Kata sandi kurang dari 6 karakter"),
  ]);
}
