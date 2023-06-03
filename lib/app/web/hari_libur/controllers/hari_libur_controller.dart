// ignore_for_file: unnecessary_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../data/models/firestorehariliburmodel.dart';
import '../../../theme/textstyle.dart';
import '../../../utils/dialogDefault.dart';
import '../../../utils/textfield.dart';

class HariLiburController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream<List<HolidayModel>> firestoreHolidayList;
  @override
  void onInit() {
    super.onInit();
    firestoreHolidayList = firestore.collection('Holiday').snapshots().map(
        (querySnapshot) => querySnapshot.docs
            .map((documentSnapshot) => HolidayModel.fromJson(documentSnapshot))
            .toList());
  }

  final selectedDate = DateTime.now().obs;
  final dateFormatter = DateFormat('d MMMM yyyy', 'id-ID');
  final dateDefFormatter = DateFormat('yyyy-MM-dd');

  DateRangePickerController datePickerController = DateRangePickerController();

  void selectDateHariLibur(DateRangePickerSelectionChangedArgs args) {
    selectedDate.value = args.value;

    final dateFormatted = dateFormatter.format(selectedDate.value);
    textC.datepickerC.text = dateFormatted;
    if (kDebugMode) {
      print(textC.datepickerC.text);
    }
  }

  Future<void> addHariLibur(
    String nama,
    String date,
  ) async {
    try {
      var hariLibur = firestore.collection('Holiday');

      if (kDebugMode) {
        print(date);
      }

      final tanggal = dateFormatter.parse(date);

      final formattedDate = dateDefFormatter.format(tanggal);

      final DocumentReference docRef = hariLibur.doc(date);
      final checkData = await docRef.get();

      if (checkData.exists == false) {
        await hariLibur.doc(formattedDate).set({
          'name': nama,
          'date': formattedDate,
        });
        Get.dialog(
          dialogAlertBtnSingleMsgAnimation('assets/lootie/finish.json',
              'Berhasil Menambahkan Data!', getTextAlert(Get.context!), () {
            Get.back();
            Get.back();
          }),
        );
      } else {
        Get.dialog(dialogAlertOnlySingleMsg(
            IconlyLight.danger, "Data sudah ada.", getTextAlert(Get.context!)));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
          "Terjadi Kesalahan!.", getTextAlert(Get.context!)));
    }
  }

  Future<void> editHariLibur(
    String doc,
    String nama,
    String date,
  ) async {
    try {
      final hariLibur = firestore.collection('Holiday');

      if (kDebugMode) {
        print(date);
      }

      final tanggal = dateFormatter.parse(date);

      final formattedDate = dateDefFormatter.format(tanggal);

      await hariLibur.doc(doc).update({
        'name': nama,
        'date': formattedDate,
      });
      Get.dialog(
        dialogAlertBtnSingleMsgAnimation('assets/lootie/finish.json',
            'Berhasil Menambahkan Data!', getTextAlert(Get.context!), () {
          Get.back();
          Get.back();
        }),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
          "Terjadi Kesalahan!.", getTextAlert(Get.context!)));
    }
  }

  Future<void> deleteHariLibur(String doc) async {
    Get.dialog(dialogAlertDualBtn(() async {
      Get.back();
    }, () async {
      Get.back();
      try {
        await firestore.collection('Holiday').doc(doc).delete();
        Get.dialog(
          dialogAlertBtnSingleMsgAnimation('assets/lootie/finish.json',
              'Berhasil Menghapus Data!', getTextAlert(Get.context!), () {
            Get.back();
          }),
        );
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
            "Terjadi Kesalahan!.", getTextAlert(Get.context!)));
      }
    },
        IconlyLight.danger,
        111.29,
        'Batal',
        111.29,
        'OK',
        'Peringatan!',
        'Apakah anda yakin ingin menghapus data?',
        getTextAlert(Get.context!),
        getTextAlertSub(Get.context!),
        getTextAlertBtn(Get.context!),
        getTextAlertBtn2(Get.context!)));
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