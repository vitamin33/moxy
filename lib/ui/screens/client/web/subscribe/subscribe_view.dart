import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/api_path.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/client/subscribe/subscribe_cubit.dart';
import 'package:moxy/domain/client/subscribe/subscribe_effect.dart';
import 'package:moxy/domain/client/subscribe/subscribe_state.dart';
import 'package:moxy/ui/components/snackbar_widgets.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as dartJsFile;

class SubscribeView extends StatefulWidget {
  const SubscribeView({super.key});

  @override
  State<SubscribeView> createState() => _SubscribeViewState();
}

class _SubscribeViewState extends State<SubscribeView> {
  late SubscribeCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = SubscribeCubit();

    cubit.effectStream.listen((effect) {
      if (effect is SubscribeApiRequestFailed) {
        ScaffoldMessenger.of(context).showSnackBar(
            snackBarWhenFailure(snackBarFailureText: effect.failureText));
      }
      if (effect is SubscribeValidationFailed) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
            snackBarFailureText: 'Not valid input, please check fields.'));
      }
      if (effect is SubscribeSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenSuccess(
            snackBarSuccessText:
                AppLocalizations.of(context)!.subscribeSuccessMessage));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;

    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<SubscribeCubit, SubscribeState>(
        builder: (context, state) {
          return SizedBox(
            width: 350,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    AppLocalizations.of(context)!.subscribeNewsletter,
                    softWrap: true,
                    style: theme.headlineText,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    AppLocalizations.of(context)!.subscribeInfoText,
                    overflow: TextOverflow.visible,
                    maxLines: 5,
                    softWrap: true,
                    style: theme.mediumText,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: cubit.emailController,
                          maxLines: 1,
                          onChanged: cubit.emailChanged,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.email,
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: state.isEmailValid
                                      ? AppTheme.pinkDark
                                      : AppTheme.red),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          cubit.subscribeLead();
                          dartJsFile.context.callMethod('fbqLeadEvent',[cubit.emailController.text]);
                        },
                        child: SvgPicture.asset(IconPath.textFieldArrowWeb),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            launchUrl(Uri.parse(instagramMoxyUrl));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppTheme.black,
                                borderRadius: BorderRadius.circular(50)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                IconPath.instagramIcon,
                                color: AppTheme.white,
                              ),
                            ),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            launchUrl(Uri.parse(tiktokMoxyUrl));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: AppTheme.black,
                                borderRadius: BorderRadius.circular(50)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                IconPath.tikTokIcon,
                                color: AppTheme.white,
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
