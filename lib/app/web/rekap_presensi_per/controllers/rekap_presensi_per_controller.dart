// ignore_for_file: unnecessary_overrides

import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:project_tugas_akhir/app/data/models/firestorehariliburmodel.dart';
import 'package:universal_html/html.dart' as html;

import '../../../data/models/firestorejamkerjamodel.dart';
import '../../../data/models/firestorepengecualianmodel.dart';
import '../../../data/models/firestorescanlogmodel.dart';
import '../../../utils/fungsiRekap.dart';
import '../../../utils/textfield.dart';

class RekapPresensiPerController extends GetxController {
  List<KepegawaianModel> kepegawaianList = [];
  List<JamKerjaModel> jamKerjaList = [];
  List<HolidayModel> holidayList = [];
  List<PengecualianModel> pengecualianList = [];
  List<PengecualianIterableModel> pengecualianRangeList = [];
  List<String> keterlambatanList = [];
  List<String> pulangLebihAwalList = [];
  List<String> durasiKerjaList = [];
  List<GroupedPresensiModel> presensiList = [];
  var pinList = <String>[].obs;
  var namaList = <String>[].obs;
  final isClicked = false.obs;

  RxList<DateTime> dateRangePengecualianList = RxList<DateTime>([]);

  // var totalKeterlambatan = const Duration(hours: 0, minutes: 0);
  // var totalPulangLebihAwal = const Duration(hours: 0, minutes: 0);
  // var totalDurasiPresensi = const Duration(hours: 0, minutes: 0);
  int totalKeterlambatanInMinutes = 0;
  int totalPulangLebihAwalInMinutes = 0;
  int totalDurasiPresensiInMinutes = 0;
  DateFormat formatter = DateFormat('HH:mm');

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

  Future<void> unduhPDF(String pin) async {
    final QuerySnapshot<Map<String, dynamic>> presensiSnapshot;
    final QuerySnapshot<Map<String, dynamic>> jamKerjaSnapshot;
    final QuerySnapshot<Map<String, dynamic>> holidaySnapshot;
    final QuerySnapshot<Map<String, dynamic>> pengecualianSnapshot;

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

    holidaySnapshot = await firestore.collection('Holiday').get();

    holidayList =
        holidaySnapshot.docs.map((doc) => HolidayModel.fromJson(doc)).toList();

    pengecualianSnapshot = await firestore.collection('Pengecualian').get();

    pengecualianList = pengecualianSnapshot.docs
        .map((doc) => PengecualianModel.fromJson(doc))
        .toList();

    PengecualianModel pengecualianData = pengecualianList.firstWhere(
        (pengecualian) =>
            pengecualian.statusPengecualian == 'Ya' &&
            pengecualian.dateStart!.year == start!.year &&
            pengecualian.dateEnd!.year == start!.year);

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

    final pdf = pw.Document();
    var formatterTime = DateFormat('HH:mm', 'id-ID');

    const int rowsPerPage = 24;

    final totalPages = (combinedData.length / rowsPerPage).ceil();

    final int totalPresensi = combinedData.length;
    int hadirCountHoliday = 0;
    int tidakHadirCount = 0;

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
      ];

      for (var i = startRow; i < endRow && i < combinedData.length; i++) {
        hitungKeterlambatanPulangLebihAwal(combinedData, kepgData);
        var hari =
            DateFormat.EEEE('id_ID').format(combinedData[i].dateTimeMasuk!);

        JamKerjaModel jamKerja = jamKerjaList.firstWhere((jamKerja) =>
            jamKerja.hariKerja == hari &&
            jamKerja.kepg == kepgData.kepegawaian);

        var durasiPresensi = combinedData[i]
            .dateTimeKeluar!
            .difference(combinedData[i].dateTimeMasuk!);

        var durasiPresensiFormatted =
            "${durasiPresensi.inHours.toString().padLeft(2, '0')}:${durasiPresensi.inMinutes.remainder(60).toString().padLeft(2, '0')}";

        durasiKerjaList.add(durasiPresensiFormatted);
        var date =
            combinedData[i].dateTimeMasuk!.toIso8601String().split('T')[0];

        var tanggalPresensi =
            dateFormatter.format(combinedData[i].dateTimeMasuk!);

        generateDateRangePengecualian(pengecualianRangeList, pengecualianData);

        var keterangan = '';
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
          keterangan = pengecualian.nama!;
        } else if (pengecualian == null && holiday != null) {
          keterangan = holiday.name!;
        } else if (pengecualian != null && holiday != null) {
          keterangan = '${pengecualian.nama!}, ${holiday.name!}';
        }

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

