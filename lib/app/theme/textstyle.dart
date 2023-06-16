import 'package:flutter/cupertino.dart';
import 'package:project_tugas_akhir/app/theme/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sizer/sizer.dart';

getTextLogin(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 16.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 12.0),
        const Condition.equals(name: MOBILE, value: 12.0),
        const Condition.equals(name: TABLET, value: 14.0),
        const Condition.equals(name: DESKTOP, value: 16.0),
      ]).value,
      color: dark);
}

getTextFormDialog(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 16.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 12.0),
        const Condition.equals(name: MOBILE, value: 12.0),
        const Condition.equals(name: TABLET, value: 14.0),
        const Condition.equals(name: DESKTOP, value: 16.0),
      ]).value,
      color: light);
}

getTextFormJamKerja(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 11.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 7.0),
        const Condition.equals(name: MOBILE, value: 7.0),
        const Condition.equals(name: TABLET, value: 9.0),
        const Condition.equals(name: DESKTOP, value: 11.0),
      ]).value,
      color: light);
}

getTextFormDialog2(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 14.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 10.0),
        const Condition.equals(name: MOBILE, value: 10.0),
        const Condition.equals(name: TABLET, value: 12.0),
        const Condition.equals(name: DESKTOP, value: 14.0),
      ]).value,
      color: dark);
}

getTextFormDialog3(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 16.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 12.0),
        const Condition.equals(name: MOBILE, value: 12.0),
        const Condition.equals(name: TABLET, value: 14.0),
        const Condition.equals(name: DESKTOP, value: 16.0),
      ]).value,
      color: light);
}

getTextAdmin(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 16.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 12.0),
        const Condition.equals(name: MOBILE, value: 12.0),
        const Condition.equals(name: TABLET, value: 14.0),
        const Condition.equals(name: DESKTOP, value: 16.0),
      ]).value,
      color: Blue1);
}

getTextHeader(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 24.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 20.0),
        const Condition.equals(name: MOBILE, value: 20.0),
        const Condition.equals(name: TABLET, value: 22.0),
        const Condition.equals(name: DESKTOP, value: 24.0),
      ]).value,
      color: Blue1,
      fontWeight: FontWeight.w900);
}

getTextHeaderDisabled(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 24.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 20.0),
        const Condition.equals(name: MOBILE, value: 20.0),
        const Condition.equals(name: TABLET, value: 22.0),
        const Condition.equals(name: DESKTOP, value: 24.0),
      ]).value,
      color: Blue1.withOpacity(0.7),
      fontWeight: FontWeight.w900);
}

getTextHeader2(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 34.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 30.0),
        const Condition.equals(name: MOBILE, value: 30.0),
        const Condition.equals(name: TABLET, value: 32.0),
        const Condition.equals(name: DESKTOP, value: 34.0),
      ]).value,
      color: Blue1,
      fontWeight: FontWeight.w900);
}

getTextCalendarDef(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 18.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 14.0),
        const Condition.equals(name: MOBILE, value: 14.0),
        const Condition.equals(name: TABLET, value: 16.0),
        const Condition.equals(name: DESKTOP, value: 18.0),
      ]).value,
      color: Blue1,
      fontWeight: FontWeight.w700);
}

getTextCalendarToday(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 18.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 14.0),
        const Condition.equals(name: MOBILE, value: 14.0),
        const Condition.equals(name: TABLET, value: 16.0),
        const Condition.equals(name: DESKTOP, value: 18.0),
      ]).value,
      color: light,
      fontWeight: FontWeight.w700);
}

getTextCalendarHoliday(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 18.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 14.0),
        const Condition.equals(name: MOBILE, value: 14.0),
        const Condition.equals(name: TABLET, value: 16.0),
        const Condition.equals(name: DESKTOP, value: 18.0),
      ]).value,
      color: error,
      fontWeight: FontWeight.w700);
}

getTextCalendarHolidayRutin(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 18.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 14.0),
        const Condition.equals(name: MOBILE, value: 14.0),
        const Condition.equals(name: TABLET, value: 16.0),
        const Condition.equals(name: DESKTOP, value: 18.0),
      ]).value,
      color: redAppoint,
      fontWeight: FontWeight.w700);
}

getTextCalendarTrail(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 18.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 14.0),
        const Condition.equals(name: MOBILE, value: 14.0),
        const Condition.equals(name: TABLET, value: 16.0),
        const Condition.equals(name: DESKTOP, value: 18.0),
      ]).value,
      color: Grey1,
      fontWeight: FontWeight.w700);
}

