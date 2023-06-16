import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_tugas_akhir/app/theme/theme.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: light,
          body: Center(
              child: Lottie.asset('assets/lootie/loading2.json', height: 135))),
    );
  }
}

Future<void> simulateDelay() async {
  await Future.delayed(const Duration(milliseconds: 1500));
}
