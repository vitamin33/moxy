import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/components/app_scaffold.dart';
import 'package:moxy/components/moxy_button.dart';
import 'package:moxy/components/rounded_card.dart';
import 'package:moxy/components/textfield.dart';
import 'package:moxy/constant/image_path.dart';
import 'package:moxy/theme/app_theme.dart';

import '../../components/snackbar_widgets.dart';
import '../../constant/route_name.dart';
import '../../domain/auth/login_cubit.dart';
import '../../domain/auth/login_state.dart';
import '../../services/navigation_service.dart';

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        final cubit = context.read<LoginCubit>();
        if (state.state is LoginFailed) {
          showFailureSnackbar(context, 'Unable to login. Please try again.');
          cubit.clearState();
        } else if (state.state is LoginWithCredsSuccess) {
          navigatePushReplaceName(overview);
          cubit.clearState();
        } else if (state.state is Logout) {
          navigatePushReplaceName(authPath);
          cubit.clearState();
        }
      },
      builder: (context, state) => AppScaffold(
        body: Padding(
          padding: const EdgeInsets.all(AppTheme.cardPadding),
          child: Column(
            children: [
              Image.asset(ImagePath.logo, width: 120),
              const SizedBox(height: AppTheme.cardPadding * 2),
              SizedBox(
                width: 500,
                child: RoundedCard(
                  color: Theme.of(context).cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(AppTheme.cardPadding),
                    child: Column(
                      children: [
                        Text(
                          "Login",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(height: AppTheme.cardPadding),
                        MoxyTextfield(
                          title: "Email Address",
                          onChanged: (value) =>
                              context.read<LoginCubit>().emailChanged(value),
                          autofillHints: const [
                            AutofillHints.email,
                          ],
                        ),
                        const SizedBox(height: AppTheme.elementSpacing),
                        MoxyTextfield(
                          title: "Password",
                          onChanged: (value) =>
                              context.read<LoginCubit>().passwordChanged(value),
                          autofillHints: const [
                            AutofillHints.password,
                          ],
                        ),
                        const SizedBox(height: AppTheme.cardPadding),
                        MoxyButton(
                          title: "Login to your account",
                          state: state.state is Loading
                              ? ButtonState.loading
                              : (state.emailIsValid
                                  ? ButtonState.idle
                                  : ButtonState.disabled),
                          onTap: () =>
                              context.read<LoginCubit>().logInWithCredentials(),
                        ),
                        const SizedBox(height: AppTheme.cardPadding),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showSuccessSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(snackBarWhenSuccess());
  }

  void showFailureSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(snackBarWhenFailure(snackBarFailureText: message));
  }
}
