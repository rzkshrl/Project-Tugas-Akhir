import 'package:cloud_firestore/cloud_firestore.dart';

List<HolidayModel> holidayList = [];

class HolidayModel {
  String? name;
  String? date;
  String? id;

  HolidayModel({this.name, this.date, this.id});

  factory HolidayModel.fromJson(DocumentSnapshot json) {
    final data = json.data() as Map<String, dynamic>;
    return (HolidayModel(
        name: data['name'], date: data['date'], id: data['id']));
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "date": date,
    };
  }
}
