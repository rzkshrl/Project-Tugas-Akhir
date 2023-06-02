// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_value.dart' as rspnsvlue;
import 'package:sizer/sizer.dart';

import '../theme/textstyle.dart';

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
        BoxDecoration(color: btnColor, borderRadius: BorderRadius.circular(8)),
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
            hiddenWhen: const [
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

Widget btnDefaultIcon2(
    double width,
    Color btnColor,
    IconData icon,
    Color iconColor,
    Color borderColor,
    String textBtn,
    TextStyle textStyleBtn,
    VoidCallback onPressed) {
  return Container(
    width: width,
    height: 40,
    decoration: BoxDecoration(
        color: btnColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 3)),
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
            hiddenWhen: const [
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
          hiddenWhen: const [
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

Widget textButtonMobile1(IconData icon, Color iconColor, String textBtn,
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
        Text(
          textBtn,
          style: textStyleBtn,
        ),
      ],
    ),
  );
}

Widget btnMobile(
    Color containerColor, void Function()? onPressed, String textBtn) {
  return Container(
    width: 68.5.w,
    height: 6.2.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: containerColor,
    ),
    child: TextButton(
      onPressed: onPressed,
      child: Text(
        textBtn,
        style: getTextLoginBtnActiveMobile(Get.context!),
      ),
    ),
  );
}
