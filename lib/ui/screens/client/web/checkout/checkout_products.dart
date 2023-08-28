import 'package:flutter/material.dart';
import 'package:moxy/domain/client/checkout/checkout_state.dart';

class CheckoutProducts extends StatelessWidget {
  final CheckoutState state;
  const CheckoutProducts({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Text('Checkout products');
  }
}
