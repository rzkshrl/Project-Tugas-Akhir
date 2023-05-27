// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:sizer/sizer.dart';

import '../controller/auth_controller.dart';
import '../theme/theme.dart';

Widget rowAppBarAdmin(BuildContext context) {
  final authC = Get.put(AuthController());
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      IconButton(
          iconSize: 30,
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          icon: FaIcon(
            FontAwesomeIcons.bars,
            color: Blue1,
          )),
      Padding(
        padding: EdgeInsets.only(
          right: 1.5.w,
        ),
        child: IconButton(
          color: Blue1,
          onPressed: () => authC.logout(),
          icon: const Icon(IconlyLight.logout),
          iconSize: 30,
        ),
      ),
    ],
  );
}
