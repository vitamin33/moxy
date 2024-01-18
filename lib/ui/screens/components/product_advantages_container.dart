import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/product_details/product_details_cubit.dart';
import 'package:moxy/domain/client/product_details/product_details_state.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class ProductAdvantagesContainer extends StatelessWidget {
  const ProductAdvantagesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;

    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        final advantages = state.productDetails.productAdvantages;
        return (advantages != null && advantages.isNotEmpty)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Переваги товару',
                      style: theme.bigTitleBoltText,
                    ),
                  ),
                  ListView.builder(
                    itemCount: advantages.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return AdvantageItem(
                        image: advantages[index].imageUrl,
                        header: advantages[index].header,
                        description: advantages[index].description,
                        showTextFirst: index % 2 == 0 ? true : false,
                      );
                    },
                  )
                ],
              )
            : const SizedBox();
      },
    );
  }
}

class AdvantageItem extends StatelessWidget {
  final String image;
  final String header;
  final String description;
  final bool showTextFirst;

  const AdvantageItem({
    super.key,
    required this.image,
    required this.header,
    required this.description,
    this.showTextFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!showTextFirst)
            Image.network(
              image,
              fit: BoxFit.cover,
            ),
          if (!showTextFirst) const SizedBox(width: 130),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  header,
                  style: theme.bigTitleBoltText,
                ),
                const Divider(
                  color: AppTheme.black,
                ),
                Text(description, style: theme.titleText),
              ],
            ),
          ),
          if (showTextFirst) const SizedBox(width: 130),
          if (showTextFirst)
            Image.network(
              image,
              fit: BoxFit.cover,
            ),
        ],
      ),
    );
  }
}
