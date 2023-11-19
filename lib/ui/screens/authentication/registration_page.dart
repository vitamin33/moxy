import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/domain/auth/registration/registration_cubit.dart';
import 'package:moxy/domain/auth/registration/registration_effect.dart';
import 'package:moxy/domain/auth/registration/registration_state.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/components/custom_textfield.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late RegistrationCubit _registerCubit;
  @override
  void initState() {
    super.initState();
    _registerCubit = context.read<RegistrationCubit>();
    _registerCubit.effectStream.listen((effect) {
      if (effect is NavigateToLogin) {
        context.go(RouterProvider.loginPath());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        final cubit = context.read<RegistrationCubit>();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Реєстрація',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 44, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      child: CustomTextField(
                        borderColor: AppTheme.greyLigth,
                        title: 'Імя',
                        controller: cubit.firstNameController,
                        onChanged: (value) => cubit.firstNameChanged(value),
                        state: state.error.firstName,
                        validation: true,
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: CustomTextField(
                        borderColor: AppTheme.greyLigth,
                        title: 'Прізвище',
                        controller: cubit.secondNameController,
                        onChanged: (value) => cubit.secondNameChanged(value),
                        state: state.error.secondName,
                        validation: true,
                      ),
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
                onChanged: (value) =>
                    cubit.confirmRegisterPasswordChanged(value),
                autofillHints: const [
                  AutofillHints.password,
                ],
                state: state.error.confirmRegisterPassword,
                validation: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: CustomButton(
                  buttonWidth: MediaQuery.of(context).size.width,
                  title: 'Далі',
                  onTap: () {
                    if (cubit.validateRegisterFields()) {
                      cubit.register();
                    }
                  },
                ),
              ),
              downText(context),
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
            context.go(RouterProvider.loginPath());
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
