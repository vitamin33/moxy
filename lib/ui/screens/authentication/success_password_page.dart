import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/ui/components/succes_card.dart';

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SuccessCard(
        onTap: () {
          context.go(RouterProvider.loginPath());
        },
        title: 'Пароль змінено',
        titleButton: 'Повернутись до входу');
  }
}
