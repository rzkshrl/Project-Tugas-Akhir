// ignore_for_file: prefer_if_null_operators, use_key_in_widget_constructors

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project_tugas_akhir/app/modules/home/views/home_view.dart';
import 'package:project_tugas_akhir/app/utils/loading.dart';

import 'package:sizer/sizer.dart';

import 'package:get/get.dart';
import 'package:project_tugas_akhir/app/theme/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'app/controller/auth_controller.dart';
import 'app/controller/fcm_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/textstyle.dart';
import 'app/utils/dialogDefault.dart';

import 'app/utils/session.dart';
import 'firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';
// ignore: depend_on_referenced_packages
import 'package:page_transition/page_transition.dart';

Future<void> main() async {
  // js.context.callMethod('fixPasswordCss');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kIsWeb) {
    Get.put(SessionController());
  }
  await GetStorage.init();
  final FCMController fcmController = FCMController();
  fcmController.notificationRequestDaily();
  // fcmController.sendNotificationToAllUser(titleNotif, messageNotif);
  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(ProjectTugasAkhir(
            fcmController: fcmController,
          )));
  runApp(ProjectTugasAkhir(fcmController: fcmController));
}

class ProjectTugasAkhir extends StatelessWidget {
  final FCMController fcmController;

  ProjectTugasAkhir({Key? key, required this.fcmController}) : super(key: key);
  // const ProjectTugasAkhir({super.key});
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final authC = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snap) {
          if (snap.hasError) {
            Get.dialog(dialogAlertOnlySingleMsgAnimation(
                'assets/lootie/warning.json',
                "Terjadi Kesalahan!",
                getTextAlert(context)));
          }
          if (kIsWeb) {
            final sessionController = Get.put(SessionController());
            final currentRoute = StorageService.getCurrentRoute();
            if (kDebugMode) {
              print(currentRoute);
            }

            return FutureBuilder(
                future: simulateDelay(),
                builder: (context, snapshot) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const LoadingView();
                  }
                  return Sizer(builder: (context, orientation, screenType) {
                    return Obx(
                      () => GetMaterialApp(
                        builder: (context, child) => ResponsiveWrapper.builder(
                            BouncingScrollWrapper.builder(context, child!),
                            breakpoints: [
                              const ResponsiveBreakpoint.resize(240,
                                  name: MOBILE),
                              const ResponsiveBreakpoint.resize(650,
                                  name: TABLET),
                              const ResponsiveBreakpoint.resize(900,
                                  name: TABLET),
                              const ResponsiveBreakpoint.resize(1000,
                                  name: DESKTOP),
                              const ResponsiveBreakpoint.resize(2468,
                                  name: '4K')
                            ]),
                        title: "MonitorPresence MIM Jetis Lor",
                        theme: ThemeData(
                          scaffoldBackgroundColor: light,
                          fontFamily: 'Inter',
                          primaryColor: light,
                          // scrollbarTheme: ScrollbarThemeData(
                          //   thumbColor: thumbColorScrollbar,
                          //   trackColor: trackColorScrollbar,
                          //   thumbVisibility: MaterialStatePropertyAll(true),
                          // )),
                        ),
                        initialRoute: sessionController.isLoggedIn.value
                            ? Routes.HOME
                            : Routes.LOGIN,
                        getPages: AppPages.routes,
                        debugShowCheckedModeBanner: false,
                      ),
                    );
                  });
                });
          } else {
            fcmController.notificationRequestDaily();
            return Sizer(builder: (context, orientation, screenType) {
              return FutureBuilder(
                  future: Future.delayed(const Duration(milliseconds: 0)),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.done) {
                      return AnnotatedRegion(
                        value: SystemUiOverlayStyle(
                          statusBarBrightness: Brightness.dark,
                          statusBarIconBrightness: Brightness.dark,
                          statusBarColor: light,
                        ),
                        child: GetMaterialApp(
                          builder: (context, child) =>
                              ResponsiveWrapper.builder(
                                  BouncingScrollWrapper.builder(
                                      context, child!),
                                  breakpoints: [
                                const ResponsiveBreakpoint.resize(240,
                                    name: MOBILE),
                                const ResponsiveBreakpoint.autoScale(650,
                                    name: TABLET),
                                const ResponsiveBreakpoint.autoScale(900,
                                    name: TABLET),
                                const ResponsiveBreakpoint.autoScale(1000,
                                    name: DESKTOP),
                                const ResponsiveBreakpoint.autoScale(2468,
                                    name: '4K')
                              ]),
                          title: "MonitorPresence MIM Jetis Lor",
                          theme: ThemeData(
                            fontFamily: 'Inter',
                            primaryColor: light,
                          ),
                          home: SplashScreen(),
                          getPages: AppPages.routes,
                          debugShowCheckedModeBanner: false,
                          initialBinding: BindingsBuilder(() {
                            Get.put(fcmController);
                          }),
                        ),
                      );
                    } else {
                      return FutureBuilder(
                          future: authC.firstInitialized(),
                          builder: (context, snap) {
                            return GetMaterialApp(
                              home: Scaffold(
                                  backgroundColor: light,
                                  body: const Center(
                                    child: SizedBox(),
                                  )),
                            );
                          });
                    }
                  });
            });
          }
        });
  }
}

class SplashScreen extends StatelessWidget {
  final authC = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    authC.readUser();
    return AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: light,
        ),
        child: AnimatedSplashScreen(
          animationDuration: const Duration(milliseconds: 900),
          duration: 1200,
          splash: 'assets/icons/logo_splash.png',
          backgroundColor: light,
          nextScreen: const HomeView(),
          nextRoute: authC.isAuth.isTrue ? Routes.HOME : Routes.LOGIN,
          splashIconSize: 255,
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.leftToRight,
        ));
  }
}
