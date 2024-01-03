import 'package:flutter/material.dart';

class ResponsiveUtil {
  // Define a static method to check for mobile screen size
  static bool isMobile(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < 600; // Mobile screen width threshold
  }

  // You can also add methods for other device types if needed
  static bool isTablet(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= 600 && screenWidth < 1200;
  }

  static bool isDesktop(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= 1200;
  }
}
