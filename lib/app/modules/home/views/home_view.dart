import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:monitorpresensi/app/mobile/profile_mobile/views/profile_mobile_view.dart';
import 'package:monitorpresensi/app/web/riwayat_presensi/views/riwayat_presensi_view.dart';
import 'package:monitorpresensi/app/mobile/riwayat_presensi_mobile/views/riwayat_presensi_mobile_view.dart';
import 'package:monitorpresensi/app/routes/app_pages.dart';
import 'package:monitorpresensi/app/theme/textstyle.dart';
import 'package:monitorpresensi/app/theme/theme.dart';
import 'package:monitorpresensi/app/utils/stringGlobal.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/auth_controller.dart';
import '../../../utils/dialogDefault.dart';

import '../../../mobile/beranda_mobile/views/beranda_mobile_view.dart';
import '../../../utils/loading.dart';
import '../../../utils/session.dart';
import '../../../web/super-admin/views/super_admin_view.dart';
import '../controllers/home_controller.dart';
import 'package:flutter/foundation.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final authC = Get.put(AuthController());

    return GetBuilder<AuthController>(builder: (c) {
      if (kIsWeb) {
        final storedUserData = StorageService.getUserDataWithExpiration();
        final currentRoute = StorageService.getCurrentRoute();

        if (storedUserData != null) {
          if (storedUserData.expirationTime.isAfter(DateTime.now())) {
            c.userData.value = storedUserData.user;
          } else {
            return Scaffold(
              backgroundColor: error.withOpacity(0.5),
              body: dialogAlertBtnAnimation(() {
                authC.logout();
              },
                  'assets/lootie/warning.json',
                  111.29,
                  "Keluar",
                  "Session Habis.",
                  "Silahkan masuk ulang.",
                  getTextAlert(context),
                  getTextAlertSub(context),
                  getTextAlertBtn(context)),
            );
          }
        } else {
          return Scaffold(
            backgroundColor: error.withOpacity(0.5),
            body: dialogAlertBtnAnimation(() {
              authC.logout();
            },
                'assets/lootie/warning.json',
                111.29,
                "Keluar",
                "Session Habis.",
                "Silahkan masuk ulang.",
                getTextAlert(context),
                getTextAlertSub(context),
                getTextAlertBtn(context)),
          );
        }

        String? roles = c.userData.value.role;
        String? status = c.userData.value.status;

        if (kDebugMode) {
          print("ROLES WEB 1 : $roles");
        }

        if (roles == null || roles == '') {
          return Scaffold(
            backgroundColor: error.withOpacity(0.5),
            body: dialogAlertBtnAnimation(() {
              authC.logout();
            },
                'assets/lootie/warning.json',
                111.29,
                "Keluar",
                "Terjadi Masalah!",
                "Silahkan masuk ulang.",
                getTextAlert(context),
                getTextAlertSub(context),
                getTextAlertBtn(context)),
          );
        } else if (status == 'false') {
          return Scaffold(
            backgroundColor: error.withOpacity(0.5),
            body: dialogAlertBtnAnimation(() {
              authC.logout();
            },
                'assets/lootie/warning.json',
                111.29,
                "Keluar",
                "Terjadi Masalah!",
                "Akun dinonaktifkan.",
                getTextAlert(context),
                getTextAlertSub(context),
                getTextAlertBtn(context)),
          );
        } else {
          // if (roles == admin) {
          //   if (currentRoute != null) {
          //     WidgetsBinding.instance.addPostFrameCallback((_) {
          //       Navigator.pushReplacementNamed(context, currentRoute);
          //     });
          //   }
          //   return const RiwayatPresensiView();
          // } else if (roles == superAdmin) {
          //   if (currentRoute != null) {
          //     WidgetsBinding.instance.addPostFrameCallback((_) {
          //       Navigator.pushReplacementNamed(context, currentRoute);
          //     });
          //   }
          //   return const SuperAdminView();
          if (roles == admin) {
            if (currentRoute != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, currentRoute);
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const RiwayatPresensiView()));
              });
            }
          } else if (roles == superAdmin) {
            if (currentRoute != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacementNamed(context, currentRoute);
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const SuperAdminView()));
              });
            }
          } else {
            return Scaffold(
              backgroundColor: error.withOpacity(0.5),
              body: dialogAlertBtnAnimation(() {
                authC.logout();
              },
                  'assets/lootie/warning.json',
                  111.29,
                  "Keluar",
                  "Salah Akun!",
                  "Akun bukan admin, \nsilahkan masuk menggunakan akun admin.",
                  getTextAlert(context),
                  getTextAlertSub(context),
                  getTextAlertBtn(context)),
            );
          }
        }
        return const LoadingView();
      } else {
        var pages = <Widget>[
          const BerandaMobileView(),
          const RiwayatPresensiMobileView(),
          const ProfileMobileView()
        ];

        String? roles = c.userData.value.role;
        String? status = c.userData.value.status;

        // fcmC.sendNotificationToAllUser(titleNotif, messageNotif);

        if (kDebugMode) {
          print("ROLES MOBILE : $roles");
        }
        if (roles == null) {
          return Scaffold(
            backgroundColor: error.withOpacity(0.5),
            body: dialogAlertBtnAnimation(() {
              authC.logout();
            },
                'assets/lootie/warning.json',
                111.29,
                "Keluar",
                "Terjadi Masalah!",
                "Silahkan masuk ulang.",
                getTextAlertMobile(context),
                getTextAlertSubMobile(context),
                getTextAlertBtnMobile(context)),
          );
        } else if (status == 'false') {
          return Scaffold(
            backgroundColor: error.withOpacity(0.5),
            body: dialogAlertBtnAnimation(() {
              authC.logout();
            },
                'assets/lootie/warning.json',
                111.29,
                "Keluar",
                "Terjadi Masalah!",
                "Akun dinonaktifkan.",
                getTextAlertMobile(context),
                getTextAlertSubMobile(context),
                getTextAlertBtnMobile(context)),
          );
        } else {
          if (roles == pegawai) {
            return FutureBuilder(
                future: simulateDelay(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Tampilkan LoadingWidget selama delay
                    return const LoadingView();
                  }
                  return Scaffold(
                    body: Obx(() => pages[controller.currentIndex.value]),
                    bottomNavigationBar: Container(
                      decoration: BoxDecoration(
                        color: Blue1,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(right: 9.w, left: 9.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            navBarItem(context, IconlyLight.home, 0),
                            navBarItem(context, IconlyLight.document, 1),
                            navBarItem(context, IconlyLight.profile, 2),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Scaffold(
              backgroundColor: error.withOpacity(0.5),
              body: dialogAlertBtnAnimation(() {
                authC.logout();
              },
                  'assets/lootie/warning.json',
                  111.29,
                  "Keluar",
                  "Salah Akun!",
                  "Aplikasi ini hanya untuk pegawai, \nsilahkan masuk menggunakan akun pegawai.",
                  getTextAlertMobile(context),
                  getTextAlertSubMobile(context),
                  getTextAlertBtnMobile(context)),
            );
          }
        }
      }
    });
  }

  Widget navBarItem(BuildContext context, IconData icon, int index) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          controller.changePage(index);
        },
        child: SizedBox(
          height: 75,
          child: Obx(
            () => Padding(
              padding: const EdgeInsets.all(11.0),
              child: SizedBox(
                width: 55,
                child: Icon(
                  icon,
                  color: (index == controller.currentIndex.value ||
                          Get.currentRoute == Routes.BERANDA_MOBILE)
                      ? light
                      : light.withOpacity(0.4),
                ),
              ),
            ),
          ),
        ));
  }
}
