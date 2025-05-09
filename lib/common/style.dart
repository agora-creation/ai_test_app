import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const kBackgroundColor = Color(0xFFFCE4EC);
const kMainColor = Color(0xFFF06292);
const kWhiteColor = Color(0xFFFFFFFF);
const kBlackColor = Color(0xFF333333);

ThemeData customTheme() {
  return ThemeData(
    scaffoldBackgroundColor: kBackgroundColor,
    fontFamily: 'TekitouPoem_Bold',
    appBarTheme: const AppBarTheme(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: TextStyle(
        color: kBlackColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'TekitouPoem_Bold',
      ),
      iconTheme: IconThemeData(
        color: kBlackColor,
        size: 20,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: kBlackColor, fontSize: 20),
      bodyMedium: TextStyle(color: kBlackColor, fontSize: 20),
      bodySmall: TextStyle(color: kBlackColor, fontSize: 20),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    unselectedWidgetColor: kWhiteColor,
  );
}
