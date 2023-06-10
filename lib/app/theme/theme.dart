// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Color light = HexColor('#FFFFFF');
Color dark = HexColor('#000000');
Color backgroundBlue = HexColor('#0E3566');
Color Blue1 = HexColor('#2F318B');
Color Blue2 = HexColor('#0A88D4').withOpacity(0.3);
Color Blue3 = HexColor('#1D5DB0');
Color Blue4 = HexColor('#244BA2');
Color Yellow1 = HexColor('#F8F30B');
Color Grey1 = HexColor('#808080');
Color Grey2 = HexColor('#868D95');
Color Grey3 = HexColor('#D9D9D9');
Color error = HexColor('#FF0000');
Color redAppoint = HexColor('#6C7D01');
Color errorBg = HexColor('#FF6C6C');

MaterialStateProperty<Color?>? thumbColorScrollbar =
    MaterialStateProperty.resolveWith<Color?>((states) {
  if (states.contains(MaterialState.dragged)) {
    return Blue1;
  } else if (states.contains(MaterialState.hovered)) {
    return Blue1.withOpacity(0.8);
  }
  return Blue1.withOpacity(0.4);
});

MaterialStateProperty<Color?>? fillColorRadioButton =
    MaterialStateProperty.resolveWith<Color?>((states) {
  if (states.contains(MaterialState.selected)) {
    return light;
  } else if (states.contains(MaterialState.hovered)) {
    return light.withOpacity(0.8);
  }
  return light.withOpacity(0.4);
});

MaterialStateProperty<Color?>? trackColorScrollbar =
    MaterialStateProperty.resolveWith<Color?>((states) {
  if (states.contains(MaterialState.dragged)) {
    return Blue1;
  } else if (states.contains(MaterialState.hovered)) {
    return Blue1.withOpacity(0.8);
  }
  return Blue1.withOpacity(0.4);
});
