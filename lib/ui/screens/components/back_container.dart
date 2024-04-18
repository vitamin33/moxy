import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BackContainer extends StatelessWidget {
  const BackContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => context.pop(),
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              const SizedBox(width: 10),
              Text(
                AppLocalizations.of(context)!.goBack,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ));
  }
}
