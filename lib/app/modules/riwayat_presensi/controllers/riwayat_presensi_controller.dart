import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_tugas_akhir/app/data/models/allscanlogmodel.dart';

import '../../../data/models/firestorescanlogmodel.dart';

class RiwayatPresensiController extends GetxController {
  late Stream<List<KepegawaianModel>> firestoreKepegawaianList;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    firestoreKepegawaianList = firestore
        .collection('Kepegawaian')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((documentSnapshot) =>
                KepegawaianModel.fromSnapshot(documentSnapshot))
            .toList());
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
