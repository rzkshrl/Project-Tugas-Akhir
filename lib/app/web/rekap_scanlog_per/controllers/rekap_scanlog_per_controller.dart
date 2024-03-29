// ignore_for_file: unnecessary_overrides

import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:universal_html/html.dart' as html;

import '../../../data/models/firestorescanlogmodel.dart';
import '../../../utils/textfield.dart';

class RekapScanlogPerController extends GetxController {
  List<KepegawaianModel> kepegawaianList = [];
  var pinList = <String>[].obs;
  var namaList = <String>[].obs;
  final isClicked = false.obs;

  final pdfURL = "".obs;

  final pdfBytes = Rx<Uint8List?>(null);

  DateTime? start;
  final end = DateTime.now().obs;
  final dateFormatter = DateFormat('d MMMM yyyy', 'id-ID');

  late Future<List<KepegawaianModel>> firestoreKepegawaianList;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    firestoreKepegawaianList = getFirestoreKepegawaianList();
    fetchPinData();
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

  Future<void> unduhPDF(String pin) async {
    final QuerySnapshot<Map<String, dynamic>> presensiSnapshot;

    if (start == null) {
      presensiSnapshot = await firestore
          .collection('Kepegawaian')
          .doc(pin)
          .collection('Presensi')
          .where("date_time", isLessThan: end.value.toIso8601String())
          .orderBy("date_time", descending: false)
          .get();
    } else {
      presensiSnapshot = await firestore
          .collection('Kepegawaian')
          .doc(pin)
          .collection('Presensi')
          .where("date_time", isGreaterThan: start!.toIso8601String())
          .where("date_time",
              isLessThan:
                  end.value.add(const Duration(days: 1)).toIso8601String())
          .orderBy("date_time", descending: false)
          .get();
    }

    DocumentSnapshot<Map<String, dynamic>> kepegawaianSnapshot =
        await firestore.collection('Kepegawaian').doc(pin).get();

    final KepegawaianModel kepegawaianModel =
        KepegawaianModel.fromSnapshot(kepegawaianSnapshot);

    List<KepegawaianModel> kepegawaianData = [kepegawaianModel];

    List<PresensiModel> presensiData = presensiSnapshot.docs
        .map((e) => PresensiModel.fromJson(e.data()))
        .toList();

    List<GroupedPresensiModel> groupedData = groupAttendanceData(presensiData);

    final pdf = pw.Document();
    var formatterTime = DateFormat('HH:mm', 'id-ID');

    const int rowsPerPage = 18;

    final totalPages = (groupedData.length / rowsPerPage).ceil();

    for (var pageIndex = 0; pageIndex < totalPages; pageIndex++) {
      final startRow = pageIndex * rowsPerPage;
      final endRow = (pageIndex + 1) * rowsPerPage;

      final tableRows = <pw.TableRow>[
        pw.TableRow(
          children: [
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('No.',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 8)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('PIN',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 8)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('NIP',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 8)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Nama',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 8)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Jabatan',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 8)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Kepegawaian',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 8)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Madrasah',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 8)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Tanggal',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 8)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Scan Masuk',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 8)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Scan Keluar',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 8)),
            ),
          ],
        ),
        for (var i = startRow; i < endRow && i < groupedData.length; i++)
          pw.TableRow(
            children: [
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text("${i + 1}.",
                    style: const pw.TextStyle(fontSize: 8)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(groupedData[i].pin!,
                    style: const pw.TextStyle(fontSize: 8)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                    kepegawaianData
                        .firstWhere((kepegawaian) =>
                            kepegawaian.pin == groupedData[i].pin)
                        .nip!,
                    style: const pw.TextStyle(fontSize: 8)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                    kepegawaianData
                        .firstWhere((kepegawaian) =>
                            kepegawaian.pin == groupedData[i].pin)
                        .nama!,
                    style: const pw.TextStyle(fontSize: 8)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                    kepegawaianData
                        .firstWhere((kepegawaian) =>
                            kepegawaian.pin == groupedData[i].pin)
                        .bidang!,
                    style: const pw.TextStyle(fontSize: 8)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                    kepegawaianData
                        .firstWhere((kepegawaian) =>
                            kepegawaian.pin == groupedData[i].pin)
                        .kepegawaian!,
                    style: const pw.TextStyle(fontSize: 8)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text("MIM JETIS LOR",
                    style: const pw.TextStyle(fontSize: 8)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                    dateFormatter.format(groupedData[i].dateTimeMasuk!),
                    style: const pw.TextStyle(fontSize: 8)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                  formatterTime.format(groupedData[i].dateTimeMasuk!),
                  style: const pw.TextStyle(fontSize: 8),
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                  formatterTime.format(groupedData[i].dateTimeKeluar!),
                  style: const pw.TextStyle(fontSize: 8),
                ),
              ),
            ],
          ),
      ];

      pdf.addPage(
        pw.Page(
          orientation: pw.PageOrientation.landscape,
          pageFormat: PdfPageFormat.a4.landscape,
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Kartu Scanlog', style: const pw.TextStyle(fontSize: 12)),
              pw.Text('PIN: $pin', style: const pw.TextStyle(fontSize: 10)),
              pw.Text(
                'Tanggal: ${dateFormatter.format(start!).toString()} - ${dateFormatter.format(end.value).toString()}',
                style: const pw.TextStyle(fontSize: 10),
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                columnWidths: {
                  0: const pw.FixedColumnWidth(40),
                  1: const pw.FixedColumnWidth(40),
                  2: const pw.FixedColumnWidth(100),
                  3: const pw.FixedColumnWidth(100),
                  4: const pw.FixedColumnWidth(100),
                  5: const pw.FixedColumnWidth(80),
                  6: const pw.FixedColumnWidth(80),
                  7: const pw.FixedColumnWidth(80),
                  8: const pw.FixedColumnWidth(80),
                  9: const pw.FixedColumnWidth(80),
                },
                border: pw.TableBorder.all(color: PdfColors.grey),
                children: tableRows,
              ),
            ],
          ),
        ),
      );
    }
    final bytes = await pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download =
          'Rekapitulasi Scanlog PIN $pin (${dateFormatter.format(start!).toString()} - ${dateFormatter.format(end.value).toString()}).pdf';

    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  Future<void> previewPDF(String pin) async {
    isClicked.value = true;
    update();
    final QuerySnapshot<Map<String, dynamic>> presensiSnapshot;

    if (start == null) {
      presensiSnapshot = await firestore
          .collection('Kepegawaian')
          .doc(pin)
          .collection('Presensi')
          .where("date_time", isLessThan: end.value.toIso8601String())
          .orderBy("date_time", descending: false)
          .get();
    } else {
      presensiSnapshot = await firestore
          .collection('Kepegawaian')
          .doc(pin)
          .collection('Presensi')
          .where("date_time", isGreaterThan: start!.toIso8601String())
          .where("date_time",
              isLessThan:
                  end.value.add(const Duration(days: 1)).toIso8601String())
          .orderBy("date_time", descending: false)
          .get();
    }

    DocumentSnapshot<Map<String, dynamic>> kepegawaianSnapshot =
        await firestore.collection('Kepegawaian').doc(pin).get();

    final KepegawaianModel kepegawaianModel =
        KepegawaianModel.fromSnapshot(kepegawaianSnapshot);

    List<KepegawaianModel> kepegawaianData = [kepegawaianModel];

    List<PresensiModel> presensiData = presensiSnapshot.docs
        .map((e) => PresensiModel.fromJson(e.data()))
        .toList();

    List<GroupedPresensiModel> groupedData = groupAttendanceData(presensiData);

    final pdfPreview = pw.Document();
    var formatterTime = DateFormat('HH:mm', 'id-ID');

    const int rowsPerPage = 18;

    final totalPages = (groupedData.length / rowsPerPage).ceil();

    for (var pageIndex = 0; pageIndex < totalPages; pageIndex++) {
      final startRow = pageIndex * rowsPerPage;
      final endRow = (pageIndex + 1) * rowsPerPage;

      final tableRows = <pw.TableRow>[
        pw.TableRow(
          children: [
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('No.',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 8)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('PIN',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 8)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('NIP',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 8)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Nama',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 8)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Jabatan',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 8)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Kepegawaian',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 8)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Madrasah',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 8)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Tanggal',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 8)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Scan Masuk',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 8)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Scan Keluar',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 8)),
            ),
          ],
        ),
        for (var i = startRow; i < endRow && i < groupedData.length; i++)
          pw.TableRow(
            children: [
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text("${i + 1}.",
                    style: const pw.TextStyle(fontSize: 8)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(groupedData[i].pin!,
                    style: const pw.TextStyle(fontSize: 8)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                    kepegawaianData
                        .firstWhere((kepegawaian) =>
                            kepegawaian.pin == groupedData[i].pin)
                        .nip!,
                    style: const pw.TextStyle(fontSize: 8)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                    kepegawaianData
                        .firstWhere((kepegawaian) =>
                            kepegawaian.pin == groupedData[i].pin)
                        .nama!,
                    style: const pw.TextStyle(fontSize: 8)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                    kepegawaianData
                        .firstWhere((kepegawaian) =>
                            kepegawaian.pin == groupedData[i].pin)
                        .bidang!,
                    style: const pw.TextStyle(fontSize: 8)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                    kepegawaianData
                        .firstWhere((kepegawaian) =>
                            kepegawaian.pin == groupedData[i].pin)
                        .kepegawaian!,
                    style: const pw.TextStyle(fontSize: 8)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text("MIM JETIS LOR",
                    style: const pw.TextStyle(fontSize: 8)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                    dateFormatter.format(groupedData[i].dateTimeMasuk!),
                    style: const pw.TextStyle(fontSize: 8)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                  formatterTime.format(groupedData[i].dateTimeMasuk!),
                  style: const pw.TextStyle(fontSize: 8),
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                  formatterTime.format(groupedData[i].dateTimeKeluar!),
                  style: const pw.TextStyle(fontSize: 8),
                ),
              ),
            ],
          ),
      ];

      pdfPreview.addPage(
        pw.Page(
          orientation: pw.PageOrientation.landscape,
          pageFormat: PdfPageFormat.a4.landscape,
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Kartu Scanlog', style: const pw.TextStyle(fontSize: 12)),
              pw.Text('PIN: $pin', style: const pw.TextStyle(fontSize: 10)),
              pw.Text(
                'Tanggal: ${dateFormatter.format(start!).toString()} - ${dateFormatter.format(end.value).toString()}',
                style: const pw.TextStyle(fontSize: 10),
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                columnWidths: {
                  0: const pw.FixedColumnWidth(40),
                  1: const pw.FixedColumnWidth(40),
                  2: const pw.FixedColumnWidth(100),
                  3: const pw.FixedColumnWidth(100),
                  4: const pw.FixedColumnWidth(100),
                  5: const pw.FixedColumnWidth(80),
                  6: const pw.FixedColumnWidth(80),
                  7: const pw.FixedColumnWidth(80),
                  8: const pw.FixedColumnWidth(80),
                  9: const pw.FixedColumnWidth(80),
                },
                border: pw.TableBorder.all(color: PdfColors.grey),
                children: tableRows,
              ),
            ],
          ),
        ),
      );
    }
    final bytes = await pdfPreview.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    pdfBytes.value = bytes;
    pdfURL.value = url;
    if (kDebugMode) {
      print(pdfURL);
    }
    update();
  }

  void exportData(List dataList) {
    final content = jsonEncode(dataList);

    final bytes = utf8.encode(content);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'data.txt';

    html.document.body!.children.add(anchor);
    anchor.click();

    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  List<GroupedPresensiModel> groupAttendanceData(List<PresensiModel> rawData) {
    List<GroupedPresensiModel> groupedData = [];
    GroupedPresensiModel? currentPresensi;

    for (var data in rawData) {
      String? pin = data.pin;
      DateTime? dateTime = data.dateTime;
      String? status = data.status;

      if (status == 'Masuk') {
        currentPresensi = GroupedPresensiModel(
          pin: pin,
          dateTimeMasuk: dateTime,
          dateTimeKeluar: DateTime.now(),
        );
        groupedData.add(currentPresensi);
      } else if (status == 'Keluar') {
        if (currentPresensi != null && currentPresensi.pin == pin) {
          currentPresensi.dateTimeKeluar = dateTime;
        }
      }
    }

    return groupedData;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    textC.datepickerC.clear();
  }
}
