import 'package:moxy/domain/models/product.dart';

mixin ValidationMixin {
  bool isFieldEmpty(String? fieldValue) => fieldValue?.isEmpty ?? true;

  bool isValidPrice(double? price) {
    if (price == null) {
      return false;
    }
    return price > 0;
  }

  bool isValidQuantity(List<Dimension> dimension) {
    for (var item in dimension) {
      if (item.quantity == 0) {
        return false;
      }
    }
    return true;
  }

  bool validateEmailAddress(String? email) {
    if (email == null) {
      return false;
    }

    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}

enum FieldError { empty, invalid }
