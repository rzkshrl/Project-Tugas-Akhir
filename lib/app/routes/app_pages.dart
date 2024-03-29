import 'package:get/get.dart';

import '../mobile/beranda_mobile/bindings/beranda_mobile_binding.dart';
import '../mobile/beranda_mobile/views/beranda_mobile_view.dart';
import '../mobile/login_mobile/bindings/login_mobile_binding.dart';
import '../mobile/login_mobile/views/login_mobile_view.dart';
import '../mobile/lupa_sandi_mobile/bindings/lupa_sandi_mobile_binding.dart';
import '../mobile/lupa_sandi_mobile/views/lupa_sandi_mobile_view.dart';
import '../mobile/profile_mobile/bindings/profile_mobile_binding.dart';
import '../mobile/profile_mobile/views/profile_mobile_view.dart';
import '../mobile/riwayat_presensi_mobile/bindings/riwayat_presensi_mobile_binding.dart';
import '../mobile/riwayat_presensi_mobile/views/riwayat_presensi_mobile_view.dart';
import '../mobile/ubah_profil_mobile/bindings/ubah_profil_mobile_binding.dart';
import '../mobile/ubah_profil_mobile/views/ubah_profil_mobile_view.dart';
import '../mobile/ubah_sandi_mobile/bindings/ubah_sandi_mobile_binding.dart';
import '../mobile/ubah_sandi_mobile/views/ubah_sandi_mobile_view.dart';
import '../web/pengecualian/bindings/pengecualian_binding.dart';
import '../web/pengecualian/views/pengecualian_view.dart';
import '../web/data_pegawai/bindings/data_pegawai_binding.dart';
import '../web/data_pegawai/views/data_pegawai_view.dart';
import '../web/detail_presensi/bindings/detail_presensi_binding.dart';
import '../web/detail_presensi/views/detail_presensi_view.dart';
import '../web/hari_libur/bindings/hari_libur_binding.dart';
import '../web/hari_libur/views/hari_libur_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../web/jam_kerja/bindings/jam_kerja_binding.dart';
import '../web/jam_kerja/views/jam_kerja_view.dart';
import '../web/login/bindings/login_binding.dart';
import '../web/login/views/login_view.dart';
import '../web/lupa_sandi/bindings/lupa_sandi_binding.dart';
import '../web/lupa_sandi/views/lupa_sandi_view.dart';
import '../web/navigation_drawer/bindings/navigation_drawer_binding.dart';
import '../web/navigation_drawer/views/navigation_drawer_view.dart';
import '../web/rekap_presensi_all/bindings/rekap_presensi_all_binding.dart';
import '../web/rekap_presensi_all/views/rekap_presensi_all_view.dart';
import '../web/rekap_presensi_per/bindings/rekap_presensi_per_binding.dart';
import '../web/rekap_presensi_per/views/rekap_presensi_per_view.dart';
import '../web/rekap_scanlog_per/bindings/rekap_scanlog_per_binding.dart';
import '../web/rekap_scanlog_per/views/rekap_scanlog_per_view.dart';
import '../web/riwayat_presensi/bindings/riwayat_presensi_binding.dart';
import '../web/riwayat_presensi/views/riwayat_presensi_view.dart';
import '../web/super-admin/bindings/super_admin_binding.dart';
import '../web/super-admin/views/super_admin_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.LUPA_SANDI,
      page: () => LupaSandiView(),
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
      name: _Paths.JAM_KERJA,
      page: () => const JamKerjaView(),
      binding: JamKerjaBinding(),
    ),
    GetPage(
      name: _Paths.NAVIGATION_DRAWER,
      page: () => const NavigationDrawerView(),
      binding: NavigationDrawerBinding(),
    ),
    GetPage(
      name: _Paths.HARI_LIBUR,
      page: () => const HariLiburView(),
      binding: HariLiburBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_MOBILE,
      page: () => const LoginMobileView(),
      binding: LoginMobileBinding(),
    ),
    GetPage(
      name: _Paths.LUPA_SANDI_MOBILE,
      page: () => const LupaSandiMobileView(),
      binding: LupaSandiMobileBinding(),
    ),
    GetPage(
      name: _Paths.BERANDA_MOBILE,
      page: () => const BerandaMobileView(),
      binding: BerandaMobileBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT_PRESENSI_MOBILE,
      page: () => const RiwayatPresensiMobileView(),
      binding: RiwayatPresensiMobileBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_MOBILE,
      page: () => const ProfileMobileView(),
      binding: ProfileMobileBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRESENSI,
      page: () => const DetailPresensiView(),
      binding: DetailPresensiBinding(),
    ),
    GetPage(
      name: _Paths.SUPER_ADMIN,
      page: () => const SuperAdminView(),
      binding: SuperAdminBinding(),
    ),
    GetPage(
      name: _Paths.UBAH_PROFIL_MOBILE,
      page: () => const UbahProfilMobileView(),
      binding: UbahProfilMobileBinding(),
    ),
    GetPage(
      name: _Paths.UBAH_SANDI_MOBILE,
      page: () => const UbahSandiMobileView(),
      binding: UbahSandiMobileBinding(),
    ),
    GetPage(
      name: _Paths.PENGECUALIAN,
      page: () => const PengecualianView(),
      binding: PengecualianBinding(),
    ),
  ];
}
