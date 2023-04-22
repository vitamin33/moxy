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

  static const double buttonHeight = 50;
  static Size size(BuildContext context) => MediaQuery.of(context).size;
  static const double drawerWidth = 280;
}
