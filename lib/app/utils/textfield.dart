import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:monitorpresensi/app/utils/textfieldC.dart';
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
    child: SizedBox(
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
            contentPadding: const EdgeInsets.all(20),
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
    TextEditingController? controller,
    void Function()? onTap,
    double width,
    Color fillColor,
    Color focusedBorderColor,
    Color enabledBorderColor,
    Color suffixIconColor,
    TextStyle style,
    IconData? prefixIcon) {
  return Form(
    key: textC.datepickerKey.value,
    child: Container(
      width: width,
      height: 9.2.h,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        readOnly: true,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: textC.normalValidator,
        controller: controller,
        style: style,
        decoration: InputDecoration(
            helperText: ' ',
            helperStyle: getTextErrorFormLogin(Get.context!),
            isDense: true,
            contentPadding: const EdgeInsets.all(20),
            prefixIcon: Align(
                widthFactor: 0.5,
                heightFactor: 0.5,
                child: Icon(
                  prefixIcon,
                  size: 26,
                )),
            suffixIcon: Padding(
              padding: EdgeInsets.only(
                left: 1.w,
                right: 0.8.w,
              ),
              child: IconButton(
                color: suffixIconColor,
                splashRadius: 1,
                iconSize: 20,
                icon: const Icon(IconlyLight.calendar),
                onPressed: onTap,
              ),
            ),
            suffixIconColor: Blue1,
            hintText: 'Pilih rentang tanggal presensi...',
            focusColor: Blue1,
            fillColor: fillColor,
            filled: true,
            errorStyle: getTextErrorFormLogin(Get.context!),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: errorBg, width: 1.8),
                borderRadius: BorderRadius.circular(12),
                gapPadding: 1),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: error, width: 1.8),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: focusedBorderColor, width: 1.8),
                borderRadius: BorderRadius.circular(12)),
            hintStyle: getTextHintFormLogin(Get.context!),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: enabledBorderColor),
                borderRadius: BorderRadius.circular(12))),
      ),
    ),
  );
}

Widget textformTimePicker(
    Key key, TextEditingController? controller, void Function()? onTap) {
  return Form(
    key: key,
    child: SizedBox(
      width: 124,
      height: 8.h,
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
            contentPadding: const EdgeInsets.all(20),
            suffixIcon: Padding(
              padding: EdgeInsets.only(
                left: 1.w,
                right: 0.8.w,
              ),
              child: IconButton(
                color: light,
                splashRadius: 1,
                iconSize: 20,
                icon: const Icon(IconlyLight.time_square),
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
    child: SizedBox(
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
            contentPadding: const EdgeInsets.all(20),
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
      () => SizedBox(
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
            contentPadding: const EdgeInsets.all(20),
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

Widget textformPassWebDialog(
  BuildContext context,
  Key key,
  TextEditingController controller,
  IconData? prefixIcon,
  Color? prefixIconColor,
  String hintText,
  bool enabled,
  bool enabled2,
  double width,
) {
  return Form(
    key: key,
    child: Obx(
      () => SizedBox(
        width: width,
        height: 65,
        child: TextFormField(
          enabled: enabled2,
          readOnly: enabled,
          style: getTextFormDialog(context),
          validator: textC.passValidator,
          obscureText: textC.isPasswordHidden.value,
          controller: controller,
          decoration: InputDecoration(
            helperText: ' ',
            helperStyle: getTextErrorFormLogin(context),
            isDense: true,
            contentPadding: const EdgeInsets.all(20),
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
            fillColor: Colors.transparent,
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
                borderSide: BorderSide(color: Yellow1, width: 1.8),
                borderRadius: BorderRadius.circular(12)),
            suffixIcon: Padding(
              padding: EdgeInsets.only(
                right: 0.35.w,
              ),
              child: IconButton(
                color: Yellow1,
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
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Yellow1),
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
    child: SizedBox(
      width: 68.5.w,
      height: 70,
      child: TextFormField(
        autofillHints: autofillHints,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.emailAddress,
        validator: validator,
        controller: controller,
        onTap: () {
          // FocusScopeNode currentFocus = FocusScope.of(context);

          // if (!currentFocus.hasPrimaryFocus) {
          //   currentFocus.unfocus();
          // }
        },
        style: getTextFormValueMobile(context),
        decoration: InputDecoration(
            helperText: ' ',
            helperStyle: getTextErrorFormLoginMobile(context),
            isDense: true,
            contentPadding: const EdgeInsets.all(20),
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

Widget textformNormalMobile2(
    BuildContext context,
    Key? key,
    TextEditingController? controller,
    String? Function(String?)? validator,
    IconData? prefixIcon,
    Color? prefixIconColor,
    String hintText,
    Color fillColor,
    Color borderColor,
    Color focusedBorderColor) {
  return Form(
    key: key,
    child: SizedBox(
      width: 68.5.w,
      height: 70,
      child: TextFormField(
        validator: validator,
        controller: controller,
        // onTap: () {
        //   FocusScopeNode currentFocus = FocusScope.of(context);

        //   if (!currentFocus.hasPrimaryFocus) {
        //     currentFocus.unfocus();
        //   }
        // },
        style: getTextFormValueMobile(context),
        decoration: InputDecoration(
            // helperText: ' ',
            // helperStyle: getTextErrorFormLoginMobile(context),
            // contentPadding: const EdgeInsets.all(20),
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
      () => SizedBox(
        width: 68.5.w,
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
            contentPadding: const EdgeInsets.all(20),
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

Widget textformPassMobile2(
  BuildContext context,
  Iterable<String>? autofillHints,
  Key? key,
  TextEditingController? controller,
  TextInputType? keyboardType,
  IconData? prefixIcon,
  Color? prefixIconColor,
  String hintText,
  RxBool hidePass,
) {
  return Form(
    key: key,
    child: Obx(
      () => SizedBox(
        width: 68.5.w,
        height: 70,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          autofillHints: autofillHints,
          style: getTextFormValueMobile(context),
          validator: textC.passValidator,
          obscureText: hidePass.value,
          controller: controller,
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          decoration: InputDecoration(
            helperText: ' ',
            helperStyle: getTextErrorFormLoginMobile(context),
            isDense: true,
            contentPadding: const EdgeInsets.all(20),
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
                icon: Icon(hidePass.value
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeSlash),
                onPressed: () {
                  hidePass.value = !hidePass.value;
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
