import 'package:moxy/domain/copyable.dart';
import 'package:moxy/domain/models/basket.dart';
import 'package:moxy/domain/validation_mixin.dart';

class BasketState implements Copyable<BasketState> {
  final bool isLoading;
  final Basket basket;
  bool isFreeShipping;

  final BasketFieldErrors error;

  BasketState({
    required this.isLoading,
    required this.basket,
    required this.isFreeShipping,
    required this.error,
  });

  static defaultState() {
    return BasketState(
      isLoading: false,
      basket: Basket.defaultBasket(),
      isFreeShipping: false,
      error: BasketFieldErrors(),
    );
  }

  @override
  BasketState copyWith(
      {bool? isLoading,
      Basket? basket,
      bool? isFreeShipping,
      BasketFieldErrors? error}) {
    return BasketState(
        isLoading: isLoading ?? this.isLoading,
        basket: basket ?? this.basket,
        isFreeShipping: isFreeShipping ?? this.isFreeShipping,
        error: error ?? this.error);
  }
}


class BasketFieldErrors {
  FieldError? firstName;
  FieldError? secondName;
  FieldError? phoneNumber;
  FieldError? oldPassword;
  FieldError? newPassword;
  FieldError? reapeatNewPassword;

  BasketFieldErrors({
    this.firstName,
   
  });

  static BasketFieldErrors noErrors() {
    return BasketFieldErrors();
  }

  String formErrorMessageFields() {
    var buffer = StringBuffer();
    buffer.write('Validation errors: ');
    if (firstName != null) {
      buffer.write('firstName');
    }
    buffer.write('.');
    return buffer.toString();
  }
}
