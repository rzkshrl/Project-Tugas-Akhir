import 'package:cloud_firestore/cloud_firestore.dart';

List<HolidayModel> holidayList = [];

class HolidayModel {
  String? name;
  String? date;

  HolidayModel({this.name, this.date});

  factory HolidayModel.fromJson(DocumentSnapshot json) {
    final data = json.data() as Map<String, dynamic>;
    return (HolidayModel(name: data['name'], date: data['date']));
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "date": date,
    };
  }
}