getTextSubHeader(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 14.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 10.0),
        const Condition.equals(name: MOBILE, value: 10.0),
        const Condition.equals(name: TABLET, value: 12.0),
        const Condition.equals(name: DESKTOP, value: 14.0),
      ]).value,
      color: Blue1,
      fontWeight: FontWeight.w700);
}

getTextItemPegawai(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 16.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 12.0),
        const Condition.equals(name: MOBILE, value: 12.0),
        const Condition.equals(name: TABLET, value: 14.0),
        const Condition.equals(name: DESKTOP, value: 16.0),
      ]).value,
      color: Yellow1,
      fontWeight: FontWeight.w600);
}

getTextTable(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 16.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 12.0),
        const Condition.equals(name: MOBILE, value: 12.0),
        const Condition.equals(name: TABLET, value: 14.0),
        const Condition.equals(name: DESKTOP, value: 16.0),
      ]).value,
      color: Blue1,
      fontWeight: FontWeight.w700);
}

getTextTableDisabled(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 16.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 12.0),
        const Condition.equals(name: MOBILE, value: 12.0),
        const Condition.equals(name: TABLET, value: 14.0),
        const Condition.equals(name: DESKTOP, value: 16.0),
      ]).value,
      color: Blue1.withOpacity(0.7),
      fontWeight: FontWeight.w700);
}

getTextTableData(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 15.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 11.0),
        const Condition.equals(name: MOBILE, value: 11.0),
        const Condition.equals(name: TABLET, value: 13.0),
        const Condition.equals(name: DESKTOP, value: 15.0),
      ]).value,
      color: Blue1,
      fontWeight: FontWeight.w500);
}

getTextItemList(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 20.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 17.0),
        const Condition.equals(name: DESKTOP, value: 20.0),
      ]).value,
      color: Yellow1,
      fontWeight: FontWeight.w700);
}

getTextItemList2(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 17.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 14.0),
        const Condition.equals(name: DESKTOP, value: 17.0),
      ]).value,
      color: Yellow1,
      fontWeight: FontWeight.w500);
}

getTextTableDataDisabled(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 15.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 11.0),
        const Condition.equals(name: MOBILE, value: 11.0),
        const Condition.equals(name: TABLET, value: 13.0),
        const Condition.equals(name: DESKTOP, value: 15.0),
      ]).value,
      color: Blue1.withOpacity(0.7),
      fontWeight: FontWeight.w500);
}

getTextItemAppBar(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 14.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 10.0),
        const Condition.equals(name: MOBILE, value: 10.0),
        const Condition.equals(name: TABLET, value: 12.0),
        const Condition.equals(name: DESKTOP, value: 14.0),
      ]).value,
      color: light,
      fontWeight: FontWeight.w700);
}

getTextAlert(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 16.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 12.0),
        const Condition.equals(name: MOBILE, value: 12.0),
        const Condition.equals(name: TABLET, value: 14.0),
        const Condition.equals(name: DESKTOP, value: 16.0),
      ]).value,
      color: Yellow1,
      fontWeight: FontWeight.w300);
}

getTextAlertSub(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 8.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 8.0),
        const Condition.equals(name: MOBILE, value: 8.0),
        const Condition.equals(name: TABLET, value: 10.0),
        const Condition.equals(name: DESKTOP, value: 12.0),
      ]).value,
      color: Yellow1,
      fontWeight: FontWeight.w300);
}

getTextAlertBtn(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 14.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 10.0),
        const Condition.equals(name: MOBILE, value: 10.0),
        const Condition.equals(name: TABLET, value: 12.0),
        const Condition.equals(name: DESKTOP, value: 14.0),
      ]).value,
      color: Blue1,
      fontWeight: FontWeight.w400);
}

getTextAlertBtn2(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 14.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 10.0),
        const Condition.equals(name: MOBILE, value: 10.0),
        const Condition.equals(name: TABLET, value: 12.0),
        const Condition.equals(name: DESKTOP, value: 14.0),
      ]).value,
      color: light,
      fontWeight: FontWeight.w400);
}

getTextAlertMobile(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 17.0, valueWhen: [
        const Condition.equals(name: MOBILE, value: 17.0),
      ]).value,
      color: Yellow1,
      fontWeight: FontWeight.w300);
}

getTextAlertSubMobile(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 15.0, valueWhen: [
        const Condition.equals(name: MOBILE, value: 15.0),
      ]).value,
      color: Yellow1,
      fontWeight: FontWeight.w300);
}

