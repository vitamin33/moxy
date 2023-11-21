import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/product_details/product_details_cubit.dart';
import 'package:moxy/ui/screens/components/footer_web.dart';
import 'package:moxy/ui/screens/components/product_advatages.dart';
import 'package:moxy/ui/screens/components/product_details_container.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class ProductDetailsPage extends StatelessWidget {
  final String? productId;
  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(productId: productId),
      child: const Scaffold(
        backgroundColor: AppTheme.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                ProductDetailsContainer(),
                ProductAdvantages(),
                Footer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
