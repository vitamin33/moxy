import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/auth/login_cubit.dart';
import 'package:moxy/domain/auth/registration/registration_cubit.dart';
import 'package:moxy/domain/auth/registration/registration_state.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/components/custom_textfield.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class ResetPasswordContainer extends StatelessWidget {
  const ResetPasswordContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        final cubit = context.read<RegistrationCubit>();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Скинути пароль',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 44, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: AppTheme.cardPadding),
              CustomTextField(
                borderColor: AppTheme.greyLigth,
                title: 'Номер телефону',
                controller: cubit.mobileNumberPasswordController,
                onChanged: (value) => cubit.mobileNumberPasswordChanged(value),
                autofillHints: const [
                  AutofillHints.telephoneNumber,
                ],
                state: state.error.mobileNumberPassword,
                validation: true,
              ),
              const SizedBox(height: AppTheme.elementSpacing),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: CustomButton(
                  buttonWidth: MediaQuery.of(context).size.width,
                  title: 'Відправити номер',
                  onTap: () {
                    if (cubit.validateChangePasswordFields()) {
                      context.read<LoginCubit>().nextPage();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget downText(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        'Вже існує акаунт?',
        style: TextStyle(fontSize: 18),
      ),
      const SizedBox(
        width: 2,
      ),
      InkWell(
          onTap: () {
            context.read<RegistrationCubit>().sendConfirmationCode();
          },
          child: const Text(
            "Увійти",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.pinkDark,
                decoration: TextDecoration.underline),
          )),
    ],
  );
}
