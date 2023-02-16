import 'package:flutter/cupertino.dart';
import 'package:project_tugas_akhir/app/theme/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_value.dart';

getTextLogin(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 16.0, valueWhen: [
        Condition.smallerThan(name: DESKTOP, value: 12.0),
        Condition.equals(name: MOBILE, value: 12.0),
        Condition.equals(name: TABLET, value: 14.0),
        Condition.equals(name: DESKTOP, value: 16.0),
      ]).value,
      color: dark);
}

getTextAdmin(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 16.0, valueWhen: [
        Condition.smallerThan(name: DESKTOP, value: 12.0),
        Condition.equals(name: MOBILE, value: 12.0),
        Condition.equals(name: TABLET, value: 14.0),
        Condition.equals(name: DESKTOP, value: 16.0),
      ]).value,
      color: Blue1);
}

getTextAlert(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 16.0, valueWhen: [
        Condition.smallerThan(name: DESKTOP, value: 12.0),
        Condition.equals(name: MOBILE, value: 12.0),
        Condition.equals(name: TABLET, value: 14.0),
        Condition.equals(name: DESKTOP, value: 16.0),
      ]).value,
      color: Yellow1,
      fontWeight: FontWeight.w300);
}

getTextAlertSub(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 8.0, valueWhen: [
        Condition.smallerThan(name: DESKTOP, value: 8.0),
        Condition.equals(name: MOBILE, value: 8.0),
        Condition.equals(name: TABLET, value: 10.0),
        Condition.equals(name: DESKTOP, value: 12.0),
      ]).value,
      color: Yellow1,
      fontWeight: FontWeight.w300);
}

getTextAlertBtn(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 14.0, valueWhen: [
        Condition.smallerThan(name: DESKTOP, value: 10.0),
        Condition.equals(name: MOBILE, value: 10.0),
        Condition.equals(name: TABLET, value: 12.0),
        Condition.equals(name: DESKTOP, value: 14.0),
      ]).value,
      color: Blue1,
      fontWeight: FontWeight.w400);
}

getTextAlertBtn2(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 14.0, valueWhen: [
        Condition.smallerThan(name: DESKTOP, value: 10.0),
        Condition.equals(name: MOBILE, value: 10.0),
        Condition.equals(name: TABLET, value: 12.0),
        Condition.equals(name: DESKTOP, value: 14.0),
      ]).value,
      color: light,
      fontWeight: FontWeight.w400);
}

getTextMenu(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 36.0, valueWhen: [
        Condition.smallerThan(name: DESKTOP, value: 36.0),
        Condition.equals(name: MOBILE, value: 36.0),
        Condition.equals(name: TABLET, value: 38.0),
        Condition.equals(name: DESKTOP, value: 44.0),
      ]).value,
      color: Yellow1,
      fontFamily: "Inter",
      fontWeight: FontWeight.w900);
}

getTextItemMenu(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 16.0, valueWhen: [
        Condition.smallerThan(name: DESKTOP, value: 13.0),
        Condition.equals(name: MOBILE, value: 13.0),
        Condition.equals(name: TABLET, value: 14.5),
        Condition.equals(name: DESKTOP, value: 16.0),
      ]).value,
      color: Yellow1,
      fontFamily: "Inter",
      fontWeight: FontWeight.w800);
}

getTextItemSubMenu(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 13.0, valueWhen: [
        Condition.smallerThan(name: DESKTOP, value: 10.0),
        Condition.equals(name: MOBILE, value: 10.0),
        Condition.equals(name: TABLET, value: 11.5),
        Condition.equals(name: DESKTOP, value: 13.0),
      ]).value,
      color: Yellow1,
      fontFamily: "Inter",
      fontWeight: FontWeight.w700);
}

getTextItemSubMenuDisabled(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 13.0, valueWhen: [
        Condition.smallerThan(name: DESKTOP, value: 10.0),
        Condition.equals(name: MOBILE, value: 10.0),
        Condition.equals(name: TABLET, value: 11.5),
        Condition.equals(name: DESKTOP, value: 13.0),
      ]).value,
      fontFamily: "Inter",
      color: Yellow1.withOpacity(0.4),
      fontWeight: FontWeight.w700);
}

getText10ptBlue(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 12.5, valueWhen: [
        Condition.smallerThan(name: DESKTOP, value: 10.5),
        Condition.equals(name: MOBILE, value: 10.5),
        Condition.equals(name: TABLET, value: 12.0),
        Condition.equals(name: DESKTOP, value: 12.5),
      ]).value,
      color: Blue1);
}

getTextHintFormLogin(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 15.0, valueWhen: [
        Condition.smallerThan(name: DESKTOP, value: 10.0),
        Condition.equals(name: MOBILE, value: 10.0),
        Condition.equals(name: TABLET, value: 12.0),
        Condition.equals(name: DESKTOP, value: 15.0),
      ]).value,
      color: Grey1,
      fontWeight: FontWeight.w400);
}

getTextErrorFormLogin(BuildContext context) {
  return TextStyle(
    fontSize: ResponsiveValue(context, defaultValue: 10.0, valueWhen: [
      Condition.smallerThan(name: DESKTOP, value: 8.0),
      Condition.equals(name: MOBILE, value: 8.0),
      Condition.equals(name: TABLET, value: 8.0),
      Condition.equals(name: DESKTOP, value: 10.0),
    ]).value,
    color: light,
    background: Paint()
      ..strokeWidth = 16
      ..color = errorBg
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round,
  );
}

getTextLoginBtnActive(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 16.0, valueWhen: [
        Condition.smallerThan(name: DESKTOP, value: 14.0),
        Condition.smallerThan(name: MOBILE, value: 14.0),
        Condition.equals(name: MOBILE, value: 14.0),
        Condition.equals(name: TABLET, value: 15.0),
        Condition.equals(name: DESKTOP, value: 16.0),
      ]).value,
      color: Yellow1,
      fontWeight: FontWeight.w300);
}

getTextLoginBtnActiveMobile(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 16.0, valueWhen: [
        Condition.equals(name: MOBILE, value: 16.0),
        Condition.equals(name: TABLET, value: 18.0),
      ]).value,
      color: Yellow1);
}

getTextLoginBtnDisabled(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 15.0, valueWhen: [
        Condition.smallerThan(name: DESKTOP, value: 10.0),
        Condition.equals(name: MOBILE, value: 10.0),
        Condition.equals(name: TABLET, value: 12.0),
        Condition.equals(name: DESKTOP, value: 15.0),
      ]).value,
      color: Yellow1.withOpacity(0.5));
}

getTextLupaSandi(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 11.0, valueWhen: [
        Condition.smallerThan(name: DESKTOP, value: 10.0),
        Condition.equals(name: MOBILE, value: 10.0),
        Condition.equals(name: TABLET, value: 10.0),
        Condition.equals(name: DESKTOP, value: 11.0),
      ]).value,
      color: Blue1,
      fontWeight: FontWeight.w500);
}

getTextLupaSandiMobile(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 11.0, valueWhen: [
        Condition.equals(name: MOBILE, value: 11.0),
      ]).value,
      color: Blue1,
      fontWeight: FontWeight.w500);
}
