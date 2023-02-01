import 'package:flutter/cupertino.dart';
import 'package:project_tugas_akhir/app/theme/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_value.dart';

getTextLogin(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 15.0, valueWhen: [
        Condition.smallerThan(name: DESKTOP, value: 10.0),
        Condition.equals(name: MOBILE, value: 10.0),
        Condition.equals(name: TABLET, value: 12.0),
        Condition.equals(name: DESKTOP, value: 15.0),
      ]).value,
      color: dark);
}

getTextAdmin(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 15.0, valueWhen: [
        Condition.smallerThan(name: DESKTOP, value: 10.0),
        Condition.equals(name: MOBILE, value: 10.0),
        Condition.equals(name: TABLET, value: 12.0),
        Condition.equals(name: DESKTOP, value: 15.0),
      ]).value,
      color: Blue1);
}

getText10ptBlue(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 10.0, valueWhen: [
        Condition.smallerThan(name: DESKTOP, value: 5.0),
        Condition.equals(name: MOBILE, value: 5.0),
        Condition.equals(name: TABLET, value: 7.0),
        Condition.equals(name: DESKTOP, value: 10.0),
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
      color: Grey1);
}

getTextErrorFormLogin(BuildContext context) {
  return TextStyle(
    fontSize: ResponsiveValue(context, defaultValue: 10.0, valueWhen: [
      Condition.smallerThan(name: DESKTOP, value: 5.0),
      Condition.equals(name: MOBILE, value: 5.0),
      Condition.equals(name: TABLET, value: 7.0),
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
      fontSize: ResponsiveValue(context, defaultValue: 15.0, valueWhen: [
        Condition.smallerThan(name: DESKTOP, value: 10.0),
        Condition.equals(name: MOBILE, value: 10.0),
        Condition.equals(name: TABLET, value: 12.0),
        Condition.equals(name: DESKTOP, value: 15.0),
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
        Condition.smallerThan(name: DESKTOP, value: 6.0),
        Condition.equals(name: MOBILE, value: 6.0),
        Condition.equals(name: TABLET, value: 8.0),
        Condition.equals(name: DESKTOP, value: 11.0),
      ]).value,
      color: Blue1);
}
