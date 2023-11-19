import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/domain/auth/registration/registration_cubit.dart';
import 'package:moxy/domain/auth/registration/registration_effect.dart';
import 'package:moxy/domain/auth/registration/registration_state.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/components/custom_textfield.dart';
import 'package:moxy/ui/components/succes_card.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
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
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: state.isResetEmailSent
                  ? SuccessCard(
                      onTap: () {
                        context.go(RouterProvider.loginPath());
                        _registerCubit.clearResetState();
                      },
                      title:
                          'Пароль скинуто, перевірте свій e-mail, щоб встановити новий пароль.',
                      titleButton: 'Повернутись до входу')
                  : _buildTextForm(context, state),
            ));
      },
    );
  }

  Widget _buildTextForm(BuildContext context, RegistrationState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text(
          'Скинути пароль',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 44, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: AppTheme.cardPadding),
        CustomTextField(
          borderColor: AppTheme.greyLigth,
          title: 'Email',
          controller: _registerCubit.resetPasswordEmailController,
          onChanged: (value) => _registerCubit.emailPasswordChanged(value),
          state: state.error.resetPasswordEmail,
          validation: true,
        ),
        const SizedBox(height: AppTheme.elementSpacing),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: CustomButton(
            buttonWidth: MediaQuery.of(context).size.width,
            title: 'Відправити Email',
            onTap: () {
              _registerCubit.sendResetEmail();
            },
          ),
        ),
      ],
    );
  }
}
