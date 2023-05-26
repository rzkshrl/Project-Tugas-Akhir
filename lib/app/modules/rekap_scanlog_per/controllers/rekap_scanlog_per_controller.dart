import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:project_tugas_akhir/app/modules/rekap_scanlog_per/views/rekap_scanlog_per_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
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
  final isClicked = false.obs;

  final pdfURL = "".obs;

  final pdfBytes = Rx<Uint8List?>(null);

  late PdfViewerController pdfViewerController;

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
    pdfViewerController = PdfViewerController();
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
              isLessThan: end.value.add(Duration(days: 1)).toIso8601String())
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

    final int rowsPerPage = 18;

    final totalPages = (groupedData.length / rowsPerPage).ceil();

    for (var pageIndex = 0; pageIndex < totalPages; pageIndex++) {
      final startRow = pageIndex * rowsPerPage;
      final endRow = (pageIndex + 1) * rowsPerPage;

      final tableRows = <pw.TableRow>[
        pw.TableRow(
          children: [
            pw.Container(
              padding: pw.EdgeInsets.all(5),
              child: pw.Text('PIN',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            pw.Container(
              padding: pw.EdgeInsets.all(5),
              child: pw.Text('Nama',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            pw.Container(
              padding: pw.EdgeInsets.all(5),
              child: pw.Text('Jabatan',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            pw.Container(
              padding: pw.EdgeInsets.all(5),
              child: pw.Text('Tanggal',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            pw.Container(
              padding: pw.EdgeInsets.all(5),
              child: pw.Text('Scan Masuk',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            pw.Container(
              padding: pw.EdgeInsets.all(5),
              child: pw.Text('Scan Keluar',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
          ],
        ),
        for (var i = startRow; i < endRow && i < groupedData.length; i++)
          pw.TableRow(
            children: [
              pw.Container(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text(groupedData[i].pin!,
                    style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text(
                    kepegawaianData
                        .firstWhere((kepegawaian) =>
                            kepegawaian.pin == groupedData[i].pin)
                        .nama!,
                    style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text(
                    kepegawaianData
                        .firstWhere((kepegawaian) =>
                            kepegawaian.pin == groupedData[i].pin)
                        .bidang!,
                    style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text(
                    dateFormatter.format(groupedData[i].dateTimeMasuk!),
                    style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text(
                  formatterTime.format(groupedData[i].dateTimeMasuk!),
                  style: pw.TextStyle(fontSize: 10),
                ),
              ),
              pw.Container(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text(
                  formatterTime.format(groupedData[i].dateTimeKeluar!),
                  style: pw.TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
      ];

      pdf.addPage(
        pw.Page(
          orientation: pw.PageOrientation.landscape,
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Kartu Scanlog', style: pw.TextStyle(fontSize: 12)),
              pw.Text('PIN: $pin', style: pw.TextStyle(fontSize: 10)),
              pw.Text(
                'Tanggal: ${dateFormatter.format(start!).toString()} - ${dateFormatter.format(end.value).toString()}',
                style: pw.TextStyle(fontSize: 10),
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                columnWidths: {
                  0: pw.FixedColumnWidth(50),
                  1: pw.FixedColumnWidth(100),
                  2: pw.FixedColumnWidth(100),
                  3: pw.FixedColumnWidth(100),
                  4: pw.FixedColumnWidth(100),
                  5: pw.FixedColumnWidth(100),
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
          'Rekapitulasi Scanlog PIN ${pin} (${dateFormatter.format(start!).toString()} - ${dateFormatter.format(end.value).toString()}).pdf';

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
              isLessThan: end.value.add(Duration(days: 1)).toIso8601String())
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

    final int rowsPerPage = 18;

    final totalPages = (groupedData.length / rowsPerPage).ceil();

    for (var pageIndex = 0; pageIndex < totalPages; pageIndex++) {
      final startRow = pageIndex * rowsPerPage;
      final endRow = (pageIndex + 1) * rowsPerPage;

      final tableRows = <pw.TableRow>[
        pw.TableRow(
          children: [
            pw.Container(
              padding: pw.EdgeInsets.all(5),
              child: pw.Text('PIN',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            pw.Container(
              padding: pw.EdgeInsets.all(5),
              child: pw.Text('Nama',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            pw.Container(
              padding: pw.EdgeInsets.all(5),
              child: pw.Text('Jabatan',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            pw.Container(
              padding: pw.EdgeInsets.all(5),
              child: pw.Text('Tanggal',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            pw.Container(
              padding: pw.EdgeInsets.all(5),
              child: pw.Text('Scan Masuk',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
            pw.Container(
              padding: pw.EdgeInsets.all(5),
              child: pw.Text('Scan Keluar',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ),
          ],
        ),
        for (var i = startRow; i < endRow && i < groupedData.length; i++)
          pw.TableRow(
            children: [
              pw.Container(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text(groupedData[i].pin!,
                    style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text(
                    kepegawaianData
                        .firstWhere((kepegawaian) =>
                            kepegawaian.pin == groupedData[i].pin)
                        .nama!,
                    style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text(
                    kepegawaianData
                        .firstWhere((kepegawaian) =>
                            kepegawaian.pin == groupedData[i].pin)
                        .bidang!,
                    style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text(
                    dateFormatter.format(groupedData[i].dateTimeMasuk!),
                    style: pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text(
                  formatterTime.format(groupedData[i].dateTimeMasuk!),
                  style: pw.TextStyle(fontSize: 10),
                ),
              ),
              pw.Container(
                padding: pw.EdgeInsets.all(5),
                child: pw.Text(
                  formatterTime.format(groupedData[i].dateTimeKeluar!),
                  style: pw.TextStyle(fontSize: 10),
                ),
              ),
            ],
          ),
      ];

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          orientation: pw.PageOrientation.landscape,
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Kartu Scanlog', style: pw.TextStyle(fontSize: 12)),
              pw.Text('PIN: $pin', style: pw.TextStyle(fontSize: 10)),
              pw.Text(
                'Tanggal: ${dateFormatter.format(start!).toString()} - ${dateFormatter.format(end.value).toString()}',
                style: pw.TextStyle(fontSize: 10),
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                columnWidths: {
                  0: pw.FixedColumnWidth(50),
                  1: pw.FixedColumnWidth(100),
                  2: pw.FixedColumnWidth(100),
                  3: pw.FixedColumnWidth(100),
                  4: pw.FixedColumnWidth(100),
                  5: pw.FixedColumnWidth(100),
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
    pdfBytes.value = bytes;
    pdfURL.value = url;
    print(pdfURL);
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
    pdfViewerController.dispose();
  }
}
