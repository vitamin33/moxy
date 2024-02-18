import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/domain/auth/registration/registration_cubit.dart';
import 'package:moxy/domain/auth/registration/registration_effect.dart';
import 'package:moxy/domain/auth/registration/registration_state.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/components/custom_textfield.dart';
import 'package:moxy/ui/components/snackbar_widgets.dart';
import 'package:moxy/ui/theme/app_theme.dart';

@immutable
class NewPasswordPage extends StatefulWidget {
  final String? email;
  final String? resetToken;
  const NewPasswordPage(
      {super.key, required this.email, required this.resetToken});

  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  late RegistrationCubit _registerCubit;
  @override
  void initState() {
    super.initState();
    _registerCubit = context.read<RegistrationCubit>();
    _registerCubit.initNewPasswordFlow(widget.email, widget.resetToken);
    _registerCubit.effectStream.listen((effect) {
      if (effect is NavigateToLogin) {
        context.go(RouterProvider.loginPath());
      } else if (effect is NoResetTokenFound) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
            snackBarFailureText:
                'No reset token found. Try reset password flow from the beginning.'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        final theme = AppTheme.of(context)!;
        final cubit = context.read<RegistrationCubit>();
        bool isLoading = state.state is Loading;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Створити пароль',
                textAlign: TextAlign.center,
                style: theme.bigTitleBoltText,
              ),
              const SizedBox(height: AppTheme.cardPadding),
              CustomTextField(
                borderColor: AppTheme.greyLigth,
                title: 'Новий пароль',
                controller: cubit.newPasswordController,
                onChanged: (value) => cubit.newPasswordChanged(value),
                autofillHints: const [
                  AutofillHints.telephoneNumber,
                ],
                state: state.error.newPassword,
                validation: true,
              ),
              CustomTextField(
                borderColor: AppTheme.greyLigth,
                title: 'Підтвердити новий пароль',
                controller: cubit.confirmPasswordController,
                onChanged: (value) => cubit.confirmPasswordChanged(value),
                autofillHints: const [
                  AutofillHints.telephoneNumber,
                ],
                state: state.error.confirmPassword,
                validation: true,
              ),
              const SizedBox(height: AppTheme.elementSpacing),
              const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: []),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: CustomButton(
                  state: isLoading ? ButtonState.loading : ButtonState.idle,
                  buttonWidth: MediaQuery.of(context).size.width,
                  title: 'Змінити пароль',
                  onTap: () {
                    if (cubit.validateNewPasswordFields()) {
                      cubit.createNewPassword();
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
        width: 2,
      ),
      InkWell(
          onTap: () {},
          child: Text(
            "Увійти",
            style: theme.titleBoltText.copyWith(
                color: AppTheme.pinkDark, decoration: TextDecoration.underline),
          )),
    ],
  );
}
