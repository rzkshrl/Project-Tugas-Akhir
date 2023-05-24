import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../theme/textstyle.dart';
import '../theme/theme.dart';

Widget dialogAlertOnly(
  IconData icon,
  String text,
  String textSub,
  TextStyle textAlert,
  TextStyle textAlertSub,
) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Blue1,
    child: Container(
      width: 350,
      height: 274.07,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 143.97,
            height: 139.02,
            decoration: BoxDecoration(
                border: Border.all(color: Yellow1),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(
              icon,
              color: Yellow1,
              size: 55,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: textAlert,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            textSub,
            textAlign: TextAlign.center,
            style: textAlertSub,
          ),
        ],
      ),
    ),
  );
}

Widget dialogAlertOnlySingleMsg(
    IconData icon, String text, TextStyle textAlert) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Blue1,
    child: Container(
      width: 350,
      height: 274.07,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 143.97,
            height: 139.02,
            decoration: BoxDecoration(
                border: Border.all(color: Yellow1),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(
              icon,
              color: Yellow1,
              size: 55,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: textAlert,
          ),
        ],
      ),
    ),
  );
}

Widget dialogAlertOnlySingleMsgAnimation(
    String animationLink, String text, TextStyle textAlert) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Blue1,
    child: Container(
      width: 350,
      height: 274.07,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 143.97,
            height: 139.02,
            decoration: BoxDecoration(
                border: Border.all(color: Yellow1),
                borderRadius: BorderRadius.circular(12)),
            child: Lottie.asset(animationLink, height: 55),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: textAlert,
          ),
        ],
      ),
    ),
  );
}

Widget dialogAlertBtnSingleMsgAnimation(
  String animationLink,
  String text,
  TextStyle textAlert,
  VoidCallback onPressed,
) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Blue1,
    child: Container(
      width: 350,
      height: 374.07,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 143.97,
            height: 139.02,
            decoration: BoxDecoration(
                border: Border.all(color: Yellow1),
                borderRadius: BorderRadius.circular(12)),
            child: Lottie.asset(animationLink, height: 55),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: textAlert,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
              width: 111.29,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11), color: light),
              child: TextButton(
                  onPressed: onPressed,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
                    child: Text(
                      'OK',
                      style: getTextAlertBtn(Get.context!),
                    ),
                  )))
        ],
      ),
    ),
  );
}

Widget dialogAlertBtn(
    VoidCallback onPressed,
    IconData? icon,
    double widthBtn,
    String textBtn,
    String text,
    String? textSub,
    TextStyle textAlert,
    TextStyle? textAlertSub,
    TextStyle textAlertBtn) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Blue1,
    child: Container(
      width: 350,
      height: 336,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 143.97,
            height: 139.02,
            decoration: BoxDecoration(
                border: Border.all(color: Yellow1),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(
              icon,
              color: Yellow1,
              size: 55,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: textAlert,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            textSub!,
            textAlign: TextAlign.center,
            style: textAlertSub,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
              width: widthBtn,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11), color: light),
              child: TextButton(
                  onPressed: onPressed,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
                    child: Text(
                      textBtn,
                      style: textAlertBtn,
                    ),
                  )))
        ],
      ),
    ),
  );
}

Widget dialogAlertDualBtn(
  VoidCallback onPressed,
  VoidCallback onPressed2,
  IconData icon,
  double widthBtn,
  String textBtn,
  double widthBtn2,
  String textBtn2,
  String text,
  String textSub,
  TextStyle textAlert,
  TextStyle textAlertSub,
  TextStyle textAlertBtn,
  TextStyle textAlertBtn2,
) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    backgroundColor: Blue1,
    child: Container(
      width: 350,
      height: 336,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 143.97,
            height: 139.02,
            decoration: BoxDecoration(
                border: Border.all(color: Yellow1),
                borderRadius: BorderRadius.circular(12)),
            child: Icon(
              icon,
              color: Yellow1,
              size: 55,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: textAlert,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            textSub,
            textAlign: TextAlign.center,
            style: textAlertSub,
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: widthBtn2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11), color: Blue1),
                  child: TextButton(
                      onPressed: onPressed2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
                        child: Text(
                          textBtn2,
                          style: textAlertBtn2,
                        ),
                      ))),
              SizedBox(
                width: 6,
              ),
              Container(
                  width: widthBtn,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11), color: light),
                  child: TextButton(
                      onPressed: onPressed,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
                        child: Text(
                          textBtn,
                          style: textAlertBtn,
                        ),
                      ))),
            ],
          )
        ],
      ),
    ),
  );
}
