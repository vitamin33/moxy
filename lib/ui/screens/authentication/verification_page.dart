import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/auth/registration/registration_cubit.dart';
import 'package:moxy/domain/auth/registration/registration_state.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/screens/components/otp_textfield.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moxy/utils/moxy_analytics.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;

    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        final cubit = context.read<RegistrationCubit>();
        bool isLoading = state.state is Loading;

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.cardPadding,
            vertical: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                AppLocalizations.of(context)!.verCode,
                textAlign: TextAlign.center,
                style: theme.bigTitleBoltText,
              ),
              const SizedBox(height: AppTheme.cardPadding),
              OtpTextField(
                textStyle: const TextStyle(fontSize: 18),
                state: state.error.confirmationCode,
                numberOfFields: 4,
                borderColor: AppTheme.greyLigth,
                showFieldAsBox: true,
                focusedBorderColor: AppTheme.pinkAvarage,
                onSubmit: (String code) {
                  cubit.changeVarCode(code);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(AppLocalizations.of(context)!.tryAgain,
                      style: theme.mediumSemiBoltText),
                  InkWell(
                    onTap: () {
                      cubit.resendConfirmationCode();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.receiveCodeQuestion,
                      style: theme.largeSemiBoltText.copyWith(
                          color: AppTheme.pinkDark,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
              const SizedBox(height: AppTheme.elementSpacing),
              const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: []),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: OutlineStateButton(
                  state: isLoading ? ButtonState.loading : ButtonState.idle,
                  buttonWidth: MediaQuery.of(context).size.width,
                  title: AppLocalizations.of(context)!.sendCode,
                  onTap: () {
                    if (cubit.validateConfirmCodeFields()) {
                      context.read<RegistrationCubit>().sendConfirmationCode();
                      // MoxyAnalytics().completeRegistrationEvent();
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
          onTap: () {},
          child: Text("Увійти",
              style: theme.titleBoltText.copyWith(
                  color: AppTheme.pinkDark,
                  decoration: TextDecoration.underline))),
    ],
  );
}
