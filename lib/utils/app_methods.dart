import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

Color hexToColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

String currencyToWords(double price) {
  // Get the integer part
  int integerPart = price.toInt();

  // Get the decimal part
  int decimalPart = ((price - integerPart) * 1000).toInt();
  String decimalPartInWords = decimalPart.toFrench();
  String integerPartInWords = integerPart.toFrench();
  if (decimalPart != 0) {
    if (integerPart == 0) {
      return "$decimalPartInWords millimes";
    }
    return "$integerPartInWords Dinars $decimalPartInWords millimes";
  }

  return "$integerPartInWords Dinars";
}
