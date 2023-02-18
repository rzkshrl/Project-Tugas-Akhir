import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_tugas_akhir/app/utils/textfieldC.dart';
import 'package:sizer/sizer.dart';

import '../theme/textstyle.dart';
import '../theme/theme.dart';

final controller = Get.put(TextFieldController());

Widget textformNormalWeb(
  BuildContext context,
  Iterable<String>? autofillHints,
  TextInputType keyboardType,
  IconData prefixIcon,
  Color prefixIconColor,
  String hintText,
) {
  return Form(
    key: controller.emailKey.value,
    child: Container(
      width: 344,
      height: 65,
      child: TextFormField(
        autofillHints: autofillHints,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.emailAddress,
        validator: controller.emailValidator,
        controller: controller.emailC,
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
            hintStyle: getTextHintFormLogin(context),
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: dark),
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
    key: controller.passKey.value,
    child: Obx(
      () => Container(
        width: 344,
        height: 65,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofillHints: autofillHints,
          style: getTextLogin(context),
          validator: controller.passValidator,
          obscureText: controller.isPasswordHidden.value,
          controller: controller.passC,
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
                icon: Icon(controller.isPasswordHidden.value
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeSlash),
                onPressed: () {
                  controller.isPasswordHidden.value =
                      !controller.isPasswordHidden.value;
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
