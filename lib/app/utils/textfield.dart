import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/utils/textfieldC.dart';
import 'package:sizer/sizer.dart';

import '../theme/textstyle.dart';
import '../theme/theme.dart';

final textC = Get.put(TextFieldController());

Widget textformNormalWeb(
    BuildContext context,
    Key? key,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Iterable<String>? autofillHints,
    TextInputType? keyboardType,
    IconData? prefixIcon,
    Color? prefixIconColor,
    String hintText,
    Color fillColor,
    Color borderColor,
    Color focusedBorderColor) {
  return Form(
    key: key,
    child: Container(
      width: 344,
      height: 65,
      child: TextFormField(
        autofillHints: autofillHints,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.emailAddress,
        validator: validator,
        controller: controller,
        style: getTextLogin(context),
        decoration: InputDecoration(
            helperText: ' ',
            helperStyle: getTextErrorFormLogin(context),
            isDense: true,
            contentPadding: EdgeInsets.all(20),
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                left: 1.w,
                right: 0.8.w,
              ),
              child: Align(
                  widthFactor: 0.5,
                  heightFactor: 0.5,
                  child: Icon(
                    prefixIcon,
                    size: 26,
                  )),
            ),
            prefixIconColor: prefixIconColor,
            hintText: hintText,
            focusColor: Blue1,
            fillColor: fillColor,
            filled: true,
            errorStyle: getTextErrorFormLogin(context),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: errorBg, width: 1.8),
                borderRadius: BorderRadius.circular(12),
                gapPadding: 2),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: error, width: 1.8),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: focusedBorderColor, width: 1.8),
                borderRadius: BorderRadius.circular(12)),
            hintStyle: getTextHintFormLogin(context),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: borderColor),
                borderRadius: BorderRadius.circular(12))),
      ),
    ),
  );
}

Widget textformDatePicker(
    TextEditingController? controller, void Function()? onTap) {
  return Form(
    key: textC.datepickerKey.value,
    child: Container(
      width: 344,
      height: 65,
      child: TextFormField(
        readOnly: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: textC.normalValidator,
        controller: controller,
        style: getTextLogin(Get.context!),
        decoration: InputDecoration(
            helperText: ' ',
            helperStyle: getTextErrorFormLogin(Get.context!),
            isDense: true,
            contentPadding: EdgeInsets.all(20),
            suffixIcon: Padding(
              padding: EdgeInsets.only(
                left: 1.w,
                right: 0.8.w,
              ),
              child: IconButton(
                color: Blue1,
                splashRadius: 1,
                iconSize: 20,
                icon: Icon(IconlyLight.calendar),
                onPressed: onTap,
              ),
            ),
            suffixIconColor: Blue1,
            hintText: 'Pilih rentang tanggal presensi...',
            focusColor: Blue1,
            fillColor: light,
            filled: true,
            errorStyle: getTextErrorFormLogin(Get.context!),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: errorBg, width: 1.8),
                borderRadius: BorderRadius.circular(12),
                gapPadding: 2),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: error, width: 1.8),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Blue1, width: 1.8),
                borderRadius: BorderRadius.circular(12)),
            hintStyle: getTextHintFormLogin(Get.context!),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: dark),
                borderRadius: BorderRadius.circular(12))),
      ),
    ),
  );
}

