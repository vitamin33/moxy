import 'package:flutter/material.dart';
import 'package:moxy/domain/models/product_advatages.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class ProductAdvantagesContainer extends StatelessWidget {
  final List<ProductAdvatages> productAdvatagesList;

  const ProductAdvantagesContainer(
      {super.key, required this.productAdvatagesList});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;

    return Column(
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
          itemCount: productAdvatagesList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return AdvantageItem(
              image: productAdvatagesList[index].imageUrl,
              header: productAdvatagesList[index].header,
              description: productAdvatagesList[index].description,
              showTextFirst: index % 2 == 0 ? true : false,
            );
          },
        )
      ],
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
              width: 500,
              height: 350,
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
              width: 500,
              height: 350,
              fit: BoxFit.cover,
            ),
        ],
      ),
    );
  }
}
