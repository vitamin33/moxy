import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/auth/login/login_cubit.dart';
import 'package:moxy/domain/auth/login/login_state.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/components/custom_textfield.dart';
import 'package:moxy/ui/screens/components/onhover.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moxy/utils/responsive_utils.dart';

class AuthenticationContainer extends StatelessWidget {
  const AuthenticationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        final theme = AppTheme.of(context)!;
        final cubit = context.read<LoginCubit>();
        final isMobile = ResponsiveUtil.isMobile(context);
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment:
                isMobile ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                AppLocalizations.of(context)!.login,
                textAlign: TextAlign.start,
                style: theme.bigTitleBoltText,
              ),
              const SizedBox(height: AppTheme.cardPadding),
              CustomTextField(
                controller: TextEditingController(),
                borderColor: AppTheme.greyLigth,
                title: AppLocalizations.of(context)!.phoneNumber,
                onChanged: (value) =>
                    context.read<LoginCubit>().mobileNumberChanged(value),
                autofillHints: const [
                  AutofillHints.telephoneNumber,
                ],
              ),
              const SizedBox(height: AppTheme.elementSpacing),
              CustomTextField(
                controller: TextEditingController(),
                borderColor: AppTheme.greyLigth,
                title: AppLocalizations.of(context)!.password,
                onChanged: (value) =>
                    context.read<LoginCubit>().passwordChanged(value),
                autofillHints: const [
                  AutofillHints.password,
                ],
              ),
              const SizedBox(height: AppTheme.elementSpacing),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (onChanged) {}),
                    const Text('Запамятати мене')
                  ],
                ),
                InkWell(
                  onTap: () {
                    cubit.moveToPage(3);
                  },
                  child: OnHover(
                    builder: (isHovered) {
                      return Text('Забули пароль?',
                          style: theme.mediumText.copyWith(
                              decoration: isHovered
                                  ? TextDecoration.underline
                                  : TextDecoration.none));
                    },
                  ),
                )
              ]),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              ),
              const SizedBox(height: AppTheme.cardPadding),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: CustomButton(
                  buttonWidth: MediaQuery.of(context).size.width,
                  title: AppLocalizations.of(context)!.login,
                  state: state.state is Loading
                      ? ButtonState.loading
                      : ButtonState.idle,
                  onTap: context.read<LoginCubit>().logInWithCredentials,
                ),
              ),
              downText(context, theme)
            ],
          ),
        );
      },
    );
  }

  Widget downText(BuildContext context, AppTheme theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.noAccountQuestion,
          style: theme.titleText,
        ),
        const SizedBox(
          width: 2,
        ),
        InkWell(
            onTap: () {
              context.read<LoginCubit>().nextPage();
            },
            child: Text(AppLocalizations.of(context)!.signup,
                style: theme.titleBoltText.copyWith(
                    color: AppTheme.pinkDark,
                    decoration: TextDecoration.underline))),
      ],
    );
  }
}