Widget textformTimePicker(
    Key key, TextEditingController? controller, void Function()? onTap) {
  return Form(
    key: key,
    child: Container(
      width: 134,
      height: 55,
      child: TextFormField(
        readOnly: true,
        textAlign: TextAlign.center,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: textC.normalValidator,
        controller: controller,
        style: getTextFormJamKerja(Get.context!),
        decoration: InputDecoration(
            helperText: ' ',
            helperStyle: getTextErrorFormLogin(Get.context!),
            isDense: true,
            contentPadding: EdgeInsets.all(20),
            suffixIcon: Padding(
              padding: EdgeInsets.only(
                left: 1.w,
                right: 0.8.w,
              ),
              child: IconButton(
                color: light,
                splashRadius: 1,
                iconSize: 20,
                icon: Icon(IconlyLight.time_square),
                onPressed: onTap,
              ),
            ),
            suffixIconColor: light,
            hintText: '--:--',
            focusColor: Blue1,
            fillColor: Blue3,
            filled: true,
            errorStyle: getTextErrorFormLogin(Get.context!),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: errorBg, width: 1.8),
                borderRadius: BorderRadius.circular(12),
                gapPadding: 2),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: error, width: 1.8),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Blue1, width: 1.8),
                borderRadius: BorderRadius.circular(12)),
            hintStyle: getTextHintFormLogin(Get.context!),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Blue3),
                borderRadius: BorderRadius.circular(12))),
      ),
    ),
  );
}

Widget textformDialogWeb(
    BuildContext context,
    Key? key,
    double width,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Iterable<String>? autofillHints,
    TextInputType? keyboardType,
    IconData? prefixIcon,
    Color? prefixIconColor,
    String hintText,
    Color fillColor,
    Color borderColor,
    Color focusedBorderColor,
    bool enabled) {
  return Form(
    key: key,
    child: Container(
      width: width,
      height: 9.5.h,
      child: TextFormField(
        readOnly: enabled,
        autofillHints: autofillHints,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.emailAddress,
        validator: validator,
        controller: controller,
        style: getTextFormDialog(context),
        decoration: InputDecoration(
            helperText: ' ',
            helperStyle: getTextErrorFormLogin(context),
            isDense: true,
            contentPadding: EdgeInsets.all(20),
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                left: 1.w,
                right: 0.8.w,
              ),
              child: Align(
                  widthFactor: 0.5,
                  heightFactor: 0.5,
                  child: Icon(
                    prefixIcon,
                    size: 26,
                  )),
            ),
            prefixIconColor: prefixIconColor,
            hintText: hintText,
            focusColor: Blue1,
            fillColor: fillColor,
            filled: true,
            errorStyle: getTextErrorFormLogin(context),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: errorBg, width: 1.8),
                borderRadius: BorderRadius.circular(12),
                gapPadding: 2),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: error, width: 1.8),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: focusedBorderColor, width: 1.8),
                borderRadius: BorderRadius.circular(12)),
            hintStyle: getTextHintFormLogin(context),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: borderColor),
                borderRadius: BorderRadius.circular(12))),
      ),
    ),
  );
}

Widget textformPassWeb(
  BuildContext context,
  Iterable<String>? autofillHints,
  IconData prefixIcon,
  Color prefixIconColor,
  String hintText,
  void Function()? onEditingComplete,
) {
  return Form(
    key: textC.passWebKey.value,
    child: Obx(
      () => Container(
        width: 344,
        height: 65,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofillHints: autofillHints,
          style: getTextLogin(context),
          validator: textC.passValidator,
          obscureText: textC.isPasswordHidden.value,
          controller: textC.passWebC,
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
            helperText: ' ',
            helperStyle: getTextErrorFormLogin(context),
            isDense: true,
            contentPadding: EdgeInsets.all(20),
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                left: 1.w,
                right: 0.8.w,
              ),
              child: Align(
                  widthFactor: 0.5,
                  heightFactor: 0.5,
                  child: Icon(
                    prefixIcon,
                    size: 26,
                  )),
            ),
            prefixIconColor: prefixIconColor,
            hintText: hintText,
            hintStyle: getTextHintFormLogin(context),
            fillColor: light,
            filled: true,
            errorStyle: getTextErrorFormLogin(context),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: errorBg, width: 1.8),
                borderRadius: BorderRadius.circular(12),
                gapPadding: 2),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: error, width: 1.8),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Blue1, width: 1.8),
                borderRadius: BorderRadius.circular(12)),
            suffixIcon: Padding(
              padding: EdgeInsets.only(
                right: 0.35.w,
              ),
              child: IconButton(
                color: Blue1,
                splashRadius: 1,
                iconSize: 20,
                icon: Icon(textC.isPasswordHidden.value
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeSlash),
                onPressed: () {
                  textC.isPasswordHidden.value = !textC.isPasswordHidden.value;
                },
              ),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: dark),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    ),
  );
}

