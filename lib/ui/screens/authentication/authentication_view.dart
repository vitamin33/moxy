import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/constant/image_path.dart';
import 'package:moxy/domain/auth/registration/registration_cubit.dart';
import 'package:moxy/domain/auth/registration/registration_effect.dart';
import 'package:moxy/ui/components/succes_card.dart';
import 'package:moxy/ui/screens/components/authentication_container.dart';
import 'package:moxy/ui/screens/components/new_password_container.dart';
import 'package:moxy/ui/screens/components/registration_container.dart';
import 'package:moxy/ui/screens/components/reset_password_container.dart';
import 'package:moxy/ui/screens/components/verification_container.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import '../../components/snackbar_widgets.dart';
import '../../../domain/auth/login_cubit.dart';
import '../../../domain/auth/login_state.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({super.key});

  @override
  State<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  late RegistrationCubit registerCubit;

  @override
  void initState() {
    super.initState();
    registerCubit = context.read<RegistrationCubit>();
    registerCubit.effectStream.listen((effect) {
      if (effect is RegistrationValidationFailed) {
        ScaffoldMessenger.of(context).showSnackBar(
            snackBarWhenFailure(snackBarFailureText: 'error validation'));
      } else if (effect is RegistrationApiRequestFailed) {
        ScaffoldMessenger.of(context).showSnackBar(
            snackBarWhenFailure(snackBarFailureText: 'error api'));
      } else if (effect is NavigateToNextPage) {
        context.read<LoginCubit>().nextPage();
        ScaffoldMessenger.of(context).showSnackBar(
            snackBarWhenSuccess(snackBarSuccessText: 'register success'));
      } else if (effect is NavigateToLogin) {
        context.read<LoginCubit>().moveToPage(0);
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenSuccess(
            snackBarSuccessText: 'confirm register code success'));
      } else if (effect is ResendConfirm) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenSuccess(
            snackBarSuccessText: 'resend confirm register code'));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    registerCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const AuthenticationContainer(),
      const RegistrationContainer(),
      const VerificationContainer(),
      const ResetPasswordContainer(),
      const NewPasswordContainer(),
      SuccessCard(
          onTap: () {
            context.read<LoginCubit>().moveToPage(0);
          },
          title: 'Пароль змінено',
          titleButton: 'Повернутись до входу')
    ];

    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      final cubit = context.read<LoginCubit>();
      return Scaffold(
        backgroundColor: AppTheme.white,
        body: Container(
            child: kIsWeb
                ? buildWebContent(cubit, pages)
                : buildMobileContent(cubit, pages)),
      );
    });
  }
}

Widget buildMobileContent(LoginCubit cubit, List<StatelessWidget> pages) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(AppTheme.cardPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppTheme.cardPadding),
            child: SvgPicture.asset(
              IconPath.moxylogo,
              width: 150,
            ),
          ),
          LayoutBuilder(builder: (context, constraints) {
            return SizedBox(
              height: 400,
              width: 400,
              child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: cubit.pageController,
                  onPageChanged: (int page) {
                    cubit.onChangePage(page);
                  },
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return pages[index];
                  }),
            );
          }),
        ],
      ),
    ),
  );
}

Widget buildWebContent(LoginCubit cubit, List<StatelessWidget> pages) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SvgPicture.asset(
                    IconPath.moxylogo,
                    width: 100,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: cubit.pageController,
                    onPageChanged: (int page) {
                      cubit.onChangePage(page);
                    },
                    itemCount: pages.length,
                    itemBuilder: (context, index) {
                      return pages[index];
                    }),
              ),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.asset(
            ImageAssets.loginWeb,
          ),
        ),
      ),
    ],
  );
}

void showSuccessSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
      .showSnackBar(snackBarWhenSuccess(snackBarSuccessText: message));
}

void showFailureSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
      .showSnackBar(snackBarWhenFailure(snackBarFailureText: message));
}
