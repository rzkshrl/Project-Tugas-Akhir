import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../data/models/firestorehariliburmodel.dart';

class HariLiburController extends GetxController {
  //TODO: Implement HariLiburController
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
