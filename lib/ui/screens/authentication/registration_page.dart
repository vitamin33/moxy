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

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
        context.push(RouterProvider.loginPath());
      }
    });
  }

  @override
  void dispose() {
    _registerCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        final cubit = context.read<RegistrationCubit>();
        final theme = AppTheme.of(context)!;
        bool isLoading = state.state is Loading;

        return Column(
          children: [
            Expanded(
              flex: 10,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.cardPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Реєстрація',
                        textAlign: TextAlign.start,
                        style: theme.bigTitleBoltText,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        borderColor: AppTheme.greyLigth,
                        title: 'Імя',
                        controller: cubit.firstNameController,
                        onChanged: (value) => cubit.firstNameChanged(value),
                        state: state.error.firstName,
                        validation: true,
                      ),
                      CustomTextField(
                        borderColor: AppTheme.greyLigth,
                        title: 'Прізвище',
                        controller: cubit.secondNameController,
                        onChanged: (value) => cubit.secondNameChanged(value),
                        state: state.error.secondName,
                        validation: true,
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
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.cardPadding,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: OutlineStateButton(
                        state:
                            isLoading ? ButtonState.loading : ButtonState.idle,
                        buttonWidth: MediaQuery.of(context).size.width,
                        title: 'Далі',
                        onTap: () {
                          if (cubit.validateRegisterFields()) {
                            cubit.register();
                          }
                        },
                      ),
                    ),
                    downText(context, theme),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget downText(BuildContext context, AppTheme theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Вже існує акаунт?',
          style: theme.titleText,
        ),
        const SizedBox(
          width: 4,
        ),
        InkWell(
            onTap: () {
              context.push(RouterProvider.loginPath());
            },
            child: Text("Увійти",
                style: theme.titleBoltText.copyWith(
                    color: AppTheme.pinkDark,
                    decoration: TextDecoration.underline))),
      ],
    );
  }
}