getTextAlertBtnMobile(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 15.0, valueWhen: [
        const Condition.equals(name: MOBILE, value: 15.0),
      ]).value,
      color: Blue1,
      fontWeight: FontWeight.w400);
}

getTextAlertBtn2Mobile(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 15.0, valueWhen: [
        const Condition.equals(name: MOBILE, value: 15.0),
      ]).value,
      color: light,
      fontWeight: FontWeight.w400);
}

getTextMenu(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 36.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 36.0),
        const Condition.equals(name: MOBILE, value: 36.0),
        const Condition.equals(name: TABLET, value: 38.0),
        const Condition.equals(name: DESKTOP, value: 44.0),
      ]).value,
      color: Yellow1,
      fontFamily: "Inter",
      fontWeight: FontWeight.w900);
}

getTextItemMenu(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 16.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 13.0),
        const Condition.equals(name: MOBILE, value: 13.0),
        const Condition.equals(name: TABLET, value: 14.5),
        const Condition.equals(name: DESKTOP, value: 16.0),
      ]).value,
      color: Yellow1,
      fontFamily: "Inter",
      fontWeight: FontWeight.w800);
}

getTextItemSubMenu(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 13.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 10.0),
        const Condition.equals(name: MOBILE, value: 10.0),
        const Condition.equals(name: TABLET, value: 11.5),
        const Condition.equals(name: DESKTOP, value: 13.0),
      ]).value,
      color: Yellow1,
      fontFamily: "Inter",
      fontWeight: FontWeight.w700);
}

getTextHeaderJamKerja(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 11.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 9.0),
        const Condition.equals(name: MOBILE, value: 9.0),
        const Condition.equals(name: TABLET, value: 10.5),
        const Condition.equals(name: DESKTOP, value: 11.0),
      ]).value,
      color: Yellow1,
      fontFamily: "Inter",
      fontWeight: FontWeight.w600);
}

getTextItemSubMenuDisabled(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 13.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 10.0),
        const Condition.equals(name: MOBILE, value: 10.0),
        const Condition.equals(name: TABLET, value: 11.5),
        const Condition.equals(name: DESKTOP, value: 13.0),
      ]).value,
      fontFamily: "Inter",
      color: Yellow1.withOpacity(0.4),
      fontWeight: FontWeight.w700);
}

getText10ptBlue(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 12.5, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 10.5),
        const Condition.equals(name: MOBILE, value: 10.5),
        const Condition.equals(name: TABLET, value: 12.0),
        const Condition.equals(name: DESKTOP, value: 12.5),
      ]).value,
      color: Blue1);
}

getTextHintFormLogin(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 15.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 10.0),
        const Condition.equals(name: MOBILE, value: 10.0),
        const Condition.equals(name: TABLET, value: 12.0),
        const Condition.equals(name: DESKTOP, value: 15.0),
      ]).value,
      color: Grey1,
      fontWeight: FontWeight.w400);
}

getTextErrorFormLogin(BuildContext context) {
  return TextStyle(
    fontSize: ResponsiveValue(context, defaultValue: 10.0, valueWhen: [
      const Condition.smallerThan(name: DESKTOP, value: 8.0),
      const Condition.equals(name: MOBILE, value: 8.0),
      const Condition.equals(name: TABLET, value: 8.0),
      const Condition.equals(name: DESKTOP, value: 10.0),
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
        const Condition.smallerThan(name: DESKTOP, value: 14.0),
        const Condition.smallerThan(name: MOBILE, value: 14.0),
        const Condition.equals(name: MOBILE, value: 14.0),
        const Condition.equals(name: TABLET, value: 15.0),
        const Condition.equals(name: DESKTOP, value: 16.0),
      ]).value,
      color: Yellow1,
      fontWeight: FontWeight.w300);
}

getTextBtnAction(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 14.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 8.0),
        const Condition.smallerThan(name: MOBILE, value: 8.0),
        const Condition.equals(name: MOBILE, value: 8.0),
        const Condition.equals(name: TABLET, value: 12.0),
        const Condition.equals(name: DESKTOP, value: 14.0),
      ]).value,
      color: Yellow1,
      fontWeight: FontWeight.w700);
}

