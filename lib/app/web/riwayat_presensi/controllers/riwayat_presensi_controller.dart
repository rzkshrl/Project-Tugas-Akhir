// ignore_for_file: unnecessary_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/models/firestorescanlogmodel.dart';

class RiwayatPresensiController extends GetxController {
  late Future<List<KepegawaianModel>> firestoreKepegawaianList;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    // firestoreKepegawaianList = firestore
    //     .collection('Kepegawaian')
    //     .snapshots()
    //     .map((querySnapshot) => querySnapshot.docs
    //         .map((documentSnapshot) =>
    //             KepegawaianModel.fromSnapshot(documentSnapshot))
    //         .toList());
    firestoreKepegawaianList = getFirestoreKepegawaianList();
  }

  Future<List<KepegawaianModel>> getFirestoreKepegawaianList() async {
    QuerySnapshot querySnapshot =
        await firestore.collection('Kepegawaian').get();
    List<KepegawaianModel> kepegawaianList = querySnapshot.docs
        .map((documentSnapshot) =>
            KepegawaianModel.fromSnapshot(documentSnapshot))
        .toList();
    return kepegawaianList;
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
