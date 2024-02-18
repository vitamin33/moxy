import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/ui/components/succes_card.dart';

class SuccessPasswordPage extends StatelessWidget {
  const SuccessPasswordPage({super.key});

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
