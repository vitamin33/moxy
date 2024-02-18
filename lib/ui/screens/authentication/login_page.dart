import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/domain/auth/login/login_cubit.dart';
import 'package:moxy/domain/auth/login/login_effects.dart';
import 'package:moxy/domain/auth/login/login_state.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/components/custom_textfield.dart';
import 'package:moxy/ui/components/snackbar_widgets.dart';
import 'package:moxy/ui/screens/components/onhover.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moxy/utils/responsive_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginCubit _loginCubit;
  @override
  void initState() {
    super.initState();
    _loginCubit = context.read<LoginCubit>();
    _loginCubit.effectStream.listen((effect) {
      if (effect is NavigateToAdmin) {
        context.go(RouterProvider.adminDashboardPath());
      } else if (effect is NavigateToClient) {
        context.go(RouterProvider.homeNewPath());
      } else if (effect is LoginFailed) {
        ScaffoldMessenger.of(context).showSnackBar(
            snackBarWhenFailure(snackBarFailureText: effect.failureText));
      } else if (effect is ValidationFailed) {
        ScaffoldMessenger.of(context).showSnackBar(
            snackBarWhenFailure(snackBarFailureText: effect.failureText));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    final isMobile = ResponsiveUtil.isMobile(context);
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(AppTheme.cardPadding),
        child: Column(
          crossAxisAlignment:
              isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              AppLocalizations.of(context)!.login,
              textAlign: TextAlign.start,
              style: theme.bigTitleBoltText,
            ),
            const SizedBox(height: AppTheme.cardPadding),
            CustomTextField(
              controller: context.read<LoginCubit>().phoneController,
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
              controller: context.read<LoginCubit>().passwordController,
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
                  context.push(RouterProvider.resetPasswordPath());
                },
                child: OnHover(
                  builder: (isHovered) {
                    return Text(
                      'Забули пароль?',
                      style: TextStyle(
                          decoration: isHovered
                              ? TextDecoration.underline
                              : TextDecoration.none),
                    );
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
    });
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
            context.push(RouterProvider.registerPath());
          },
          child: Text(AppLocalizations.of(context)!.signup,
              style: theme.titleBoltText.copyWith(
                  color: AppTheme.pinkDark,
                  decoration: TextDecoration.underline)),
        ),
      ],
    );
  }
}
