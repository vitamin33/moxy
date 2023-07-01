import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/services/navigation/root_router_cubit.dart';
import 'package:moxy/ui/components/custom_textfield.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';

import '../../components/custom_button.dart';
import '../../components/snackbar_widgets.dart';
import '../../../domain/auth/login_cubit.dart';
import '../../../domain/auth/login_state.dart';

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rootNavCubit = context.read<RootRouterCubit>();
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        final cubit = context.read<LoginCubit>();
        if (state.state is LoginFailed) {
          showFailureSnackbar(context, 'Unable to login. Please try again.');
          cubit.clearState();
        } else if (state.state is LoginWithCredsSuccess) {
          rootNavCubit.goToAdminFlow();
          cubit.clearState();
        } else if (state.state is Logout) {
          cubit.clearState();
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: AppTheme.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.cardPadding),
              child: Column(
                children: [
                  const SizedBox(height: AppTheme.cardPadding * 2),
                  SvgPicture.asset(
                    IconPath.moxylogo,
                    width: 150,
                  ),
                  const SizedBox(height: AppTheme.cardPadding * 2),
                  const Text(
                    "Login",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: AppTheme.cardPadding),
                  CustomTextField(
                    borderColor: AppTheme.greyLigth,
                    title: "Phone Number ",
                    onChanged: (value) =>
                        context.read<LoginCubit>().mobileNumberChanged(value),
                    autofillHints: const [
                      AutofillHints.email,
                    ],
                  ),
                  const SizedBox(height: AppTheme.elementSpacing),
                  CustomTextField(
                    borderColor: AppTheme.greyLigth,
                    title: "Password",
                    onChanged: (value) =>
                        context.read<LoginCubit>().passwordChanged(value),
                    autofillHints: const [
                      AutofillHints.password,
                    ],
                  ),
                  const SizedBox(height: AppTheme.cardPadding),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: CustomButton(
                      buttonWidth: MediaQuery.of(context).size.width,
                      title: "Login",
                      state: state.state is Loading
                          ? ButtonState.loading
                          : (state.mobileNumberIsValid
                              ? ButtonState.idle
                              : ButtonState.disabled),
                      onTap: context.read<LoginCubit>().logInWithCredentials,
                    ),
                  ),
                  const SizedBox(height: AppTheme.cardPadding * 6),
                  downText()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget downText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'No account yet?',
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(
          width: 2,
        ),
        InkWell(
            onTap: () {
              moxyPrint('Sign up');
            },
            child: const Text(
              'Sign up',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.pinkDark,
                  decoration: TextDecoration.underline),
            )),
      ],
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
