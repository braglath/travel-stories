import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:travel_diaries/app/data/utils/color_resources.dart';

class Themes {
  //! LIGHT THEME DATA
  static final light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: ColorResourcesLight.mainLIGHTScaffoldBG,
    backgroundColor: ColorResourcesLight.mainLIGHTScaffoldBG,
    primaryColorLight: ColorResourcesLight.mainLIGHTColor,
    splashColor: ColorResourcesLight.mainLIGHTSplashColor,
    disabledColor: Colors.grey[500],
    highlightColor: ColorResourcesLight.mainLIGHTSplashColor,
    hintColor: Colors.black,
    //

    snackBarTheme: const SnackBarThemeData(
        backgroundColor: ColorResourcesDark.mainDARKColor2, elevation: 4),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: ColorResourcesLight.mainLIGHTColor,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        side: const BorderSide(color: Colors.white, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorResourcesLight.mainLIGHTColor, elevation: 4),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      backgroundColor: ColorResourcesLight.mainLIGHTAPPBARcolor,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    dividerTheme: DividerThemeData(thickness: 2, color: Colors.grey.shade700),
    chipTheme: ChipThemeData(
        backgroundColor: Colors.grey.shade500,
        disabledColor: Colors.grey.shade700,
        selectedColor: ColorResourcesLight.mainLIGHTColor,
        secondarySelectedColor: ColorResourcesLight.mainLIGHTColor2,
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        brightness: Brightness.light,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
        secondaryLabelStyle: TextStyle(fontWeight: FontWeight.w500),
        elevation: 4),

// ! input decoration
    inputDecorationTheme: InputDecorationTheme(
      
      labelStyle: const TextStyle(
          color: ColorResourcesLight.mainTextHEADINGColor,
          fontWeight: FontWeight.bold,
          fontSize: 20),
      fillColor: ColorResourcesLight.mainLIGHTAPPBARcolor,
      errorStyle: const TextStyle().copyWith(
          color: ColorResourcesLight.mainTextHEADINGColor,
          fontWeight: FontWeight.bold,
          fontSize: 17),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide:
            BorderSide(width: 2, color: ColorResourcesLight.mainLIGHTColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 2.0,
        ),
      ),
    ),

    textTheme: TextTheme(
      headline1: const TextStyle().copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 45,
          color: ColorResourcesLight.mainTextHEADINGColor,
          fontFamily: 'josefin_sans'),
      headline2: const TextStyle().copyWith(
          color: ColorResourcesLight.mainTextHEADINGColor,
          fontWeight: FontWeight.bold,
          fontSize: 35),
      headline3: const TextStyle().copyWith(
          color: ColorResourcesLight.mainTextHEADINGColor,
          fontWeight: FontWeight.bold,
          fontSize: 25),
      headline4: const TextStyle().copyWith(
          color: ColorResourcesLight.mainTextHEADINGColor,
          fontWeight: FontWeight.bold,
          fontSize: 17),
      caption: const TextStyle().copyWith(
          color: Colors.grey.shade500,
          fontWeight: FontWeight.bold,
          fontSize: 15),
    ).apply(bodyColor: Colors.black, fontFamily: 'Noto_Sans'),
  );

  //! DARK THEME DATA
  static final dark = ThemeData.dark().copyWith(
    backgroundColor: ColorResourcesDark.mainDARKScaffoldBG,
    primaryColorDark: ColorResourcesDark.mainDARKColor,
    scaffoldBackgroundColor: ColorResourcesDark.mainDARKScaffoldBG,
    splashColor: ColorResourcesDark.mainDARKSplashColor,
    disabledColor: Colors.grey[500],
    highlightColor: ColorResourcesDark.mainDARKSplashColor,
    hintColor: Colors.black,

    //

    snackBarTheme: const SnackBarThemeData(
        backgroundColor: ColorResourcesLight.mainLIGHTColor2, elevation: 4),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: ColorResourcesDark.mainDARKColor,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        side: const BorderSide(color: Colors.white, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorResourcesDark.mainDARKColor),

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(
          color: ColorResourcesDark.mainDARKTEXTICONcolor,
          fontWeight: FontWeight.bold,
          fontSize: 20),
      backgroundColor: ColorResourcesDark.mainDARKAPPBARcolor,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorResourcesDark.mainDARKTEXTICONcolor),
    ),
    dividerTheme: DividerThemeData(
        thickness: 2, color: ColorResourcesDark.mainDARKDIVIDERcolor),

    chipTheme: ChipThemeData(
        backgroundColor: Colors.grey.shade500,
        disabledColor: Colors.grey.shade700,
        selectedColor: ColorResourcesDark.mainDARKColor,
        secondarySelectedColor: ColorResourcesDark.mainDARKColor2,
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        brightness: Brightness.dark,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
        secondaryLabelStyle: TextStyle(fontWeight: FontWeight.w500),
        elevation: 4),

    // ! input decoration
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
          color: ColorResourcesDark.mainDARKTEXTICONcolor,
          fontWeight: FontWeight.bold,
          fontSize: 20),
      fillColor: ColorResourcesDark.mainDARKAPPBARcolor,
      errorStyle: const TextStyle().copyWith(
          color: ColorResourcesLight.mainTextHEADINGColor,
          fontWeight: FontWeight.bold,
          fontSize: 17),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide:
            BorderSide(width: 2, color: ColorResourcesDark.mainDARKColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 2.0,
        ),
      ),
    ),

    textTheme: TextTheme(
      headline1: const TextStyle().copyWith(
          color: ColorResourcesDark.mainDARKTEXTICONcolor,
          fontWeight: FontWeight.bold,
          fontFamily: 'josefin_sans',
          fontSize: 45),
      headline2: const TextStyle().copyWith(
          color: ColorResourcesDark.mainDARKTEXTICONcolor,
          fontWeight: FontWeight.bold,
          fontSize: 35),
      headline3: const TextStyle().copyWith(
          color: ColorResourcesDark.mainDARKTEXTICONcolor,
          fontWeight: FontWeight.bold,
          fontSize: 25),
      headline4: const TextStyle().copyWith(
          color: ColorResourcesDark.mainDARKTEXTICONcolor,
          fontWeight: FontWeight.bold,
          fontSize: 17),
      caption: const TextStyle().copyWith(
          color: Colors.grey.shade300,
          fontWeight: FontWeight.bold,
          fontSize: 15),
    ).apply(bodyColor: Colors.black, fontFamily: 'Noto_Sans'),
  );
}
