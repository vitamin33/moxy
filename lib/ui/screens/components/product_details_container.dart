import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/constant/colors_image.dart';
import 'package:moxy/constant/image_path.dart';
import 'package:moxy/domain/client/product_details/product_details_cubit.dart';
import 'package:moxy/domain/client/product_details/product_details_state.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class ProductDetailsContainer extends StatelessWidget {
  const ProductDetailsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        return Row(
          children: [
            SizedBox(
                width: 300,
                height: 500,
                child: Image.asset(ImageAssets.bigPictureHome)),
            Column(
              children: [
                Text('Кросівки зимові біло-бежеві'),
                SizedBox(height: 10),
                Text('785 uah'),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Color:'),
                    _buildColorWidget(colorsImage.first)
                  ],
                ),
                SizedBox(height: 10),
                Text('Відправка завтра 27.09'),
                SizedBox(height: 10),
                CustomButton(
                  title: 'Купити',
                  onTap: () {},
                  buttonWidth: 300,
                )
              ],
            )
          ],
        );
      },
    );
  }
}

Widget _buildColorWidget(String color) {
  return Container(
    padding: const EdgeInsets.all(2),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        style: BorderStyle.solid,
        color: AppTheme.gray.withOpacity(0.4),
        width: 1,
      ),
    ),
    child: CircleAvatar(
      radius: 15,
      backgroundColor: AppTheme.greyLigth,
      child: CircleAvatar(
        radius: 13,
        backgroundColor: AppTheme.pink,
        backgroundImage: AssetImage(color),
      ),
    ),
  );
}

