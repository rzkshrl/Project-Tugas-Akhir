import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(ProjectTugasAkhir());
}

class ProjectTugasAkhir extends StatelessWidget {
  const ProjectTugasAkhir({super.key});

  @override
  Widget build(BuildContext context) {
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
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
