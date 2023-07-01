import 'package:flutter/material.dart';

class AppTheme {
  //spaces
  static const double cardPadding = 24;
  static const double elementSpacing = cardPadding * 0.5;
  static const double bottomNavBarHeight = 64;
  static const Duration animationDuration = Duration(milliseconds: 300);
  static BorderRadius cardRadius = BorderRadius.circular(14);
  static const double iconSize = cardPadding;

  static const Color blackLight = Color(0xFF292031);
  static const Color secondaryColor = Color(0xFF75565B);
  static const Color primaryColor = Color(0xFFBC004B);
  static const Color onPrimaryContainerColor = Color(0xFF400014);
  static const Color primaryContainerColor = Color(0xFFFFD9DE);
  static const Color surfaceColor = Color(0xFFF3DDDF);
  static const Color pink = Color(0xFFFFEBFD);
  static const Color black = Color(0xFF0C0C0C);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray = Color(0xFF9BA4B8);
  static const Color darkPink = Color(0xFFD8BFD5);
  static const Color red = Color(0xFFF14336);
  static const Color greyLigth = Color(0xFFF0F1F5);
  static const Color pinkDark = Color(0xFFEF5DA8);
  static const Color greyDark = Color(0xFFB3B3B3);
  static const Color violet = Color(0xFFD5C0F9);
  static const Color green = Color(0xFFBEFAA8);

  static const double buttonHeight = 50;
  static Size size(BuildContext context) => MediaQuery.of(context).size;
  static const double drawerWidth = 280;
}
