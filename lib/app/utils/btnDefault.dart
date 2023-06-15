// ignore_for_file: file_names

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

Widget itemListRiwayatPresensi(
    Function()? onTap, String text1, String text2, String text3) {
  return Padding(
    padding: EdgeInsets.only(bottom: 2.h),
    child: Material(
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: Blue1, borderRadius: BorderRadius.circular(19)),
          child: Padding(
              padding: EdgeInsets.only(left: 2.w, right: 2.w),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child:
                            Text(text1, style: getTextItemList(Get.context!))),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      'PIN Pegawai: $text2',
                      style: getTextItemList2(Get.context!),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      'Jabatan: $text3',
                      style: getTextItemList2(Get.context!),
                    )
                  ])),
        ),
      ),
    ),
  );
}
