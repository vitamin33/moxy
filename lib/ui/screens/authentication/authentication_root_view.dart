import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/constant/image_path.dart';
import 'package:moxy/domain/auth/login/login_cubit.dart';
import 'package:moxy/domain/auth/login/login_state.dart';
import 'package:moxy/domain/auth/registration/registration_cubit.dart';
import 'package:moxy/domain/auth/registration/registration_effect.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/animated_branch_container.dart';
import 'package:moxy/utils/responsive_utils.dart';
import '../../components/snackbar_widgets.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class AuthenticationRootView extends StatefulWidget {
  StatefulNavigationShell navigationShell;
  List<Widget> children;
  AuthenticationRootView({
    super.key,
    required this.navigationShell,
    required this.children,
  });

  @override
  State<AuthenticationRootView> createState() => _AuthenticationRootViewState();
}

class _AuthenticationRootViewState extends State<AuthenticationRootView> {
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
      } else if (effect is RegisterSuccess) {
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
    final isMobile = ResponsiveUtil.isMobile(context);
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      final cubit = context.read<LoginCubit>();
      return Scaffold(
        backgroundColor: AppTheme.white,
        body: Container(
            child:
                isMobile ? buildMobileContent(cubit) : buildWebContent(cubit)),
      );
    });
  }

  Widget buildMobileContent(LoginCubit cubit) {
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
                height: 470,
                width: 400,
                child: AnimatedBranchContainer(
                  currentIndex: widget.navigationShell.currentIndex,
                  children: widget.children,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildWebContent(LoginCubit cubit) {
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
                  child: AnimatedBranchContainer(
                    currentIndex: widget.navigationShell.currentIndex,
                    children: widget.children,
                  ),
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
}

void showSuccessSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
      .showSnackBar(snackBarWhenSuccess(snackBarSuccessText: message));
}

void showFailureSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
      .showSnackBar(snackBarWhenFailure(snackBarFailureText: message));
}
