import 'package:flutter/material.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoadingElevatedButton extends StatelessWidget {
  const LoadingElevatedButton(
      {Key? key, required this.onPressed, required this.isLoadingState});

  final VoidCallback onPressed;
  final bool isLoadingState;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    return ElevatedButton(
      onPressed: isLoadingState
          ? null
          : () {
              onPressed();
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: isLoadingState ? AppTheme.gray : AppTheme.textColor,
        foregroundColor: Colors.white,
        shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.checkout.toUpperCase(),
              style: theme.titleBoltText,
            ),
            const SizedBox(width: 20),
            isLoadingState
                ? const SizedBox(
                    height: 12,
                    width: 12,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      strokeWidth: 2.0,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