Widget textformNormalMobile(
    BuildContext context,
    Key? key,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Iterable<String>? autofillHints,
    TextInputType? keyboardType,
    IconData? prefixIcon,
    Color? prefixIconColor,
    String hintText,
    Color fillColor,
    Color borderColor,
    Color focusedBorderColor) {
  return Form(
    key: key,
    child: Container(
      width: 254,
      height: 70,
      child: TextFormField(
        autofillHints: autofillHints,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.emailAddress,
        validator: validator,
        controller: controller,
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        style: getTextFormValueMobile(context),
        decoration: InputDecoration(
            helperText: ' ',
            helperStyle: getTextErrorFormLoginMobile(context),
            isDense: true,
            contentPadding: EdgeInsets.all(20),
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                left: 1.w,
                right: 0.8.w,
              ),
              child: Align(
                  widthFactor: 0.5,
                  heightFactor: 0.5,
                  child: Icon(
                    prefixIcon,
                    size: 24,
                  )),
            ),
            prefixIconColor: prefixIconColor,
            hintText: hintText,
            focusColor: Blue1,
            fillColor: fillColor,
            filled: true,
            errorStyle: getTextErrorFormLoginMobile(context),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: errorBg, width: 1.8),
                borderRadius: BorderRadius.circular(12),
                gapPadding: 2),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: error, width: 1.8),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: focusedBorderColor, width: 1.8),
                borderRadius: BorderRadius.circular(12)),
            hintStyle: getTextHintFormLoginMobile(context),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: borderColor),
                borderRadius: BorderRadius.circular(12))),
      ),
    ),
  );
}

Widget textformPassMobile(
  BuildContext context,
  Iterable<String>? autofillHints,
  IconData prefixIcon,
  Color prefixIconColor,
  String hintText,
  void Function()? onEditingComplete,
) {
  return Form(
    key: textC.passMobileKey.value,
    child: Obx(
      () => Container(
        width: 254,
        height: 70,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofillHints: autofillHints,
          style: getTextFormValueMobile(context),
          validator: textC.passValidator,
          obscureText: textC.isPasswordHidden.value,
          controller: textC.passMobileC,
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
            helperText: ' ',
            helperStyle: getTextErrorFormLoginMobile(context),
            isDense: true,
            contentPadding: EdgeInsets.all(20),
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                left: 1.w,
                right: 0.8.w,
              ),
              child: Align(
                  widthFactor: 0.5,
                  heightFactor: 0.5,
                  child: Icon(
                    prefixIcon,
                    size: 24,
                  )),
            ),
            prefixIconColor: prefixIconColor,
            hintText: hintText,
            hintStyle: getTextHintFormLoginMobile(context),
            fillColor: light,
            filled: true,
            errorStyle: getTextErrorFormLoginMobile(context),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: errorBg, width: 1.8),
                borderRadius: BorderRadius.circular(12),
                gapPadding: 2),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: error, width: 1.8),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Blue1, width: 1.8),
                borderRadius: BorderRadius.circular(12)),
            suffixIcon: Padding(
              padding: EdgeInsets.only(
                right: 0.35.w,
              ),
              child: IconButton(
                color: Blue1,
                splashRadius: 1,
                iconSize: 18,
                icon: Icon(textC.isPasswordHidden.value
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeSlash),
                onPressed: () {
                  textC.isPasswordHidden.value = !textC.isPasswordHidden.value;
                },
              ),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: dark),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    ),
  );
}
