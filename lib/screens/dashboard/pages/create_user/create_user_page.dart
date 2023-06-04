import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrderCubit, CreateOrderState>(
        builder: (context, state) {
      final cubit = context.read<CreateOrderCubit>();
      return Padding(
        padding: const EdgeInsets.all(AppTheme.cardPadding),
        child: Column(
          children: [
            CustomTextField(
              title: ' First Name',
              maxLines: 1,
              controller: cubit.firstNameController,
              onChanged: cubit.firstNameChanged,
              validation: true,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              title: 'Second Name',
              maxLines: 1,
              controller: cubit.secondNameController,
              onChanged: cubit.secondNameChanged,
              validation: true,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              title: 'Phone Number',
              controller: cubit.phoneNumberController,
              onChanged: cubit.phoneNumberChanged,
              state: state.errors.costPrice,
              maxLines: 1,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    });
  }
}
