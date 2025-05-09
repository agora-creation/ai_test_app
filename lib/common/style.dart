import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const kBackgroundColor = Color(0xFFFCE4EC);
const kMainColor = Color(0xFFF06292);
const kWhiteColor = Color(0xFFFFFFFF);
const kBlackColor = Color(0xFF333333);

ThemeData customTheme() {
  return ThemeData(
    scaffoldBackgroundColor: kBackgroundColor,
    fontFamily: 'SourceHanSansJP-Regular',
    appBarTheme: const AppBarTheme(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      centerTitle: false,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      titleTextStyle: TextStyle(
        color: kBlackColor,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'SourceHanSansJP-Bold',
      ),
      iconTheme: IconThemeData(
        color: kBlackColor,
        size: 18,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: kBlackColor, fontSize: 18),
      bodyMedium: TextStyle(color: kBlackColor, fontSize: 18),
      bodySmall: TextStyle(color: kBlackColor, fontSize: 18),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    unselectedWidgetColor: kWhiteColor,
  );
}
