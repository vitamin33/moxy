import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/product_details/product_details_cubit.dart';
import 'package:moxy/domain/models/product_advatages.dart';
import 'package:moxy/ui/screens/components/footer_web.dart';
import 'package:moxy/ui/screens/components/product_advatages_container.dart';
import 'package:moxy/ui/screens/components/product_details_container.dart';
import 'package:moxy/ui/screens/components/recomended_products.dart';
import 'package:moxy/ui/screens/components/resale_products.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class ProductDetailsPage extends StatelessWidget {
  final String? productId;
  const ProductDetailsPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(productId: productId),
      child: Scaffold(
        backgroundColor: AppTheme.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const ProductDetailsContainer(),
                ProductAdvantagesContainer(
                  productAdvatagesList: [
                    ProductAdvatages(
                        imageUrl:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRpHX2AbWn1LJELg00_wpjemglwA1whRqEwA&usqp=CAU',
                        header: 'header',
                        description: 'description'),
                    ProductAdvatages(
                        imageUrl:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRpHX2AbWn1LJELg00_wpjemglwA1whRqEwA&usqp=CAU',
                        header: 'header',
                        description: 'description')
                  ],
                ),
                const RecomendedProducts(),
                const ResaleProducts(),
                const Footer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
