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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.profilePageWelcomeGuest,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.profilePageContinueExploring,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            // List of advantages
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 150),
              leading: const Icon(Icons.monetization_on, color: AppTheme.black),
              title:
                  Text(AppLocalizations.of(context)!.profilePageCashbackOffer),
            ),

            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 150),
              leading: const Icon(Icons.star, color: AppTheme.black),
              title: Text(
                  AppLocalizations.of(context)!.profilePageSpecialPropositions),
            ),
            const SizedBox(height: 20),
            CustomButton(
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
