import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/constant/image_path.dart';
import 'package:moxy/domain/roles.dart';
import 'package:moxy/services/navigation/root_router_cubit.dart';
import 'package:moxy/ui/screens/components/authentication_container.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import '../../components/snackbar_widgets.dart';
import '../../../domain/auth/login_cubit.dart';
import '../../../domain/auth/login_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rootNavCubit = context.read<RootRouterCubit>();
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        final cubit = context.read<LoginCubit>();
        if (state.state is LoginFailed) {
          showFailureSnackbar(
              context, AppLocalizations.of(context)!.failedLoginError);
          cubit.clearState();
        } else if (state.state is LoginWithCredsSuccess) {
          final role = (state.state as LoginWithCredsSuccess).role;
          if (role == Role.admin || role == Role.manager) {
            rootNavCubit.goToAdminFlow();
          } else {
            rootNavCubit.goToClientHomeFlow();
          }
          cubit.clearState();
        } else if (state.state is Logout) {
          cubit.clearState();
        }
      },
      builder: (context, state) => Scaffold(
        backgroundColor: AppTheme.white,
        body: Container(
          child: kIsWeb
              ? Row(
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
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: const AuthenticationContainer()),
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
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.all(AppTheme.cardPadding),
                        child: SvgPicture.asset(
                          IconPath.moxylogo,
                          width: 150,
                        ),
                      ),
                      const AuthenticationContainer(),
                    ],
                  ),
                ),
        ),
      ),
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
}
