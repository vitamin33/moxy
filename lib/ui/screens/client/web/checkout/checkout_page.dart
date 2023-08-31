import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/checkout/checkout_cubit.dart';
import 'package:moxy/domain/client/checkout/checkout_state.dart';
import 'package:moxy/ui/screens/components/scrollable_section.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../theme/app_theme.dart';
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
          final theme = AppTheme.of(context)!;
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(36, 18, 36, 4),
                  child: SizedBox(
                    width: 300,
                    child: InkWell(
                      onTap: () => {},
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.arrow_back,
                              color: AppTheme.textColor,
                            ),
                            const SizedBox(
                                width: 8), // Adjust the spacing as needed
                            Text("Back to basket",
                                style: theme.checkoutHeadingText),
                          ],
                        ),
                      ),
                    ),
                  ),
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
