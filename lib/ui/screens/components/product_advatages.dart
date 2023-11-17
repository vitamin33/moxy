import 'package:flutter/material.dart';
import 'package:moxy/constant/image_path.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class ProductAdvatages extends StatelessWidget {
  const ProductAdvatages({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Переваги товару'),
        Row(
          children: [
            Image.asset(
              ImageAssets.bigPictureHome,
              width: 100,
            ),
            const Column(
              children: [
                Text('1'),
                Divider(
                  color: AppTheme.black,
                ),
                Text(
                    'Металеві елементи всі виконанні із 100% якістюю і мають нержавіюючу сталь')
              ],
            )
          ],
        ),
        Row(
          children: [
            const Column(
              children: [
                Text('2'),
                Divider(
                  color: AppTheme.black,
                ),
                Text(
                    'Тканина у наших сумочка зроблена з якісного матеріалу, а також прослужить вам багато років.')
              ],
            ),
            Image.asset(ImageAssets.bigPictureHome, width: 100),
          ],
        ),
        Row(
          children: [
            Image.asset(ImageAssets.bigPictureHome, width: 100),
            const Column(
              children: [
                Text('3'),
                Divider(
                  color: AppTheme.black,
                ),
                Text(
                    'Наші сумочки дуже зручні та укомплектовані, мають достатю кількість кишеньок, щоб комфортно носити в ній всі ваші необхідні речі.')
              ],
            )
          ],
        )
      ],
    );
  }
}
