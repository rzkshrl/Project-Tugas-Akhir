import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/utils/loading.dart';
import 'dart:js' as js;
import 'package:sizer/sizer.dart';

import 'package:get/get.dart';
import 'package:project_tugas_akhir/app/theme/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'app/controller/auth_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/theme/textstyle.dart';
import 'app/utils/dialogDefault.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // js.context.callMethod('fixPasswordCss');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
                future: Future.delayed(Duration(seconds: 0)),
                builder: (context, snapshot) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return LoadingView();
                  }
                  return Sizer(builder: (context, orientation, screenType) {
                    return GetMaterialApp(
                      builder: (context, child) => ResponsiveWrapper.builder(
                          BouncingScrollWrapper.builder(context, child!),
                          breakpoints: [
                            ResponsiveBreakpoint.resize(240, name: MOBILE),
                            ResponsiveBreakpoint.resize(650, name: TABLET),
                            ResponsiveBreakpoint.resize(900, name: TABLET),
                            ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                            ResponsiveBreakpoint.resize(2468, name: '4K')
                          ]),
                      title: "MonitorPresence MIM Jetis Lor",
                      theme: ThemeData(
                        fontFamily: 'Inter',
                        primaryColor: light,
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
                  future: Future.delayed(Duration(seconds: 2)),
                  builder: (context, snap) {
                    if (snap.connectionState == ConnectionState.done) {
                      return Obx(
                        () => GetMaterialApp(
                          builder: (context, child) =>
                              ResponsiveWrapper.builder(
                                  BouncingScrollWrapper.builder(
                                      context, child!),
                                  breakpoints: [
                                ResponsiveBreakpoint.resize(240, name: MOBILE),
                                ResponsiveBreakpoint.resize(650, name: TABLET),
                                ResponsiveBreakpoint.resize(900, name: TABLET),
                                ResponsiveBreakpoint.resize(1000,
                                    name: DESKTOP),
                                ResponsiveBreakpoint.resize(2468, name: '4K')
                              ]),
                          title: "MonitorPresence MIM Jetis Lor",
                          theme: ThemeData(
                            fontFamily: 'Inter',
                            primaryColor: light,
                          ),
                          initialRoute:
                              authC.isAuth.isTrue ? Routes.HOME : Routes.LOGIN,
                          getPages: AppPages.routes,
                          debugShowCheckedModeBanner: false,
                        ),
                      );
                    } else {
                      return FutureBuilder(
                          future: authC.firstInitialized(),
                          builder: (context, snap) {
                            return LoadingView();
                          });
                    }
                  });
            });
          }
        });
  }
}
