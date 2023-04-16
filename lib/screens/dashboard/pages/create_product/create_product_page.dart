// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:moxy/components/app_scaffold.dart';
import 'package:moxy/domain/create_product_state.dart';
import 'package:moxy/screens/dashboard/pages/create_product/pages/branding.dart';
import 'package:moxy/screens/dashboard/pages/create_product/pages/details.dart';
import 'package:moxy/screens/dashboard/pages/create_product/pages/pricing.dart';
import 'package:moxy/screens/dashboard/pages/create_product/pages/summary.dart';
import 'package:moxy/theme/app_theme.dart';
import 'package:provider/provider.dart';

import '../../../../components/rounded_card.dart';
import '../../components/product_progress.dart';

class CreateProductPage extends StatelessWidget {
  const CreateProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CreateProductState>();
    List<Widget> pages = const [
      ProductDetails(),
      Branding(),
      Pricing(),
      Summary(),
    ];

    return AppScaffold(
      appbar: AppBar(
        title: const Text("Create Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppTheme.cardPadding * 2),
        child: RoundedCard(
          padding: const EdgeInsets.all(AppTheme.elementSpacing),
          child: Column(
            children: [
              CreateProductProgress(
                count: (state.currentPage + 1) * 25,
                onChangePage: (int page) {
                  if (state.visitedPages.contains(page)) {
                    state.animateToPage(page);
                  }
                },
              ),
              SizedBox(height: AppTheme.cardPadding),
              Expanded(
                child: PageView.builder(
                  controller: state.pageController,
                  onPageChanged: state.onChangePage,
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    return pages[index];
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CreateProductView extends StatelessWidget {
  const CreateProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CreateProductState(),
      child: const CreateProductPage(),
    );
  }
}
