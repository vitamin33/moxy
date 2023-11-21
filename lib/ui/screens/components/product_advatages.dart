import 'package:flutter/material.dart';
import 'package:moxy/constant/image_path.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class ProductAdvantages extends StatelessWidget {
  const ProductAdvantages({super.key});

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
        const AdvantageItem(
          image: ImageAssets.bigPictureHome,
          number: '1',
          description:
              'Металеві елементи всі виконанні із 100% якістюю і мають нержавіюючу сталь',
        ),
        const AdvantageItem(
          image: ImageAssets.bigPictureHome,
          number: '2',
          description:
              'Тканина у наших сумочка зроблена з якісного матеріалу, а також прослужить вам багато років.',
          showTextFirst: true,
        ),
        const AdvantageItem(
          image: ImageAssets.bigPictureHome,
          number: '3',
          description:
              'Наші сумочки дуже зручні та укомплектовані, мають достатю кількість кишеньок, щоб комфортно носити в ній всі ваші необхідні речі.',
        ),
      ],
    );
  }
}

class AdvantageItem extends StatelessWidget {
  final String image;
  final String number;
  final String description;
  final bool showTextFirst;

  const AdvantageItem({
    super.key,
    required this.image,
    required this.number,
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
            Image.asset(
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
                  number,
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
            Image.asset(
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
