// ignore_for_file: unnecessary_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:universal_html/html.dart' as html;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../data/models/firestorehariliburmodel.dart';
import '../../../data/models/firestorejamkerjamodel.dart';
import '../../../data/models/firestorepengecualianmodel.dart';
import '../../../data/models/firestorescanlogmodel.dart';
import '../../../utils/fungsiRekap.dart';
import '../../../utils/textfield.dart';

class RekapPresensiAllController extends GetxController {
  DateTime? start;
  final end = DateTime.now().obs;
  final dateFormatter = DateFormat('d MMMM yyyy', 'id-ID');
  final datedFormatter = DateFormat('d MMMM yyyy', 'id-ID');
  final dateMMMMFormatter = DateFormat('d MMMM yyyy', 'id-ID');
  final formatter = DateFormat('HH:mm');
  var formatterTime = DateFormat('HH:mm', 'id-ID');

  final isClicked = false.obs;
  final pdfURL = "".obs;
  final pdfBytes = Rx<Uint8List?>(null);
  final pdfPreview = pw.Document();
  final pdf = pw.Document();

  // final pdfViewController = PdfViewerController();

  // void rotateLeft() {
  //   pdfViewController.rotateLeft();
  // }

  // void rotateRight() {
  //   pdfViewController.rotateRight();
  // }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  int totalKeterlambatan = 0;
  int totalPulangLebihAwal = 0;
  int totalPerhitunganKetidakhadiran = 0;

  List<KepegawaianModel> kepegawaianList = [];
  List<JamKerjaModel> jamKerjaList = [];
  List<HolidayModel> holidayList = [];
  List<PengecualianModel> pengecualianList = [];
  List<PengecualianIterableModel> pengecualianRangeList = [];
  List<String> keterlambatanList = [];
  List<String> pulangLebihAwalList = [];
  List<String> durasiKerjaList = [];

  int totalKeterlambatanInMinutes = 0;
  int totalPulangLebihAwalInMinutes = 0;
  int totalDurasiPresensiInMinutes = 0;

  void pickRangeDate(DateTime pickStart, DateTime pickEnd) {
    start = pickStart;
    end.value = pickEnd;
    update();
    var startFormatted = dateFormatter.format(start!);
    var endFormatted = dateFormatter.format(end.value);
    textC.datepickerC.text = '$startFormatted - $endFormatted';
  }

  void hitungKeterlambatanPulangLebihAwal(
      List<GroupedPresensiModel> presensiList, KepegawaianModel kepgData) {
    keterlambatanList.clear();
    pulangLebihAwalList.clear();

    for (var presensi in presensiList) {
      JamKerjaModel jamKerja;
      var hari = DateFormat.EEEE('id_ID').format(presensi.dateTimeMasuk!);

      try {
        jamKerja = jamKerjaList.firstWhere(
          (jk) => jk.hariKerja == hari && jk.kepg == kepgData.kepegawaian,
        );
      } catch (e) {
        if (kDebugMode) {
          print("JamKerjaModel tidak ditemukan");
        }
        return;
      }

      // ignore: unnecessary_null_comparison
      if (jamKerja != null) {
        var jadwalMasuk = DateTime.parse(
            "${presensi.dateTimeMasuk?.toIso8601String().substring(0, 10)} ${jamKerja.jadwalMasuk}");
        var jadwalKeluar = DateTime.parse(
            "${presensi.dateTimeKeluar?.toIso8601String().substring(0, 10)} ${jamKerja.jadwalKeluar}");

        if (presensi.dateTimeMasuk != null &&
            presensi.dateTimeMasuk!.hour != 0 &&
            presensi.dateTimeMasuk!.minute != 0 &&
            presensi.dateTimeMasuk!.isAfter(jadwalMasuk)) {
          var keterlambatan = presensi.dateTimeMasuk!.difference(jadwalMasuk);
          var keterlambatanInMinutes = keterlambatan.inMinutes;
          var keterlambatanFormatted =
              "${keterlambatan.inHours.toString().padLeft(2, '0')}:${keterlambatan.inMinutes.remainder(60).toString().padLeft(2, '0')}";
          keterlambatanList.add(keterlambatanFormatted);
          totalKeterlambatanInMinutes += keterlambatanInMinutes;
          // totalKeterlambatan += keterlambatan;
        } else if (presensi.dateTimeMasuk!.hour == 0 &&
            presensi.dateTimeMasuk!.minute == 0) {
          keterlambatanList.add("00:00");
        } else {
          keterlambatanList.add("00:00");
        }

        if (presensi.dateTimeKeluar != null &&
            presensi.dateTimeKeluar!.minute != 0 &&
            presensi.dateTimeKeluar!.hour != 0 &&
            presensi.dateTimeKeluar!.isBefore(jadwalKeluar)) {
          var pulangLebihAwal =
              jadwalKeluar.difference(presensi.dateTimeKeluar!);
          var pulangLebihAwalInMinutes = pulangLebihAwal.inMinutes;
          var pulangLebihAwalFormatted =
              "${pulangLebihAwal.inHours.toString().padLeft(2, '0')}:${pulangLebihAwal.inMinutes.remainder(60).toString().padLeft(2, '0')}";
          pulangLebihAwalList.add(pulangLebihAwalFormatted);
          totalPulangLebihAwalInMinutes += pulangLebihAwalInMinutes;
          // totalPulangLebihAwal += pulangLebihAwal;
        } else if (presensi.dateTimeKeluar!.hour == 0 &&
            presensi.dateTimeKeluar!.minute == 0) {
          pulangLebihAwalList.add("00:00");
        } else {
          pulangLebihAwalList.add("00:00");
        }
      } else {
        keterlambatanList.add("00:00");
        pulangLebihAwalList.add("00:00");
      }
    }
  }

