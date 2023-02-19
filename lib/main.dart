import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:js' as js;
import 'package:sizer/sizer.dart';

import 'package:get/get.dart';
import 'package:project_tugas_akhir/app/theme/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(ProjectTugasAkhir());
}

class ProjectTugasAkhir extends StatelessWidget {
  const ProjectTugasAkhir({super.key});

  @override
  Widget build(BuildContext context) {
    js.context.callMethod('fixPasswordCss');
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
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
