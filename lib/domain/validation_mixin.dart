import 'package:moxy/constant/order_status.dart';
import 'package:moxy/constants.dart';
import 'package:moxy/domain/models/dimension_product.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/domain/models/status.dart';
import 'package:moxy/utils/common.dart';

mixin ValidationMixin {
  bool isFieldEmpty(String? fieldValue) => fieldValue?.isEmpty ?? true;

  bool isValidMobileNumber(String? phone) {
    if (phone == null) {
      return false;
    }
    return phoneNumberRegExp.hasMatch(phone);
  }

  bool isValidPrice(double? price) {
    if (price == null) {
      return false;
    }
    return price > 0;
  }

  bool isValidWeight(int? weight) {
    if (weight == null) {
      return false;
    }
    return weight > 0;
  }

  bool isValidSizeValues(int? value) {
    if (value == null) {
      return false;
    }
    return value > 0;
  }

  bool isValidCashAdvanceValue(int? value, Status status) {
    if (status.statusValue == OrderStatus.Reserved) {
      if (value == null || value < defaultCashAvanceValue) {
        return false;
      }
    }
    return true;
  }

  bool isValidQuantity(List<Dimension> dimensions) {
    if (dimensions.isEmpty) {
      return false;
    }
    for (var item in dimensions) {
      if (item.quantity == 0) {
        return false;
      }
    }
    return true;
  }

  bool isValidSelectedProduct(List<DimensionProduct> selectedProducts) {
    if (selectedProducts.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  bool validateRepeatPassword(String newPassword, String repeatPassword) {
    if (newPassword == repeatPassword) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidPassword(String? password) {
    if (password == null || password.isEmpty) {
      return false;
    }

    return password.length >= 6;
  }

  bool validateEmailAddress(String? email) {
    if (email == null || email.isEmpty) {
      return false;
    }

    const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    return RegExp(emailPattern).hasMatch(email);
  }
}

enum FieldError { empty, invalid }
