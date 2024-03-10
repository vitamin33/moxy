import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class GuestProfileWidget extends StatelessWidget {
  const GuestProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(AppLocalizations.of(context)!.profilePageWelcomeGuest,
                style: theme.headline4SemiBoltText),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.profilePageContinueExploring,
              textAlign: TextAlign.center,
              style: theme.largeSemiBoltText,
            ),
            const SizedBox(height: 30),
            // List of advantages
            ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const Icon(Icons.monetization_on, color: AppTheme.black),
              title: Text(
                AppLocalizations.of(context)!.profilePageCashbackOffer,
                style: theme.headlineSemiBoltText,
              ),
            ),

            ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: const Icon(Icons.star, color: AppTheme.black),
              title: Text(
                AppLocalizations.of(context)!.profilePageSpecialPropositions,
                style: theme.headlineSemiBoltText,
              ),
            ),

            const SizedBox(height: 20),
            OutlineStateButton(
              title: AppLocalizations.of(context)!
                  .profilePageRegisterAndGetCashback,
              onTap: () {
                context.go(RouterProvider.registerPath());
              },
              buttonWidth: 300,
            ),
          ],
        ),
      ),
    );
  }
}
