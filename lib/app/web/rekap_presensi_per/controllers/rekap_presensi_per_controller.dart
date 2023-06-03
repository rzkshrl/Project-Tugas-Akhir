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

import '../../../data/models/firestorejamkerjamodel.dart';
import '../../../data/models/firestorescanlogmodel.dart';
import '../../../utils/textfield.dart';

class RekapPresensiPerController extends GetxController {
  late Stream<List<KepegawaianModel>> firestoreKepegawaianList;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<KepegawaianModel> kepegawaianList = [];
  List<JamKerjaModel> jamKerjaList = [];
  List<String> keterlambatanList = [];
  List<String> pulangLebihAwalList = [];
  List<GroupedPresensiModel> presensiList = [];
  var pinList = <String>[].obs;
  var namaList = <String>[].obs;
  final isClicked = false.obs;

  var totalKeterlambatan = Duration.zero.obs;
  var totalPulangLebihAwal = Duration.zero.obs;
  DateFormat formatter = DateFormat('HH:mm');

  final pdfURL = "".obs;

  final pdfBytes = Rx<Uint8List?>(null);

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

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  DateTime _parseTime(String time, DateTime date) {
    var parts = time.split(':');
    var hour = int.parse(parts[0]);
    var minute = int.parse(parts[1]);

    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  String _formatDuration(Duration duration) {
    var hours = duration.inHours.toString().padLeft(2, '0');
    var minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');

    return '$hours:$minutes';
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");

    String hours = twoDigits(duration.inHours.remainder(60));
    String minutes = twoDigits(duration.inMinutes.remainder(60));

    return "$hours:$minutes";
  }

  void calculatePresensi() {
    for (int i = 0; i < presensiList.length; i++) {
      GroupedPresensiModel presensi = presensiList[i];
      JamKerjaModel jamKerja = jamKerjaList[i];

      DateTime masuk = presensi.dateTimeMasuk!;
      DateTime keluar = presensi.dateTimeKeluar!;

      DateTime jadwalMasuk = DateTime.parse(jamKerja.jadwalMasuk!);
      DateTime jadwalKeluar = DateTime.parse(jamKerja.jadwalKeluar!);

      // Hitung keterlambatan
      Duration keterlambatan = masuk.difference(jadwalMasuk);
      String keterlambatanFormatted = formatDuration(keterlambatan);
      keterlambatanList.add(keterlambatanFormatted);

      // Hitung pulang lebih awal
      Duration pulangLebihAwal = jadwalKeluar.difference(keluar);
      String pulangLebihAwalFormatted = formatDuration(pulangLebihAwal);
      pulangLebihAwalList.add(pulangLebihAwalFormatted);
    }
  }

  Future<void> unduhPDF(String pin) async {
    final QuerySnapshot<Map<String, dynamic>> presensiSnapshot;
    final QuerySnapshot<Map<String, dynamic>> jamKerjaSnapshot;

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

    var kepgData =
        kepegawaianData.firstWhere((kepegawaian) => kepegawaian.pin == pin);

    jamKerjaSnapshot = await firestore.collection('JamKerja').get();

    jamKerjaList = jamKerjaSnapshot.docs
        .map((doc) => JamKerjaModel.fromJson(doc))
        .toList();

    List<GroupedPresensiModel> groupedData = groupAttendanceData(presensiData);

    List<GroupedPresensiModel> combinedData = [];

    for (DateTime date = start!;
        date.isBefore(end.value) || isSameDay(date, end.value);
        date = date.add(const Duration(days: 1))) {
      if (date.weekday == DateTime.sunday) {
        continue;
      }
      bool isPresensiExist = false;

      for (var presensi in groupedData) {
        if (presensi.dateTimeMasuk != null &&
            isSameDay(presensi.dateTimeMasuk!, date)) {
          combinedData.add(presensi);
          isPresensiExist = true;
          break;
        }
      }

      if (!isPresensiExist) {
        combinedData.add(GroupedPresensiModel(
          pin: pin,
          dateTimeMasuk: DateTime(date.year, date.month, date.day),
          dateTimeKeluar: DateTime(date.year, date.month, date.day),
        ));
      }
    }

    final jamKerja = jamKerjaList
        .firstWhere((jamKerja) => jamKerja.kepg == kepgData.kepegawaian);

    // for (var presensi in combinedData) {
    //   if (presensi.dateTimeMasuk != null && presensi.dateTimeKeluar != null) {
    //     // Hitung keterlambatan
    //     if (presensi.dateTimeMasuk!.isAfter(
    //         _parseTime(jamKerja.batasAwalMasuk!, presensi.dateTimeMasuk!))) {
    //       // Keterlambatan dalam bentuk Durasi
    //       Duration keterlambatan = presensi.dateTimeMasuk!.difference(
    //           _parseTime(jamKerja.jadwalMasuk!, presensi.dateTimeMasuk!));
    //       presensi.keterlambatan = _formatDuration(keterlambatan);
    //     }

    //     // Hitung pulang lebih awal
    //     if (presensi.dateTimeKeluar!.isBefore(
    //         _parseTime(jamKerja.batasAwalKeluar!, presensi.dateTimeKeluar!))) {
    //       // Pulang lebih awal dalam bentuk Durasi
    //       Duration pulangLebihAwal =
    //           _parseTime(jamKerja.jadwalKeluar!, presensi.dateTimeKeluar!)
    //               .difference(presensi.dateTimeKeluar!);
    //       presensi.pulangLebihAwal = _formatDuration(pulangLebihAwal);
    //     }

    //     var jadwalMasuk = formatter.parse(jamKerja.jadwalMasuk!);
    //     var jadwalKeluar = formatter.parse(jamKerja.jadwalKeluar!);

    //     final durasiKerja = jadwalKeluar.difference(jadwalMasuk);
    //     final durasiPresensi =
    //         presensi.dateTimeKeluar!.difference(presensi.dateTimeMasuk!);

    //     if (durasiPresensi > durasiKerja) {
    //       final keterlambatan = durasiPresensi - durasiKerja;
    //       totalKeterlambatan.value += keterlambatan;
    //     } else if (durasiPresensi < durasiKerja) {
    //       final pulangLebihAwal = durasiKerja - durasiPresensi;
    //       totalPulangLebihAwal.value += pulangLebihAwal;
    //     }

    //   }
    // }

    // final totalKeterlambatanHours =
    //     totalKeterlambatan.value.inHours.toString().padLeft(2, '0');
    // final totalKeterlambatanMinutes =
    //     (totalKeterlambatan.value.inMinutes % 60).toString().padLeft(2, '0');

    // final totalPulangLebihAwalHours =
    //     totalPulangLebihAwal.value.inHours.toString().padLeft(2, '0');
    // final totalPulangLebihAwalMinutes =
    //     (totalPulangLebihAwal.value.inMinutes % 60).toString().padLeft(2, '0');

    // print('$totalKeterlambatanHours:$totalKeterlambatanMinutes');
    // print('$totalPulangLebihAwalHours:$totalPulangLebihAwalMinutes');

    calculatePresensi();

    final pdf = pw.Document();
    var formatterTime = DateFormat('HH:mm', 'id-ID');

    const int rowsPerPage = 18;

    final totalPages = (combinedData.length / rowsPerPage).ceil();

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
                      fontWeight: pw.FontWeight.bold, fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Tanggal',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Jam Kerja/Shift',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Jam Masuk',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Scan Masuk',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Keterlambatan',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Jam Keluar',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Scan Keluar',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Pulang Lebih Awal',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Durasi Kerja',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text('Keterangan',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 6)),
            ),
          ],
        ),
        for (var i = startRow; i < endRow && i < combinedData.length; i++)
          pw.TableRow(
            children: [
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text("${i + 1}.",
                    style: const pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                    dateFormatter.format(combinedData[i].dateTimeMasuk!),
                    style: const pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text("", style: const pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text("", style: const pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                  formatterTime.format(combinedData[i].dateTimeMasuk!),
                  style: const pw.TextStyle(fontSize: 10),
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(keterlambatanList[i],
                    style: const pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text("", style: const pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                  formatterTime.format(combinedData[i].dateTimeKeluar!),
                  style: const pw.TextStyle(fontSize: 10),
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text(
                  pulangLebihAwalList[i],
                  style: const pw.TextStyle(fontSize: 10),
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text("", style: const pw.TextStyle(fontSize: 10)),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(5),
                child: pw.Text("", style: const pw.TextStyle(fontSize: 10)),
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
              pw.Center(
                  child: pw.Text('LAPORAN RINCIAN HARIAN',
                      style: pw.TextStyle(
                          fontSize: 12, fontWeight: pw.FontWeight.bold))),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Nama Madrasah: MIM JETIS LOR',
                        style: pw.TextStyle(
                            fontSize: 6, fontWeight: pw.FontWeight.bold)),
                    pw.Text(
                      'Tanggal: ${dateFormatter.format(start!).toString()} - ${dateFormatter.format(end.value).toString()}',
                      style: pw.TextStyle(
                          fontSize: 6, fontWeight: pw.FontWeight.bold),
                    ),
                  ]),
              pw.SizedBox(height: 10),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Text('PIN: $pin',
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Text('NIP: ${kepgData.nip!}',
                              style: const pw.TextStyle(fontSize: 6)),
                        ]),
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text('Nama: ${kepgData.nama!}',
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Text('Jabatan: ${kepgData.bidang!}',
                              style: const pw.TextStyle(fontSize: 6)),
                        ]),
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Text('Kepegawaian: ${kepgData.kepegawaian!}',
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Text('Madrasah: MIM JETIS LOR',
                              style: const pw.TextStyle(fontSize: 6)),
                        ]),
                  ]),
              pw.SizedBox(height: 10),
              pw.Table(
                // columnWidths: {
                //   0: const pw.FixedColumnWidth(20),
                //   1: const pw.FixedColumnWidth(60),
                //   2: const pw.FixedColumnWidth(60),
                //   3: const pw.FixedColumnWidth(50),
                //   4: const pw.FixedColumnWidth(50),
                //   5: const pw.FixedColumnWidth(52),
                //   6: const pw.FixedColumnWidth(50),
                //   7: const pw.FixedColumnWidth(50),
                //   8: const pw.FixedColumnWidth(50),
                //   9: const pw.FixedColumnWidth(50),
                //   10: const pw.FixedColumnWidth(50),
                // },
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
          'Laporan Presensi PIN $pin (${dateFormatter.format(start!).toString()} - ${dateFormatter.format(end.value).toString()}).pdf';

    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
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
  }
}
