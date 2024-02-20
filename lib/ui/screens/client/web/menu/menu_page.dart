import 'package:flutter/material.dart';
import 'package:moxy/data/repositories/footer_repository.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/ui/screens/components/footer.dart';
import 'package:moxy/ui/screens/components/menu_container.dart';
import 'package:moxy/ui/theme/app_theme.dart';

// ignore: must_be_immutable
class MenuPage extends StatelessWidget {
  final String menuTitle;
  MenuPage({super.key, required this.menuTitle});

  FooterRepository footerRepository = locate<FooterRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MenuContainer(
              menuTitle: footerRepository.parseToMenuTitle(menuTitle),
            ),
          ),
          const Footer()
        ]),
      ),
    );
  }
}
