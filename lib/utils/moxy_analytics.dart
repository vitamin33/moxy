// // ignore: avoid_web_libraries_in_flutter
// import 'dart:js' as dartJsFile;

// import 'package:firebase_analytics/firebase_analytics.dart';

// class MoxyAnalytics {
//   final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

//   addToCartEvent({required productName}) async {
//     dartJsFile.context.callMethod('fbqAddToCartEvent', [productName]);
//     await analytics.logAddToCart(items: [
//       AnalyticsEventItem(
//         itemName: productName,
//       )
//     ]);
//   }

//   addToWishlistEvent({required productName}) async {
//     dartJsFile.context.callMethod('fbqAddToWishlistEvent', [productName]);

//     await analytics.logAddToWishlist(items: [
//       AnalyticsEventItem(
//         itemName: productName,
//       )
//     ]);
//   }

//   completeRegistrationEvent() async {
//     dartJsFile.context.callMethod('fbqCompleteRegistrationEvent');

//     await analytics.logLogin();
//   }

//   initiateCheckoutEvent() async {
//     dartJsFile.context.callMethod('fbqInitiateCheckoutEvent');
//   }

//   leadEvent({required leadEmail}) async {
//     dartJsFile.context.callMethod('fbqLeadEvent', [leadEmail]);

//     await analytics.logGenerateLead();
//   }

//   purchaseEvent({required valuePurchase}) async {
//     dartJsFile.context.callMethod('fbqPurchaseEvent', [valuePurchase]);

//     await analytics.logPurchase();
//   }
// }
