import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moxy/components/moxy_button.dart';
import 'package:moxy/theme/app_theme.dart';
import 'package:provider/provider.dart';

import '../../../../../components/textfield.dart';
import '../../../../../domain/create_product_state.dart';

class Pricing extends StatelessWidget {
  const Pricing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CreateProductState>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: MoxyTextfield(
                  title: "Price(\$)",
                  controller: state.priceController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                  ],
                ),
              ),
              const SizedBox(width: AppTheme.cardPadding),
              Expanded(
                child: MoxyTextfield(
                  title: "Previous Price(\$)",
                  controller: state.previousPriceController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MoxyButton(
                title: "Previous",
                gradiant: const [
                  AppTheme.blackLight,
                  AppTheme.blackLight,
                ],
                onTap: () {
                  state.moveToPreviousPage();
                },
              ),
              MoxyButton(
                title: "Next",
                state: state.pricingPageIsValid
                    ? ButtonState.idle
                    : ButtonState.disabled,
                onTap: () {
                  state.moveToNexPage();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
