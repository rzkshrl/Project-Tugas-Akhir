import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:universal_html/html.dart' as html;

import '../../../data/models/firestorescanlogmodel.dart';
import '../../../utils/textfield.dart';

class RekapScanlogPerController extends GetxController {
  //TODO: Implement RekapScanlogPerController

  late Stream<List<KepegawaianModel>> firestoreKepegawaianList;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<KepegawaianModel> kepegawaianList = [];
  var pinList = <String>[].obs;
  var namaList = <String>[].obs;

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
    final namaData = snapshot.docs.map((doc) => doc.get('nama')).toList();
    pinList.value = List<String>.from(pinData);
    namaList.value = List<String>.from(namaData);
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

  String? getNamaFromKepegawaian(
      String? pin, List<KepegawaianModel> kepegawaianData) {
    final kepegawaian = kepegawaianData.firstWhere(
      (data) => data.pin == pin,
    );
    return kepegawaian.nama;
  }

  String? getJabatanFromKepegawaian(
      String? pin, List<KepegawaianModel> kepegawaianData) {
    final kepegawaian = kepegawaianData.firstWhere(
      (data) => data.pin == pin,
    );
    return kepegawaian.bidang;
  }

  Future<void> generatePDF(String pin) async {
    final QuerySnapshot<Map<String, dynamic>> presensiSnapshot;

    if (start == null) {
      presensiSnapshot = await firestore
          .collection('Kepegawaian')
          .doc(pin)
          .collection('Presensi')
          .where("date_time", isLessThan: end.value.toIso8601String())
          .orderBy("date_time", descending: true)
          .get();
    } else {
      presensiSnapshot = await firestore
          .collection('Kepegawaian')
          .doc(pin)
          .collection('Presensi')
          .where("date_time", isGreaterThan: start!.toIso8601String())
          .where("date_time",
              isLessThan: end.value.add(Duration(days: 1)).toIso8601String())
          .orderBy("date_time", descending: true)
          .get();
    }

    DocumentSnapshot<Map<String, dynamic>> kepegawaianSnapshot =
        await firestore.collection('Kepegawaian').doc(pin).get();

    final KepegawaianModel kepegawaianModel =
        KepegawaianModel.fromSnapshot(kepegawaianSnapshot);

    List<KepegawaianModel> kepegawaianData = [kepegawaianModel];

    List<PresensiModel> presensiData = presensiSnapshot.docs
        .map((e) => PresensiModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();

    final pdf = pw.Document();
    var formatterDate = DateFormat('d MMMM yyyy', 'id-ID');
    var formatterTime = DateFormat('HH:mm', 'id-ID');

    // final pageFormat = PdfPageFormat.a4;

    // final marginLeft = 20.0;
    // final marginRight = 20.0;
    // final marginTop = 20.0;
    // final marginBottom = 20.0;

    // final tableWidth = pageFormat.availableWidth - marginLeft - marginRight;

    // final tableRowHeight = 30.0;

    // final maxRowsPerPage =
    //     (pageFormat.availableHeight - marginTop - marginBottom) ~/
    //         tableRowHeight;

    // int remainingRows = maxRowsPerPage;

    pdf.addPage(pw.Page(
      orientation: pw.PageOrientation.landscape,
      build: (pw.Context context) => pw.Column(
        children: [
          pw.Text('Kartu Scanlog', style: pw.TextStyle(fontSize: 12)),
          pw.Text('PIN: $pin'),
          pw.Text(
              'Tanggal: ${formatterDate.format(start!).toString()} - ${formatterDate.format(end.value).toString()}'),
          pw.SizedBox(height: 20),
          pw.Table.fromTextArray(
            columnWidths: {
              0: pw.FixedColumnWidth(50),
              1: pw.FixedColumnWidth(100),
              2: pw.FixedColumnWidth(100),
              3: pw.FixedColumnWidth(100),
              4: pw.FixedColumnWidth(100),
              5: pw.FixedColumnWidth(100),
            },
            cellAlignment: pw.Alignment.centerLeft,
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
            cellHeight: 30,
            headerHeight: 40,
            rowDecoration:
                pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey)),
            data: [
              [
                'PIN',
                'Nama',
                'Jabatan',
                'Tanggal',
                'Scan Masuk',
                'Scan Keluar'
              ],
              for (var presensi in presensiData)
                [
                  presensi.pin,
                  kepegawaianData
                      .firstWhere(
                          (kepegawaian) => kepegawaian.pin == presensi.pin)
                      .nama,
                  kepegawaianData
                      .firstWhere(
                          (kepegawaian) => kepegawaian.pin == presensi.pin)
                      .bidang,
                  dateFormatter.format(presensi.dateTime!),
                  presensi.status! == 'Masuk'
                      ? presensi.dateTime.toString()
                      : '',
                  presensi.status! == 'Keluar'
                      ? presensi.dateTime.toString()
                      : ''
                ],
            ],
          )
        ],
      ),
    ));

    // int remainingPresensi = presensiData.length - maxRowsPerPage;

    // while (remainingPresensi > 0) {
    //   pdf.addPage(pw.Page(
    //     orientation: pw.PageOrientation.landscape,
    //     build: (pw.Context context) => pw.Column(
    //       children: [
    //         pw.Text('Kartu Scanlog', style: pw.TextStyle(fontSize: 12)),
    //         pw.Text('PIN: $pin'),
    //         pw.Text(
    //             'Tanggal: ${formatterDate.format(start!).toString()} - ${formatterDate.format(end.value).toString()}'),
    //         pw.SizedBox(height: 20),
    //         pw.Table.fromTextArray(
    //           columnWidths: {
    //             0: pw.FixedColumnWidth(50),
    //             1: pw.FixedColumnWidth(100),
    //             2: pw.FixedColumnWidth(100),
    //             3: pw.FixedColumnWidth(100),
    //             4: pw.FixedColumnWidth(100),
    //             5: pw.FixedColumnWidth(100),
    //           },
    //           cellAlignment: pw.Alignment.centerLeft,
    //           headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
    //           headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
    //           cellHeight: 30,
    //           headerHeight: 40,
    //           rowDecoration: pw.BoxDecoration(
    //               border: pw.Border.all(color: PdfColors.grey)),
    //           data: [
    //             [
    //               'PIN',
    //               'Nama',
    //               'Jabatan',
    //               'Tanggal',
    //               'Scan Masuk',
    //               'Scan Keluar'
    //             ],
    //             for (var presensi in presensiData)
    //               [
    //                 presensi.pin,
    //                 kepegawaianData
    //                     .firstWhere(
    //                         (kepegawaian) => kepegawaian.pin == presensi.pin)
    //                     .nama,
    //                 kepegawaianData
    //                     .firstWhere(
    //                         (kepegawaian) => kepegawaian.pin == presensi.pin)
    //                     .bidang,
    //                 dateFormatter.format(presensi.dateTime!),
    //                 presensi.status! == 'Masuk'
    //                     ? presensi.dateTime.toString()
    //                     : '',
    //                 presensi.status! == 'Keluar'
    //                     ? presensi.dateTime.toString()
    //                     : ''
    //               ],
    //           ],
    //         )
    //       ],
    //     ),
    //   ));
    // }

    // remainingPresensi -= maxRowsPerPage;

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
