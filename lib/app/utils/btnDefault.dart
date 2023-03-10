import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_value.dart' as rspnsvlue;
import 'package:sizer/sizer.dart';

import '../theme/textstyle.dart';
import '../theme/theme.dart';

Widget btnDefaultIcon1(
    double width,
    Color btnColor,
    IconData icon,
    Color iconColor,
    String textBtn,
    TextStyle textStyleBtn,
    VoidCallback onPressed) {
  return Container(
    width: width,
    height: 40,
    decoration:
        BoxDecoration(color: Blue1, borderRadius: BorderRadius.circular(8)),
    child: TextButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
          SizedBox(
            width: 0.6.w,
          ),
          ResponsiveVisibility(
            hiddenWhen: [
              rspnsvlue.Condition.smallerThan(name: DESKTOP),
              rspnsvlue.Condition.smallerThan(name: MOBILE),
              rspnsvlue.Condition.equals(name: MOBILE),
              rspnsvlue.Condition.equals(name: TABLET),
            ],
            child: Text(
              textBtn,
              style: textStyleBtn,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget textButton1(IconData icon, Color iconColor, String textBtn,
    TextStyle textStyleBtn, VoidCallback onPressed) {
  return TextButton(
    onPressed: onPressed,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 20,
        ),
        SizedBox(
          width: 0.6.w,
        ),
        ResponsiveVisibility(
          hiddenWhen: [
            rspnsvlue.Condition.smallerThan(name: DESKTOP),
            rspnsvlue.Condition.smallerThan(name: MOBILE),
            rspnsvlue.Condition.equals(name: MOBILE),
            rspnsvlue.Condition.equals(name: TABLET),
          ],
          child: Text(
            textBtn,
            style: textStyleBtn,
          ),
        ),
      ],
    ),
  );
}
