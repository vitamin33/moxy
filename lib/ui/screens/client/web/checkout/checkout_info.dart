import 'package:flutter/material.dart';
import 'package:moxy/domain/client/checkout/checkout_cubit.dart';
import 'package:moxy/domain/client/checkout/checkout_state.dart';
import 'package:moxy/ui/components/rounded_text.dart';
import 'package:moxy/ui/screens/components/contact_textfield.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:provider/provider.dart';

class CheckoutInfo extends StatelessWidget {
  final CheckoutState state;
  const CheckoutInfo({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    final cubit = context.read<CheckoutCubit>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            children: [
              const RoundedText(number: 1),
              const SizedBox(width: 8),
              Text("Contact information".toUpperCase(),
                  style: theme.checkoutHeadingText),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: ContactTextField(
                  labelText: 'First Name',
                  controller: cubit.firstNameController,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: ContactTextField(
                  labelText: 'Second Name',
                  controller: cubit.secondNameController,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          ContactTextField(
            labelText: 'Phone Number',
            prefixText: '+38',
            controller: cubit.phoneNumberController,
          ),
        ],
      ),
    );
  }
}
