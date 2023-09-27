import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        body: SingleChildScrollView(
          child: kIsWeb
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: AuthenticationContainer()),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Image.asset(ImageAssets.loginWeb),
                      ),
                    ],
                  ),
                )
              : AuthenticationContainer(),
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
