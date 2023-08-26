import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/checkout/checkout_cubit.dart';
import 'package:moxy/domain/client/checkout/checkout_state.dart';
import 'package:moxy/ui/screens/components/scrollable_section.dart';

import 'checkout_info.dart';
import 'checkout_products.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckoutCubit>(
      create: (BuildContext context) => CheckoutCubit(),
      child: BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          return Column(
            children: [
              GestureDetector(
                onTap: () => {},
                child: const Row(
                  children: [
                    Icon(Icons.arrow_back),
                    SizedBox(width: 8), // Adjust the spacing as needed
                    Text(
                      'Back to basket',
                      style: TextStyle(
                        fontSize: 16, // Adjust the font size as needed
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child:
                        ScrollableSection(content: CheckoutInfo(state: state)),
                  ),
                  const VerticalDivider(width: 1, thickness: 1),
                  Expanded(
                    child: ScrollableSection(
                        content: CheckoutProducts(state: state)),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
