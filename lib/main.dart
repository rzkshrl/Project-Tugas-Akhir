// ignore_for_file: use_key_in_widget_constructors

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/modules/home/views/home_view.dart';
import 'package:project_tugas_akhir/app/utils/loading.dart';
import 'package:sizer/sizer.dart';

import 'package:get/get.dart';
import 'package:project_tugas_akhir/app/theme/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'app/controller/auth_controller.dart';
import 'app/modules/home/controllers/home_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/textstyle.dart';
import 'app/utils/dialogDefault.dart';
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

  await initializeDateFormatting('id_ID', null)
      .then((_) => runApp(ProjectTugasAkhir()));

  runApp(ProjectTugasAkhir());
}

class ProjectTugasAkhir extends StatelessWidget {
  // const ProjectTugasAkhir({super.key});
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final authC = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snap) {
          if (snap.hasError) {
            Get.dialog(dialogAlertOnlySingleMsg(IconlyLight.danger,
                "Terjadi Kesalahan!", getTextAlert(context)));
          }
          if (kIsWeb) {
            return FutureBuilder(
                future: Future.delayed(const Duration(seconds: 0)),
                builder: (context, snapshot) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const LoadingView();
                  }
                  return Sizer(builder: (context, orientation, screenType) {
                    return GetMaterialApp(
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
                            const ResponsiveBreakpoint.resize(2468, name: '4K')
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
                      initialRoute: Routes.LOGIN,
                      getPages: AppPages.routes,
                      debugShowCheckedModeBanner: false,
                    );
                  });
                });
          } else {
            return Sizer(builder: (context, orientation, screenType) {
              return FutureBuilder(
                  future: Future.delayed(const Duration(seconds: 0)),
                  builder: (context, snap) {
                    Get.put<HomeController>(HomeController());
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
                            fontFamily: 'Inter',
                            primaryColor: light,
                          ),
                          home: SplashScreen(),
                          getPages: AppPages.routes,
                          debugShowCheckedModeBanner: false,
                        ),
                      );
                    } else {
                      return FutureBuilder(
                          future: authC.firstInitialized(),
                          builder: (context, snap) {
                            return const LoadingView();
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
