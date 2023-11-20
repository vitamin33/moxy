import 'package:flutter/material.dart';

class AppTheme extends InheritedWidget {
  //spaces
  static const double cardPadding = 24;
  static const double elementSpacing = cardPadding * 0.5;
  static const Widget smallSpace = SizedBox(width: 10);
  static const double bottomNavBarHeight = 64;
  static const Duration animationDuration = Duration(milliseconds: 300);
  static BorderRadius cardRadius = BorderRadius.circular(14);
  static const double iconSize = cardPadding;

  static const Color textColor = Color(0xFF0C0C0C);
  static const Color blackLight = Color(0xFF292031);
  static const Color secondaryColor = Color(0xFF75565B);
  static const Color selectedColor = Color(0xFF5E1133);
  static const Color primaryColor = Color(0xFFBC004B);
  static const Color onPrimaryContainerColor = Color(0xFF400014);
  static const Color primaryContainerColor = Color(0xFFFFD9DE);
  static const Color surfaceColor = Color(0xFFF3DDDF);
  static const Color pinkAvarage = Color(0xFFF489C0);
  static const Color pink = Color(0xFFFFEBFD);
  static const Color black = Color(0xFF0C0C0C);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray = Color(0xFF9BA4B8);
  static const Color darkPink = Color(0xFFD8BFD5);
  static const Color red = Color(0xFFF14336);
  static const Color greyLigth = Color(0xFFF0F1F5);
  static const Color pinkDark = Color(0xFFEF5DA8);
  static const Color greyDark = Color(0xFF555555);
  static const Color violet = Color(0xFFD5C0F9);
  static const Color green = Color(0xFFBEFAA8);
  static const Color orange = Color(0xFFFFA500);
  static const Color greenDark = Color.fromARGB(255, 91, 203, 50);

  static const double buttonHeight = 50;

  static const double chekoutPadding = 48.0;
  static Size size(BuildContext context) => MediaQuery.of(context).size;
  static const double drawerWidth = 280;

  final TextStyle invisibleText = const TextStyle(fontSize: 0);

  final TextStyle xSmallText = const TextStyle(
      fontSize: 10, fontFamily: 'Poppins', fontWeight: FontWeight.w400);
  final TextStyle smallText = const TextStyle(
      fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w400);

  final TextStyle smallSemiBoltText = const TextStyle(
      fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w500);

  final TextStyle smallBoltText = const TextStyle(
      fontSize: 12, fontFamily: 'Poppins', fontWeight: FontWeight.w600);

  final TextStyle mediumText = const TextStyle(
      fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w400);

  final TextStyle mediumSemiBoltText = const TextStyle(
      fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w500);

  final TextStyle mediumBoltText = const TextStyle(
      fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w600);

  final TextStyle largeText = const TextStyle(
      fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w400);

  final TextStyle largeSemiBoltText = const TextStyle(
      fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w500);

  final TextStyle largeBoltText = const TextStyle(
      fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w600);

  final TextStyle titleText = const TextStyle(
      fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w400);

  final TextStyle titleSemiBoltText = const TextStyle(
      fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w500);

  final TextStyle titleBoltText = const TextStyle(
      fontSize: 18, fontFamily: 'Poppins', fontWeight: FontWeight.w600);

  final TextStyle headlineText = const TextStyle(
      fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w400);

  final TextStyle headlineSemiBoltText = const TextStyle(
      fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w500);

  final TextStyle headlineBoltText = const TextStyle(
      fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w600);

  final TextStyle headline2Text = const TextStyle(
      fontSize: 22, fontFamily: 'Poppins', fontWeight: FontWeight.w600);

  final TextStyle headline2BoltText = const TextStyle(
      fontSize: 22, fontFamily: 'Poppins', fontWeight: FontWeight.w600);

  final TextStyle headline3BoltText = const TextStyle(
      fontSize: 28, fontFamily: 'Poppins', fontWeight: FontWeight.w600);

  final TextStyle headline4SemiBoltText = const TextStyle(
      fontSize: 36, fontFamily: 'Poppins', fontWeight: FontWeight.w500);
  final TextStyle headline4BoltText = const TextStyle(
      fontSize: 36, fontFamily: 'Poppins', fontWeight: FontWeight.w600);

  final TextStyle bigTitleText = const TextStyle(
      fontSize: 42, fontFamily: 'Poppins', fontWeight: FontWeight.w400);

  final TextStyle bigTitleSemiBoltText = const TextStyle(
      fontSize: 42, fontFamily: 'Poppins', fontWeight: FontWeight.w500);

  final TextStyle bigTitleBoltText = const TextStyle(
      fontSize: 42, fontFamily: 'Poppins', fontWeight: FontWeight.w600);

  const AppTheme({super.key, required Widget child}) : super(child: child);

  static AppTheme? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppTheme>();
  }

  @override
  bool updateShouldNotify(covariant AppTheme oldWidget) {
    return false;
  }
}
