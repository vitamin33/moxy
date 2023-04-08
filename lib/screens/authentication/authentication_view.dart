import 'package:flutter/material.dart';
import 'package:moxy/components/app_scaffold.dart';
import 'package:moxy/components/moxy_button.dart';
import 'package:moxy/components/rounded_card.dart';
import 'package:moxy/components/textfield.dart';
import 'package:moxy/constant/image_path.dart';
import 'package:moxy/screens/authentication/authentication_state.dart';
import 'package:moxy/theme/app_theme.dart';
import 'package:provider/provider.dart';

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthenticationState>();
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppTheme.cardPadding),
        child: Column(
          children: [
            Image.asset(ImagePath.logo, width: 120),
            const SizedBox(height: AppTheme.cardPadding * 2),
            SizedBox(
              width: 500,
              child: RoundedCard(
                color: AppTheme.darkBlue,
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
                        controller: state.emailController,
                        autofillHints: const [
                          AutofillHints.email,
                        ],
                      ),
                      const SizedBox(height: AppTheme.elementSpacing),
                      MoxyTextfield(
                        title: "Password",
                        controller: state.passwordController,
                        autofillHints: const [
                          AutofillHints.password,
                        ],
                      ),
                      const SizedBox(height: AppTheme.cardPadding),
                      MoxyButton(
                        title: "Login to your account",
                        state: state.isLoading
                            ? ButtonState.loading
                            : (state.emailIsValid
                                ? ButtonState.idle
                                : ButtonState.disabled),
                        onTap: state.login,
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
    );
  }
}