  Future<void> unduhPDF() async {
    QuerySnapshot<Map<String, dynamic>> presensiSnapshot;
    QuerySnapshot<Map<String, dynamic>> jamKerjaSnapshot;
    QuerySnapshot<Map<String, dynamic>> holidaySnapshot;
    QuerySnapshot<Map<String, dynamic>> pengecualianSnapshot;
    QuerySnapshot<Map<String, dynamic>> kepegawaianSnapshot;
    DocumentSnapshot<Map<String, dynamic>> pegawaiSnap;

    kepegawaianSnapshot = await firestore.collection('Kepegawaian').get();
    jamKerjaSnapshot = await firestore.collection('JamKerja').get();
    holidaySnapshot = await firestore.collection('Holiday').get();
    pengecualianSnapshot = await firestore.collection('Pengecualian').get();

    jamKerjaList = jamKerjaSnapshot.docs
        .map((doc) => JamKerjaModel.fromJson(doc))
        .toList();

    holidayList =
        holidaySnapshot.docs.map((doc) => HolidayModel.fromJson(doc)).toList();

    pengecualianList = pengecualianSnapshot.docs
        .map((doc) => PengecualianModel.fromJson(doc))
        .toList();

    PengecualianModel pengecualianData = pengecualianList.firstWhere(
        (pengecualian) =>
            pengecualian.statusPengecualian == 'Ya' &&
            pengecualian.dateStart!.year == start!.year &&
            pengecualian.dateEnd!.year == start!.year);

    final tableRows = <pw.TableRow>[
      pw.TableRow(
        children: [
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text('NO.',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text('NAMA',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text('NIP',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text('JABATAN',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Center(
                    child: pw.Text('KETIDAKHADIRAN',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 8))),
                pw.Divider(thickness: 1, color: PdfColors.grey),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Center(
                        child: pw.Text('TL',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 8))),
                    pw.SizedBox(height: 6),
                    pw.Center(
                        child: pw.Text('PSW',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 8))),
                    pw.SizedBox(height: 12),
                    pw.Center(
                        child: pw.Text('TK',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 8))),
                  ],
                ),
              ],
            ),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text('JUMLAH HADIR',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text('KETERANGAN',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
          ),
        ],
      ),
    ];
    int rowNumber = 1;

    for (pegawaiSnap in kepegawaianSnapshot.docs) {
      final String pin = pegawaiSnap.id;

      final KepegawaianModel kepegawaianModel =
          KepegawaianModel.fromSnapshot(pegawaiSnap);

      List<KepegawaianModel> kepegawaianData = [kepegawaianModel];

      var kepgData =
          kepegawaianData.firstWhere((kepegawaian) => kepegawaian.pin == pin);

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

      List<PresensiModel> presensiData = presensiSnapshot.docs
          .map((e) => PresensiModel.fromJson(e.data()))
          .toList();

      List<GroupedPresensiModel> groupedData =
          groupAttendanceData(presensiData);

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

      // final totalPages = (combinedData.length / rowsPerPage).ceil();
      final int totalPresensi = combinedData.length;
      int hadirCountHoliday = 0;
      int tidakHadirCount = 0;

      // for (var pageIndex = 0; pageIndex < totalPages; pageIndex++) {
      //   final startRow = pageIndex * rowsPerPage;
      //   final endRow = (pageIndex + 1) * rowsPerPage;

      for (var i = 0; i < combinedData.length; i++) {
        hitungKeterlambatanPulangLebihAwal(combinedData, kepgData);

        var durasiPresensi = combinedData[i]
            .dateTimeKeluar!
            .difference(combinedData[i].dateTimeMasuk!);

        var durasiPresensiFormatted =
            "${durasiPresensi.inHours.toString().padLeft(2, '0')}:${durasiPresensi.inMinutes.remainder(60).toString().padLeft(2, '0')}";

        durasiKerjaList.add(durasiPresensiFormatted);
        var date =
            combinedData[i].dateTimeMasuk!.toIso8601String().split('T')[0];

        generateDateRangePengecualian(pengecualianRangeList, pengecualianData);

        HolidayModel? holiday;
        for (var h in holidayList) {
          if (h.date == date) {
            holiday = h;
            break;
          }
        }
        var dateTimePresensi = combinedData[i].dateTimeMasuk!;
        PengecualianIterableModel? pengecualian;
        for (var p in pengecualianRangeList) {
          if (p.date == dateTimePresensi) {
            pengecualian = p;
            break;
          }
        }

        if (pengecualian != null && holiday == null) {
        } else if (pengecualian == null && holiday != null) {
        } else if (pengecualian != null && holiday != null) {}

        var isHolidayPengecualian = pengecualianRangeList.any((pengecualian) =>
            pengecualian.date == dateTimePresensi &&
            kepgData.kepegawaian == "NON-PNS");
        var isHoliday = holidayList.any((holiday) => holiday.date == date);

        var isAbsen = !isHoliday &&
            !isHolidayPengecualian &&
            combinedData[i].dateTimeMasuk!.hour == 0 &&
            combinedData[i].dateTimeMasuk!.minute == 0 &&
            combinedData[i].dateTimeKeluar!.hour == 0 &&
            combinedData[i].dateTimeKeluar!.minute == 0;

        if (isHoliday && isHolidayPengecualian) {
          hadirCountHoliday++;
        } else if (isAbsen) {
          tidakHadirCount++;
        }
      }

      if (kDebugMode) {
        print('hadirCount: ${groupedData.length}');
        print('hadirCountHoliday: $hadirCountHoliday');
        print('tidakHadirCount: $tidakHadirCount');
        print('totalPresensi: $totalPresensi');
      }

      double persentaseKehadiran = (tidakHadirCount / totalPresensi) * 100;

      if (persentaseKehadiran > 100) {}

      var totalKeterlambatanFormatted = hitungTotal(keterlambatanList);
      var totalPulangLebihAwalFormatted = hitungTotal(pulangLebihAwalList);

      var totalKeterlambatanSplit =
          '${totalKeterlambatanFormatted.split(':')[0]}j, ${totalKeterlambatanFormatted.split(':')[1]}m';
      var totalPulangLebihAwalSplit =
          '${totalPulangLebihAwalFormatted.split(':')[0]}j, ${totalPulangLebihAwalFormatted.split(':')[1]}m';

      var isKetidakhadiranNull = totalKeterlambatanSplit == '00j, 00m' &&
          totalPulangLebihAwalSplit == '00j, 00m' &&
          tidakHadirCount == 0;

      tableRows.add(pw.TableRow(
        children: [
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child:
                pw.Text('$rowNumber', style: const pw.TextStyle(fontSize: 8)),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text('${kepgData.nama}',
                style: const pw.TextStyle(fontSize: 8)),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text('${kepgData.nip}',
                style: const pw.TextStyle(fontSize: 8)),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text('${kepgData.bidang}',
                style: const pw.TextStyle(fontSize: 8)),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Center(
                        child: pw.Text(totalKeterlambatanSplit,
                            style: const pw.TextStyle(fontSize: 8))),
                    pw.Center(
                        child: pw.Text(totalPulangLebihAwalSplit,
                            style: const pw.TextStyle(fontSize: 8))),
                    pw.Center(
                        child: pw.Text(tidakHadirCount.toString(),
                            style: const pw.TextStyle(fontSize: 8))),
                  ],
                ),
              ],
            ),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text((groupedData.length + hadirCountHoliday).toString(),
                style: const pw.TextStyle(fontSize: 8)),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text(isKetidakhadiranNull ? 'Nihil' : '',
                style: const pw.TextStyle(fontSize: 8)),
          ),
        ],
      ));
      rowNumber++; // }
    }
    var yearTitle = end.value.year.toString();

    pdf.addPage(pw.Page(
        orientation: pw.PageOrientation.landscape,
        pageFormat: PdfPageFormat.a4.landscape,
        build: (pw.Context context) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Center(
                      child: pw.Text('REKAP AKUMULASI KEHADIRAN',
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold))),
                  pw.Center(
                      child: pw.Text('KANTOR KEMENTERIAN AGAMA KAB. PACITAN',
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold))),
                  pw.Center(
                      child: pw.Text('TAHUN $yearTitle',
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold))),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('UNIT KERJA: GURU MIM JETIS LOR',
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: pw.FontWeight.bold)),
                        pw.Column(children: [
                          pw.Text(
                              'BULAN : ${dateMMMMFormatter.format(start!).toString()}',
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Text(
                            '(Periode tgl ${datedFormatter.format(start!).toString()} s.d ${dateFormatter.format(end.value).toString()})',
                            style: pw.TextStyle(
                                fontSize: 8, fontWeight: pw.FontWeight.normal),
                          ),
                        ])
                      ]),
                  pw.SizedBox(height: 10),
                  pw.Table(
                    border: pw.TableBorder.all(color: PdfColors.grey),
                    children: tableRows,
                  ),
                  pw.SizedBox(height: 55),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Center(
                                  child: pw.Text('KEPALA MADRASAH',
                                      style: pw.TextStyle(
                                          fontSize: 10,
                                          fontWeight: pw.FontWeight.normal))),
                              pw.SizedBox(height: 50),
                              pw.Center(
                                  child: pw.Text('Sagiman, S.PdI',
                                      style: pw.TextStyle(
                                          fontSize: 10,
                                          fontWeight: pw.FontWeight.normal))),
                            ]),
                        pw.SizedBox(width: 20),
                      ])
                ])));

    final bytes = await pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download =
          'REKAP AKUMULASI KEHADIRAN Tanggal (${dateFormatter.format(start!).toString()} - ${dateFormatter.format(end.value).toString()}).pdf';

    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  Future<void> previewPDF() async {
    isClicked.value = true;
    update();
    QuerySnapshot<Map<String, dynamic>> presensiSnapshot;
    QuerySnapshot<Map<String, dynamic>> jamKerjaSnapshot;
    QuerySnapshot<Map<String, dynamic>> holidaySnapshot;
    QuerySnapshot<Map<String, dynamic>> pengecualianSnapshot;
    QuerySnapshot<Map<String, dynamic>> kepegawaianSnapshot;
    DocumentSnapshot<Map<String, dynamic>> pegawaiSnap;

    kepegawaianSnapshot = await firestore.collection('Kepegawaian').get();
    jamKerjaSnapshot = await firestore.collection('JamKerja').get();
    holidaySnapshot = await firestore.collection('Holiday').get();
    pengecualianSnapshot = await firestore.collection('Pengecualian').get();

    jamKerjaList = jamKerjaSnapshot.docs
        .map((doc) => JamKerjaModel.fromJson(doc))
        .toList();

    holidayList =
        holidaySnapshot.docs.map((doc) => HolidayModel.fromJson(doc)).toList();

    pengecualianList = pengecualianSnapshot.docs
        .map((doc) => PengecualianModel.fromJson(doc))
        .toList();

    PengecualianModel pengecualianData = pengecualianList.firstWhere(
        (pengecualian) =>
            pengecualian.statusPengecualian == 'Ya' &&
            pengecualian.dateStart!.year == start!.year &&
            pengecualian.dateEnd!.year == start!.year);

    final tableRows = <pw.TableRow>[
      pw.TableRow(
        children: [
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text('NO.',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text('NAMA',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text('NIP',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text('JABATAN',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Center(
                    child: pw.Text('KETIDAKHADIRAN',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 8))),
                pw.Divider(thickness: 1, color: PdfColors.grey),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Center(
                        child: pw.Text('TL',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 8))),
                    pw.SizedBox(height: 6),
                    pw.Center(
                        child: pw.Text('PSW',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 8))),
                    pw.SizedBox(height: 12),
                    pw.Center(
                        child: pw.Text('TK',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold, fontSize: 8))),
                  ],
                ),
              ],
            ),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text('JUMLAH HADIR',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text('KETERANGAN',
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 8)),
          ),
        ],
      ),
    ];
    int rowNumber = 1;

    for (pegawaiSnap in kepegawaianSnapshot.docs) {
      final String pin = pegawaiSnap.id;

      final KepegawaianModel kepegawaianModel =
          KepegawaianModel.fromSnapshot(pegawaiSnap);

      List<KepegawaianModel> kepegawaianData = [kepegawaianModel];

      var kepgData =
          kepegawaianData.firstWhere((kepegawaian) => kepegawaian.pin == pin);

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

      List<PresensiModel> presensiData = presensiSnapshot.docs
          .map((e) => PresensiModel.fromJson(e.data()))
          .toList();

      List<GroupedPresensiModel> groupedData =
          groupAttendanceData(presensiData);

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

      // final totalPages = (combinedData.length / rowsPerPage).ceil();
      final int totalPresensi = combinedData.length;
      int hadirCountHoliday = 0;
      int tidakHadirCount = 0;

      // for (var pageIndex = 0; pageIndex < totalPages; pageIndex++) {
      //   final startRow = pageIndex * rowsPerPage;
      //   final endRow = (pageIndex + 1) * rowsPerPage;

      for (var i = 0; i < combinedData.length; i++) {
        hitungKeterlambatanPulangLebihAwal(combinedData, kepgData);

        var durasiPresensi = combinedData[i]
            .dateTimeKeluar!
            .difference(combinedData[i].dateTimeMasuk!);

        var durasiPresensiFormatted =
            "${durasiPresensi.inHours.toString().padLeft(2, '0')}:${durasiPresensi.inMinutes.remainder(60).toString().padLeft(2, '0')}";

        durasiKerjaList.add(durasiPresensiFormatted);
        var date =
            combinedData[i].dateTimeMasuk!.toIso8601String().split('T')[0];

        generateDateRangePengecualian(pengecualianRangeList, pengecualianData);

        HolidayModel? holiday;
        for (var h in holidayList) {
          if (h.date == date) {
            holiday = h;
            break;
          }
        }
        var dateTimePresensi = combinedData[i].dateTimeMasuk!;
        PengecualianIterableModel? pengecualian;
        for (var p in pengecualianRangeList) {
          if (p.date == dateTimePresensi) {
            pengecualian = p;
            break;
          }
        }

        if (pengecualian != null && holiday == null) {
        } else if (pengecualian == null && holiday != null) {
        } else if (pengecualian != null && holiday != null) {}

        var isHolidayPengecualian = pengecualianRangeList.any((pengecualian) =>
            pengecualian.date == dateTimePresensi &&
            kepgData.kepegawaian == "NON-PNS");
        var isHoliday = holidayList.any((holiday) => holiday.date == date);

        var isAbsen = !isHoliday &&
            !isHolidayPengecualian &&
            combinedData[i].dateTimeMasuk!.hour == 0 &&
            combinedData[i].dateTimeMasuk!.minute == 0 &&
            combinedData[i].dateTimeKeluar!.hour == 0 &&
            combinedData[i].dateTimeKeluar!.minute == 0;

        if (isHoliday && isHolidayPengecualian) {
          hadirCountHoliday++;
        } else if (isAbsen) {
          tidakHadirCount++;
        }
      }

      if (kDebugMode) {
        print('hadirCount: ${groupedData.length}');
        print('hadirCountHoliday: $hadirCountHoliday');
        print('tidakHadirCount: $tidakHadirCount');
        print('totalPresensi: $totalPresensi');
      }

      double persentaseKehadiran = (tidakHadirCount / totalPresensi) * 100;

      if (persentaseKehadiran > 100) {}

      var totalKeterlambatanFormatted = hitungTotal(keterlambatanList);
      var totalPulangLebihAwalFormatted = hitungTotal(pulangLebihAwalList);

      var totalKeterlambatanSplit =
          '${totalKeterlambatanFormatted.split(':')[0]}j, ${totalKeterlambatanFormatted.split(':')[1]}m';
      var totalPulangLebihAwalSplit =
          '${totalPulangLebihAwalFormatted.split(':')[0]}j, ${totalPulangLebihAwalFormatted.split(':')[1]}m';

      var isKetidakhadiranNull = totalKeterlambatanSplit == '00j, 00m' &&
          totalPulangLebihAwalSplit == '00j, 00m' &&
          tidakHadirCount == 0;

      tableRows.add(pw.TableRow(
        children: [
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child:
                pw.Text('$rowNumber', style: const pw.TextStyle(fontSize: 8)),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text('${kepgData.nama}',
                style: const pw.TextStyle(fontSize: 8)),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text('${kepgData.nip}',
                style: const pw.TextStyle(fontSize: 8)),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text('${kepgData.bidang}',
                style: const pw.TextStyle(fontSize: 8)),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Center(
                        child: pw.Text(totalKeterlambatanSplit,
                            style: const pw.TextStyle(fontSize: 8))),
                    pw.Center(
                        child: pw.Text(totalPulangLebihAwalSplit,
                            style: const pw.TextStyle(fontSize: 8))),
                    pw.Center(
                        child: pw.Text(tidakHadirCount.toString(),
                            style: const pw.TextStyle(fontSize: 8))),
                  ],
                ),
              ],
            ),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text((groupedData.length + hadirCountHoliday).toString(),
                style: const pw.TextStyle(fontSize: 8)),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.all(5),
            child: pw.Text(isKetidakhadiranNull ? 'Nihil' : '',
                style: const pw.TextStyle(fontSize: 8)),
          ),
        ],
      ));
      rowNumber++; // }
    }
    var yearTitle = end.value.year.toString();

    pdfPreview.addPage(pw.Page(
        orientation: pw.PageOrientation.landscape,
        pageFormat: PdfPageFormat.a4.landscape,
        build: (pw.Context context) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Center(
                      child: pw.Text('REKAP AKUMULASI KEHADIRAN',
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold))),
                  pw.Center(
                      child: pw.Text('KANTOR KEMENTERIAN AGAMA KAB. PACITAN',
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold))),
                  pw.Center(
                      child: pw.Text('TAHUN $yearTitle',
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold))),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('UNIT KERJA: GURU MIM JETIS LOR',
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: pw.FontWeight.bold)),
                        pw.Column(children: [
                          pw.Text(
                              'BULAN : ${dateMMMMFormatter.format(start!).toString()}',
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Text(
                            '(Periode tgl ${datedFormatter.format(start!).toString()} s.d ${dateFormatter.format(end.value).toString()})',
                            style: pw.TextStyle(
                                fontSize: 8, fontWeight: pw.FontWeight.normal),
                          ),
                        ])
                      ]),
                  pw.SizedBox(height: 10),
                  pw.Table(
                    border: pw.TableBorder.all(color: PdfColors.grey),
                    children: tableRows,
                  ),
                  pw.SizedBox(height: 55),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Center(
                                  child: pw.Text('KEPALA MADRASAH',
                                      style: pw.TextStyle(
                                          fontSize: 10,
                                          fontWeight: pw.FontWeight.normal))),
                              pw.SizedBox(height: 50),
                              pw.Center(
                                  child: pw.Text('Sagiman, S.PdI',
                                      style: pw.TextStyle(
                                          fontSize: 10,
                                          fontWeight: pw.FontWeight.normal))),
                            ]),
                        pw.SizedBox(width: 20),
                      ])
                ])));
    final bytes = await pdfPreview.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    pdfBytes.value = bytes;
    pdfURL.value = url;
    if (kDebugMode) {
      print(pdfURL);
    }
    update();
    // return await pdfPreview.save();
  }

  @override
  void onInit() {
    super.onInit();
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
