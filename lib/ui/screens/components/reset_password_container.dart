import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/auth/login/login_cubit.dart';
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
        final theme = AppTheme.of(context)!;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Скинути пароль',
                textAlign: TextAlign.center,
                style: theme.bigTitleBoltText,
              ),
              const SizedBox(height: AppTheme.cardPadding),
              CustomTextField(
                borderColor: AppTheme.greyLigth,
                title: 'Email',
                controller: cubit.resetPasswordEmailController,
                onChanged: (value) => cubit.emailPasswordChanged(value),
                state: state.error.resetPasswordEmail,
                validation: true,
              ),
              const SizedBox(height: AppTheme.elementSpacing),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: OutlineStateButton(
                  buttonWidth: MediaQuery.of(context).size.width,
                  title: 'Відправити Email',
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
            context.read<RegistrationCubit>().sendConfirmationCode();
          },
          child: Text(
            "Увійти",
            style: theme.titleBoltText.copyWith(
                color: AppTheme.pinkDark, decoration: TextDecoration.underline),
          )),
    ],
  );
}
