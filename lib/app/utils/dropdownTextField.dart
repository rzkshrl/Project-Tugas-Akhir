import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:project_tugas_akhir/app/theme/textstyle.dart';
import 'package:sizer/sizer.dart';

import '../theme/theme.dart';
import 'dropdownTextFieldC.dart';

final cDropdown = Get.put(DropdownTextFieldController());

Widget dropdownNormalField(
    BuildContext context,
    double width,
    Key? key,
    void Function(String?)? onChanged,
    List<String> items,
    IconData? prefixIcon,
    String hintText,
    Color containerColor,
    Color borderColor,
    Color focusedBorderColor,
    Color clearBtnColor) {
  return Form(
    key: key,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: width,
          height: 7.3.h,
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownSearch<String>(
            // key: _divisi,
            clearButtonProps:
                ClearButtonProps(isVisible: true, color: clearBtnColor),
            items: items,
            onChanged: onChanged,
            dropdownDecoratorProps: DropDownDecoratorProps(
                baseStyle: getTextFormDialog(context),
                dropdownSearchDecoration: InputDecoration(
                    prefixIcon: Align(
                        widthFactor: 0.5,
                        heightFactor: 0.5,
                        child: Icon(
                          prefixIcon,
                          size: 26,
                        )),
                    hintText: hintText,
                    hintStyle: getTextHintFormLogin(context),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: focusedBorderColor, width: 1.8),
                        borderRadius: BorderRadius.circular(12)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: borderColor, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ))),
            popupProps: PopupProps.menu(
              constraints: BoxConstraints(maxHeight: 18.h),
              scrollbarProps:
                  ScrollbarProps(trackVisibility: true, trackColor: dark),
              fit: FlexFit.loose,
              menuProps: MenuProps(
                borderRadius: BorderRadius.circular(12),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              containerBuilder: (ctx, popupWidget) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                    ),
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                            color: light,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 0.5),
                                  blurRadius: 1,
                                  color: dark.withOpacity(0.5))
                            ],
                            borderRadius: BorderRadius.circular(12)),
                        child: popupWidget,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}