getTextBtnAction2(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 14.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 8.0),
        const Condition.smallerThan(name: MOBILE, value: 8.0),
        const Condition.equals(name: MOBILE, value: 8.0),
        const Condition.equals(name: TABLET, value: 12.0),
        const Condition.equals(name: DESKTOP, value: 14.0),
      ]).value,
      color: Blue1,
      fontWeight: FontWeight.w700);
}

getTextDialogFieldHeader(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 24.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 20.0),
        const Condition.smallerThan(name: MOBILE, value: 20.0),
        const Condition.equals(name: MOBILE, value: 20.0),
        const Condition.equals(name: TABLET, value: 22.0),
        const Condition.equals(name: DESKTOP, value: 24.0),
      ]).value,
      color: Yellow1,
      fontWeight: FontWeight.w900);
}

getTextDialogFieldHeader2(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 20.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 16.0),
        const Condition.smallerThan(name: MOBILE, value: 16.0),
        const Condition.equals(name: MOBILE, value: 16.0),
        const Condition.equals(name: TABLET, value: 18.0),
        const Condition.equals(name: DESKTOP, value: 20.0),
      ]).value,
      color: Yellow1,
      fontWeight: FontWeight.w900);
}

getTextBtn(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 14.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 8.0),
        const Condition.smallerThan(name: MOBILE, value: 8.0),
        const Condition.equals(name: MOBILE, value: 8.0),
        const Condition.equals(name: TABLET, value: 12.0),
        const Condition.equals(name: DESKTOP, value: 14.0),
      ]).value,
      color: Blue1,
      fontWeight: FontWeight.w700);
}

getTextLoginBtnDisabled(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 15.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 10.0),
        const Condition.equals(name: MOBILE, value: 10.0),
        const Condition.equals(name: TABLET, value: 12.0),
        const Condition.equals(name: DESKTOP, value: 15.0),
      ]).value,
      color: Yellow1.withOpacity(0.5));
}

getTextLupaSandi(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 11.0, valueWhen: [
        const Condition.smallerThan(name: DESKTOP, value: 10.0),
        const Condition.equals(name: MOBILE, value: 10.0),
        const Condition.equals(name: TABLET, value: 10.0),
        const Condition.equals(name: DESKTOP, value: 11.0),
      ]).value,
      color: Blue1,
      fontWeight: FontWeight.w500);
}

getTextHeaderWelcomeScreen(BuildContext context, double value) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: value, valueWhen: [
        Condition.equals(name: MOBILE, value: value),
      ]).value,
      color: Blue1,
      fontWeight: FontWeight.w800);
}

getTextSemiBoldHeaderWelcomeScreen(BuildContext context, double value) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: value, valueWhen: [
        Condition.equals(name: MOBILE, value: value),
      ]).value,
      color: Blue1,
      fontWeight: FontWeight.w700);
}

getTextSemiHeaderWelcomeScreen(BuildContext context, double value) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: value, valueWhen: [
        Condition.equals(name: MOBILE, value: value),
      ]).value,
      color: Blue1,
      fontWeight: FontWeight.w600);
}

getTextSubHeaderWelcomeScreen(BuildContext context, double value) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: value, valueWhen: [
        Condition.equals(name: MOBILE, value: value),
      ]).value,
      color: Blue1,
      fontWeight: FontWeight.w500);
}

getTextLoginBtnActiveMobile(BuildContext context) {
  var value = 12.sp;
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: value, valueWhen: [
        Condition.equals(name: MOBILE, value: value),
      ]).value,
      color: Yellow1);
}

getTextLupaSandiMobile(BuildContext context) {
  var value = 9.sp;
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: value, valueWhen: [
        Condition.equals(name: MOBILE, value: value),
      ]).value,
      color: Blue1,
      fontWeight: FontWeight.w500);
}

getTextHintFormLoginMobile(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 14.0, valueWhen: [
        const Condition.equals(name: MOBILE, value: 14.0),
      ]).value,
      color: Grey1,
      fontWeight: FontWeight.w400);
}

getTextErrorFormLoginMobile(BuildContext context) {
  return TextStyle(
    fontSize: ResponsiveValue(context, defaultValue: 13.0, valueWhen: [
      const Condition.equals(name: MOBILE, value: 13.0),
    ]).value,
    color: light,
    background: Paint()
      ..strokeWidth = 16
      ..color = errorBg
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round,
  );
}

getTextFormValueMobile(BuildContext context) {
  return TextStyle(
      fontSize: ResponsiveValue(context, defaultValue: 14.0, valueWhen: [
        const Condition.equals(name: MOBILE, value: 14.0),
      ]).value,
      color: dark);
}