        tableRows.add(pw.TableRow(
          children: [
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child:
                  pw.Text("${i + 1}.", style: const pw.TextStyle(fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(tanggalPresensi,
                  style: const pw.TextStyle(fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(jamKerja.nama!,
                  style: const pw.TextStyle(fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(jamKerja.jadwalMasuk!,
                  style: const pw.TextStyle(fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(
                formatterTime.format(combinedData[i].dateTimeMasuk!),
                style: const pw.TextStyle(fontSize: 6),
              ),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(keterlambatanList[i],
                  style: const pw.TextStyle(fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(jamKerja.jadwalKeluar!,
                  style: const pw.TextStyle(fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(
                formatterTime.format(combinedData[i].dateTimeKeluar!),
                style: const pw.TextStyle(fontSize: 6),
              ),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(pulangLebihAwalList[i],
                  style: const pw.TextStyle(fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(durasiPresensiFormatted,
                  style: const pw.TextStyle(fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(isAbsen ? 'Tanpa Keterangan' : keterangan,
                  style: const pw.TextStyle(fontSize: 6)),
            ),
          ],
        ));
      }

      if (kDebugMode) {
        print('hadirCount: ${groupedData.length}');
        print('hadirCountHoliday: $hadirCountHoliday');
        print('tidakHadirCount: $tidakHadirCount');
        print('totalPresensi: $totalPresensi');
      }

      double persentaseKehadiran = ((tidakHadirCount) / totalPresensi) * 100;
      double persentaseFix = 100 - persentaseKehadiran;
      var persentase = persentaseFix.toStringAsFixed(1);

      if (persentaseKehadiran > 100) {
        persentase = '100.0';
      }

      var totalDurasiPresensiFormatted = hitungTotal(durasiKerjaList);
      var totalKeterlambatanFormatted = hitungTotal(keterlambatanList);
      var totalPulangLebihAwalFormatted = hitungTotal(pulangLebihAwalList);

      var totalDurasiPresensiSplit =
          '${totalDurasiPresensiFormatted.split(':')[0]} jam, ${totalDurasiPresensiFormatted.split(':')[1]} menit';
      var totalKeterlambatanSplit =
          '${totalKeterlambatanFormatted.split(':')[0]} jam, ${totalKeterlambatanFormatted.split(':')[1]} menit';
      var totalPulangLebihAwalSplit =
          '${totalPulangLebihAwalFormatted.split(':')[0]} jam, ${totalPulangLebihAwalFormatted.split(':')[1]} menit';

      pdf.addPage(
        pw.Page(
          orientation: pw.PageOrientation.landscape,
          pageFormat: PdfPageFormat.a4.landscape,
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
                border: pw.TableBorder.all(color: PdfColors.grey),
                children: tableRows,
              ),
              pw.SizedBox(height: 10),
              pw.Text('Evaluasi Kehadiran Pegawai :',
                  style: pw.TextStyle(
                      fontSize: 6, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 6),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Text('Kehadiran: ${groupedData.length.toString()}',
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Text('Persentase Kehadiran: $persentase%',
                              style: const pw.TextStyle(fontSize: 6)),
                        ]),
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                              'Total Keterlambatan: $totalKeterlambatanSplit',
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Text(
                              'Total Pulang Lebih Awal: $totalPulangLebihAwalSplit',
                              style: const pw.TextStyle(fontSize: 6)),
                        ]),
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Text(
                              'Total Durasi Kerja: $totalDurasiPresensiSplit',
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Text(
                              'Tidak Hadir: ${tidakHadirCount == 0 ? '-' : tidakHadirCount}',
                              style: const pw.TextStyle(fontSize: 6)),
                        ]),
                  ]),
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
          'Laporan Presensi ${kepgData.nama} : (${dateFormatter.format(start!).toString()} - ${dateFormatter.format(end.value).toString()}).pdf';

    html.document.body?.children.add(anchor);
    anchor.click();
    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  Future<void> previewPDF(String pin) async {
    isClicked.value = true;
    update();
    final QuerySnapshot<Map<String, dynamic>> presensiSnapshot;
    final QuerySnapshot<Map<String, dynamic>> jamKerjaSnapshot;
    final QuerySnapshot<Map<String, dynamic>> holidaySnapshot;

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

    holidaySnapshot = await firestore.collection('Holiday').get();

    holidayList =
        holidaySnapshot.docs.map((doc) => HolidayModel.fromJson(doc)).toList();

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

    final pdfPreview = pw.Document();
    var formatterTime = DateFormat('HH:mm', 'id-ID');

    const int rowsPerPage = 24;

    final totalPages = (combinedData.length / rowsPerPage).ceil();

    final int totalPresensi = combinedData.length;
    int hadirCountHoliday = 0;
    int tidakHadirCount = 0;

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
      ];

      for (var i = startRow; i < endRow && i < combinedData.length; i++) {
        hitungKeterlambatanPulangLebihAwal(combinedData, kepgData);
        var hari =
            DateFormat.EEEE('id_ID').format(combinedData[i].dateTimeMasuk!);

        JamKerjaModel jamKerja = jamKerjaList.firstWhere((jamKerja) =>
            jamKerja.hariKerja == hari &&
            jamKerja.kepg == kepgData.kepegawaian);

        var durasiPresensi = combinedData[i]
            .dateTimeKeluar!
            .difference(combinedData[i].dateTimeMasuk!);

        var durasiPresensiFormatted =
            "${durasiPresensi.inHours.toString().padLeft(2, '0')}:${durasiPresensi.inMinutes.remainder(60).toString().padLeft(2, '0')}";

        durasiKerjaList.add(durasiPresensiFormatted);
        var date =
            combinedData[i].dateTimeMasuk!.toIso8601String().split('T')[0];

        var tanggalPresensi =
            dateFormatter.format(combinedData[i].dateTimeMasuk!);

        HolidayModel? holiday;
        for (var h in holidayList) {
          if (h.date == date) {
            holiday = h;
            break;
          }
        }

        var keterangan = holiday != null ? holiday.name : '';
        var isHoliday = holidayList.any((holiday) => holiday.date == date);
        var isAbsen = !isHoliday &&
            combinedData[i].dateTimeMasuk!.hour == 0 &&
            combinedData[i].dateTimeMasuk!.minute == 0 &&
            combinedData[i].dateTimeKeluar!.hour == 0 &&
            combinedData[i].dateTimeKeluar!.minute == 0;

        if (isHoliday) {
          hadirCountHoliday++;
        } else if (combinedData[i].dateTimeMasuk!.hour == 0 &&
            combinedData[i].dateTimeMasuk!.minute == 0 &&
            combinedData[i].dateTimeKeluar!.hour == 0 &&
            combinedData[i].dateTimeKeluar!.minute == 0) {
          tidakHadirCount++;
        }

        tableRows.add(pw.TableRow(
          children: [
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child:
                  pw.Text("${i + 1}.", style: const pw.TextStyle(fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(tanggalPresensi,
                  style: const pw.TextStyle(fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(jamKerja.nama!,
                  style: const pw.TextStyle(fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(jamKerja.jadwalMasuk!,
                  style: const pw.TextStyle(fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(
                formatterTime.format(combinedData[i].dateTimeMasuk!),
                style: const pw.TextStyle(fontSize: 6),
              ),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(keterlambatanList[i],
                  style: const pw.TextStyle(fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(jamKerja.jadwalKeluar!,
                  style: const pw.TextStyle(fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(
                formatterTime.format(combinedData[i].dateTimeKeluar!),
                style: const pw.TextStyle(fontSize: 6),
              ),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(pulangLebihAwalList[i],
                  style: const pw.TextStyle(fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(durasiPresensiFormatted,
                  style: const pw.TextStyle(fontSize: 6)),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.all(5),
              child: pw.Text(isAbsen ? 'Tanpa Keterangan' : keterangan!,
                  style: const pw.TextStyle(fontSize: 6)),
            ),
          ],
        ));
      }

      if (kDebugMode) {
        print('hadirCount: ${groupedData.length}');
        print('hadirCountHoliday: $hadirCountHoliday');
        print('tidakHadirCount: $tidakHadirCount');
        print('totalPresensi: $totalPresensi');
      }

      double persentaseKehadiran = (tidakHadirCount / totalPresensi) * 100;
      double persentaseFix = 100 - persentaseKehadiran;
      var persentase = persentaseFix.toStringAsFixed(1);

      if (persentaseKehadiran > 100) {
        persentase = '100.0';
      }

      var totalDurasiPresensiFormatted = hitungTotal(durasiKerjaList);

      var totalKeterlambatanFormatted = hitungTotal(keterlambatanList);

      var totalPulangLebihAwalFormatted = hitungTotal(pulangLebihAwalList);

      pdfPreview.addPage(
        pw.Page(
          orientation: pw.PageOrientation.landscape,
          pageFormat: PdfPageFormat.a4.landscape,
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
                border: pw.TableBorder.all(color: PdfColors.grey),
                children: tableRows,
              ),
              pw.SizedBox(height: 10),
              pw.Text('Evaluasi Kehadiran Pegawai :',
                  style: pw.TextStyle(
                      fontSize: 6, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 6),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Text('Kehadiran: ${groupedData.length.toString()}',
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Text('Persentase Kehadiran: $persentase%',
                              style: const pw.TextStyle(fontSize: 6)),
                        ]),
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                              'Total Keterlambatan: $totalKeterlambatanFormatted',
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Text(
                              'Total Pulang Lebih Awal: $totalPulangLebihAwalFormatted',
                              style: const pw.TextStyle(fontSize: 6)),
                        ]),
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Text(
                              'Total Durasi Kerja: $totalDurasiPresensiFormatted',
                              style: const pw.TextStyle(fontSize: 6)),
                          pw.Text(
                              'Tidak Hadir: ${tidakHadirCount == 0 ? '-' : tidakHadirCount}',
                              style: const pw.TextStyle(fontSize: 6)),
                        ]),
                  ]),
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
