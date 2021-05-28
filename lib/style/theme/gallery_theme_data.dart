// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsThemeData {
  ///MARK: dev_d нужно добавить стили текста
  /// комментарии ниже не удалять
  ///
  /// headLine2 -например: названия экранов как на мокапе
  /// headline3 -например: текст с выбора категорий
  /// headLine4 - bold текст на кнопках и т.д.
  ///
  /// так же добавить остальные цвета правильно
  /// см класс Theme.of(context).    Theme.of(context).[cardColor,error,..]
  ///
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  ///MARK: dev_d поменять на цвет который с дизайна картоски,
  /// понятное дело что должно быть 2 цвета (черная и белая тема)
  static final Color saveButtonColor = Color(0xFFFC2D55);
  static final Color menuUnselectedIconColor = Color(0xFFA1A1A1);
  static final Color settingsButtonColor = Color(0xFFD1D1D6);
  static final Color toggleableActiveColor = Color(0xFFFFCC00);
  static final Color settingsFirstLightColor = Color(0xFFD4DDE6);
  static final Color settingsFirstDarkColor = Color(0xFF313131);
  static final Color settingsSecondDarkColor = Color(0xFF26242f);
  static final Color bottomBarBackgroundColor = Color(0xFF0C0B0B);

  static final Color buttonMainColor = Color(0xFF9B51E0);
  static final Color _bottomAppBarColor = Color(0xFFA1A1A1);
  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.black.withOpacity(0.3),
          modalBackgroundColor: Colors.white.withOpacity(0.3),
        ),
        backgroundColor: colorScheme.background,
        toggleableActiveColor: Colors.white,
        colorScheme: colorScheme,
        bottomAppBarColor: _bottomAppBarColor,
        textTheme: _textTheme.apply(displayColor: colorScheme.primary),
//      // Matches manifest.json colors and background color.
        primaryColor: colorScheme.primary,
        cardColor: colorScheme.onBackground,
        appBarTheme: AppBarTheme(
          textTheme: _textTheme.apply(bodyColor: colorScheme.primary),
          color: colorScheme.background,
          elevation: 0,
          iconTheme: IconThemeData(color: colorScheme.secondary),
          brightness: colorScheme.brightness,
        ),
        iconTheme: IconThemeData(color: colorScheme.secondary),
        canvasColor: colorScheme.background,
        scaffoldBackgroundColor: colorScheme.background,
        highlightColor: Colors.transparent,
        accentColor: colorScheme.primary,
        focusColor: focusColor,
        buttonColor: buttonMainColor,
        secondaryHeaderColor: colorScheme.onSecondary,

        ///MARK:change page transition
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color.alphaBlend(
            _lightFillColor.withOpacity(0.80),
            _darkFillColor,
          ),
          contentTextStyle: _textTheme.subtitle1.apply(color: _darkFillColor),
        ),
        dialogBackgroundColor: colorScheme.surface,
        cursorColor: colorScheme.secondary,
        errorColor: saveButtonColor,
        hintColor: colorScheme.primary.withOpacity(0.3),
        splashColor: Colors.transparent);
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Colors.black,
    primaryVariant: Color(0xFF5D3DF3),
    secondary: Colors.black,
    secondaryVariant: Color(0xFFEFF3F3),
    background: Color(0xFFdedede),
    surface: Color(0xFFEFEFF4),
    onBackground: Colors.white,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFFF7F7F7), //mark: bottom bar color
    onSurface: _lightFillColor,
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Colors.teal,
    primaryVariant: Color(0xFF5D3DF3),
    secondary: Color(0xFFFF9500),
    secondaryVariant: Color(0xFFFFCC00),
    background: Color(0xFF181822),
    surface: Color(0x0DFFFFFF),
    onBackground: Color(0xFF26262E), // White with 0.05 opacity
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: Color(0xFF2d2d36), //mark: bottom bar color
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  static const _ultralight = FontWeight.w100;
  static const _thin = FontWeight.w200;
  static const _light = FontWeight.w300;
  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semibold = FontWeight.w600;
  static const _bold = FontWeight.w700;
  static const _heavy = FontWeight.w800;
  static const _black = FontWeight.w900;

  static final TextTheme _textTheme = TextTheme(
    headline1: TextStyle(
        fontFamily: 'SFProDisplay',
        fontWeight: _bold,
        fontSize: 40.0,
        letterSpacing: 1.21),
    headline2: TextStyle(
        fontFamily: 'SFProDisplay',
        fontWeight: _bold,
        fontSize: 28,
        letterSpacing: 1.29),
    headline3: TextStyle(
        fontFamily: 'SFProText',
        fontWeight: _bold,
        fontSize: 22.0,
        letterSpacing: 1.45),
    headline4: TextStyle(
        fontFamily: 'SFProDisplay',
        fontWeight: _bold,
        fontSize: 20,
        letterSpacing: 1.9),
    bodyText1: TextStyle(
        fontFamily: 'SFProDisplay',
        fontWeight: _regular,
        fontSize: 17.0,
        letterSpacing: -2.41),
    button: TextStyle(
        fontFamily: 'SFProDisplay',
        fontWeight: _semibold,
        fontSize: 17.0,
        letterSpacing: 0),
    subtitle1: TextStyle(
        fontFamily: 'SFProText',
        fontWeight: _regular,
        fontSize: 15.0,
        letterSpacing: -1.6),
    caption: TextStyle(
        fontFamily: 'SFProDisplay', fontWeight: _regular, fontSize: 12.0),
    overline: TextStyle(
        fontFamily: 'SFProText',
        fontWeight: _regular,
        fontSize: 11.0,
        letterSpacing: 0.64),
    subtitle2:
        TextStyle(fontFamily: 'SFProText', fontWeight: _bold, fontSize: 15.0),
    bodyText2: TextStyle(
        fontFamily: 'SFProText',
        fontWeight: _regular,
        fontSize: 17.0,
        letterSpacing: -0.24),
    headline6: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 16.0),
  );
}
