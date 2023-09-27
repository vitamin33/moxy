import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/product_details/product_details_cubit.dart';
import 'package:moxy/ui/screens/components/footer_web.dart';
import 'package:moxy/ui/screens/components/product_details_container.dart';
import 'package:moxy/ui/screens/components/promo_container.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(),
      child:const Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [ProductDetailsContainer(), PromoContainer(), Footer()],
            ),
          ),
        ),
      ),
    );
  }
}
