import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/auth/login_cubit.dart';
import 'package:moxy/domain/auth/registration/registration_cubit.dart';
import 'package:moxy/domain/auth/registration/registration_effect.dart';
import 'package:moxy/domain/auth/registration/registration_state.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/components/custom_textfield.dart';
import 'package:moxy/ui/components/snackbar_widgets.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';

class RegistrationContainer extends StatelessWidget {
  const RegistrationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        final cubit = context.read<RegistrationCubit>();
        return Column(
          children: [
            const Text(
              'Реєстрація',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 44, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                SizedBox(
                  width: 210,
                  child: CustomTextField(
                    borderColor: AppTheme.greyLigth,
                    title: 'Імя',
                    controller: cubit.firstNameController,
                    onChanged: (value) => cubit.firstNameChanged(value),
                    state: state.error.firstName,
                    validation: true,
                  ),
                ),
                SizedBox(
                  width: 210,
                  child: CustomTextField(
                    borderColor: AppTheme.greyLigth,
                    title: 'Прізвище',
                    controller: cubit.secondNameController,
                    onChanged: (value) => cubit.secondNameChanged(value),
                    state: state.error.secondName,
                    validation: true,
                  ),
                ),
              ],
            ),
            CustomTextField(
              borderColor: AppTheme.greyLigth,
              title: 'Номер телефону',
              controller: cubit.mobileNumberController,
              onChanged: (value) => cubit.mobileNumberChanged(value),
              autofillHints: const [
                AutofillHints.telephoneNumber,
              ],
              state: state.error.mobileNumber,
              validation: true,
            ),
            CustomTextField(
              borderColor: AppTheme.greyLigth,
              title: 'Email',
              controller: cubit.emailController,
              onChanged: (value) => cubit.emailChanged(value),
              autofillHints: const [
                AutofillHints.telephoneNumber,
              ],
              state: state.error.email,
              validation: true,
            ),
            CustomTextField(
              borderColor: AppTheme.greyLigth,
              title: 'Пароль',
              controller: cubit.passwordController,
              onChanged: (value) => cubit.passwordChanged(value),
              autofillHints: const [
                AutofillHints.password,
              ],
              state: state.error.password,
              validation: true,
            ),
            CustomTextField(
              borderColor: AppTheme.greyLigth,
              title: 'Підтвердити Пароль',
              controller: cubit.confirmRegisterPasswordController,
              onChanged: (value) => cubit.confirmRegisterPasswordChanged(value),
              autofillHints: const [
                AutofillHints.password,
              ],
              state: state.error.confirmRegisterPassword,
              validation: true,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: CustomButton(
                buttonWidth: MediaQuery.of(context).size.width,
                title: 'Далі',
                onTap: () {
                  if (cubit.validateRegisterFields()) {
                    cubit.register(context);
                  }
                },
              ),
            ),
            downText(context)
          ],
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
