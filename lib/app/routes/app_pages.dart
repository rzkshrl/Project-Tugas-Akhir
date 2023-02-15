import 'package:get/get.dart';

import '../modules/beranda_presensi/bindings/beranda_presensi_binding.dart';
import '../modules/beranda_presensi/views/beranda_presensi_view.dart';
import '../modules/data_pegawai/bindings/data_pegawai_binding.dart';
import '../modules/data_pegawai/views/data_pegawai_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/jadwal_kerja/bindings/jadwal_kerja_binding.dart';
import '../modules/jadwal_kerja/views/jadwal_kerja_view.dart';
import '../modules/jam_kerja/bindings/jam_kerja_binding.dart';
import '../modules/jam_kerja/views/jam_kerja_view.dart';
import '../modules/ket_izin/bindings/ket_izin_binding.dart';
import '../modules/ket_izin/views/ket_izin_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/lupa_sandi/bindings/lupa_sandi_binding.dart';
import '../modules/lupa_sandi/views/lupa_sandi_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/rekap_presensi_all/bindings/rekap_presensi_all_binding.dart';
import '../modules/rekap_presensi_all/views/rekap_presensi_all_view.dart';
import '../modules/rekap_presensi_per/bindings/rekap_presensi_per_binding.dart';
import '../modules/rekap_presensi_per/views/rekap_presensi_per_view.dart';
import '../modules/rekap_scanlog_per/bindings/rekap_scanlog_per_binding.dart';
import '../modules/rekap_scanlog_per/views/rekap_scanlog_per_view.dart';
import '../modules/riwayat_presensi/bindings/riwayat_presensi_binding.dart';
import '../modules/riwayat_presensi/views/riwayat_presensi_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LUPA_SANDI,
      page: () => const LupaSandiView(),
      binding: LupaSandiBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT_PRESENSI,
      page: () => const RiwayatPresensiView(),
      binding: RiwayatPresensiBinding(),
    ),
    GetPage(
      name: _Paths.REKAP_PRESENSI_ALL,
      page: () => const RekapPresensiAllView(),
      binding: RekapPresensiAllBinding(),
    ),
    GetPage(
      name: _Paths.REKAP_PRESENSI_PER,
      page: () => const RekapPresensiPerView(),
      binding: RekapPresensiPerBinding(),
    ),
    GetPage(
      name: _Paths.REKAP_SCANLOG_PER,
      page: () => const RekapScanlogPerView(),
      binding: RekapScanlogPerBinding(),
    ),
    GetPage(
      name: _Paths.DATA_PEGAWAI,
      page: () => const DataPegawaiView(),
      binding: DataPegawaiBinding(),
    ),
    GetPage(
      name: _Paths.JADWAL_KERJA,
      page: () => const JadwalKerjaView(),
      binding: JadwalKerjaBinding(),
    ),
    GetPage(
      name: _Paths.JAM_KERJA,
      page: () => const JamKerjaView(),
      binding: JamKerjaBinding(),
    ),
    GetPage(
      name: _Paths.KET_IZIN,
      page: () => const KetIzinView(),
      binding: KetIzinBinding(),
    ),
  ];
}
