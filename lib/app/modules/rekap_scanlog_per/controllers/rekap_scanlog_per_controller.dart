import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:intl/intl.dart';
import 'package:universal_html/html.dart' as html;

import '../../../data/models/firestorescanlogmodel.dart';
import '../../../utils/textfield.dart';

class RekapScanlogPerController extends GetxController {
  //TODO: Implement RekapScanlogPerController

  late Stream<List<KepegawaianModel>> firestoreKepegawaianList;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<KepegawaianModel> kepegawaianList = [];
  List<PresensiModel> presensiData = [];
  var pinList = <String>[].obs;

  DateTime? start;
  final end = DateTime.now().obs;
  final dateFormatter = DateFormat('d MMMM yyyy', 'id-ID');

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
    fetchPinData().then((_) {
      update();
    });
    fetchKepegawaianList();
  }

  Future fetchPinData() async {
    final snapshot = await firestore.collection('Kepegawaian').get();
    final pinData = snapshot.docs.map((doc) => doc.get('pin')).toList();
    pinList.value = List<String>.from(pinData);
    log('$pinList');
    update();
  }

  void pickRangeDate(DateTime pickStart, DateTime pickEnd) {
    start = pickStart;
    end.value = pickEnd;
    update();
    var startFormatted = dateFormatter.format(start!);
    var endFormatted = dateFormatter.format(end.value);
    textC.datepickerC.text = '$startFormatted - $endFormatted';
  }

  void fetchKepegawaianList() {
    firestoreKepegawaianList.listen((list) {
      kepegawaianList = list;
      pinList.value =
          kepegawaianList.map((kepegawaian) => kepegawaian.pin!).toList();
      update();
    });
  }

  Future<void> generatePDF(String pin) async {
    final pdf = pw.Document();
    final filteredPresensi =
        presensiData.where((presensi) => presensi.pin == pin).toList();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Rekap Presensi', style: pw.TextStyle(fontSize: 20)),
              pw.Text('PIN: $pin'),
              pw.Text('Tanggal: ${start.toString()} - ${end.toString()}'),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                context: context,
                data: [
                  ['Tanggal', 'Masuk', 'Keluar'],
                  for (var kepegawaian in filteredPresensi)
                    [
                      kepegawaian.pin.toString(),
                      kepegawaian.dateTime.toString(),
                      kepegawaian.status.toString(),
                    ],
                ],
              ),
            ],
          );
        },
      ),
    );

    final bytes = await pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'rekap_presensi.pdf';

    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
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
