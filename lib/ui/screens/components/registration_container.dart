import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/auth/login_cubit.dart';
import 'package:moxy/domain/auth/registration/registration_cubit.dart';
import 'package:moxy/domain/auth/registration/registration_state.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/components/custom_textfield.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';

class RegistrationContainer extends StatelessWidget {
  const RegistrationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        final cubit = context.read<RegistrationCubit>();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Реєстрація',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 44, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: AppTheme.cardPadding),
              CustomTextField(
                borderColor: AppTheme.greyLigth,
                title: 'Імя',
                onChanged: (value) => cubit.mobileNumberChanged(value),
                autofillHints: const [
                  AutofillHints.telephoneNumber,
                ],
              ),
              CustomTextField(
                borderColor: AppTheme.greyLigth,
                title: 'Номер телефону',
                onChanged: (value) => cubit.mobileNumberChanged(value),
                autofillHints: const [
                  AutofillHints.telephoneNumber,
                ],
              ),
              CustomTextField(
                borderColor: AppTheme.greyLigth,
                title: 'Email',
                onChanged: (value) => cubit.mobileNumberChanged(value),
                autofillHints: const [
                  AutofillHints.telephoneNumber,
                ],
              ),
              const SizedBox(height: AppTheme.elementSpacing),
              CustomTextField(
                borderColor: AppTheme.greyLigth,
                title: 'Пароль',
                onChanged: (value) => cubit.passwordChanged(value),
                autofillHints: const [
                  AutofillHints.password,
                ],
              ),
              const SizedBox(height: AppTheme.elementSpacing),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: CustomButton(
                  buttonWidth: MediaQuery.of(context).size.width,
                  title: 'Далі',
                  state: state.state is Loading
                      ? ButtonState.loading
                      : (state.mobileNumberIsValid
                          ? ButtonState.idle
                          : ButtonState.disabled),
                  onTap: () {
                    context.read<LoginCubit>().nextPage();
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              ),
              downText(context)
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
            moxyPrint('Sign up');
            context.read<LoginCubit>().perviousPage();
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
