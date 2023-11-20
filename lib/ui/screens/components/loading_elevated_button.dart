import 'package:flutter/material.dart';
import 'package:moxy/ui/theme/app_theme.dart';

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Checkout',
              style: theme.headline2BoltText,
            ),
            const SizedBox(width: 20),
            isLoadingState
                ? const SizedBox(
                    height: 12,
                    width: 12,
                    child: CircularProgressIndicator(
                      backgroundColor:
                          Colors.white, // Change the color as needed
                      strokeWidth: 2.0, // Adjust the thickness as needed
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
