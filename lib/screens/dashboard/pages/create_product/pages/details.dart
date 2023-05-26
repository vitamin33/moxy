import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/create_product/create_product_cubit.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';
import '../../../../../components/custom_textfield.dart';
import '../../../../../constant/colors_image.dart';
import '../../../../../constant/image_path.dart';
import '../../../../../constant/product_colors.dart';
import '../../../../../domain/create_product/create_product_state.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        final cubit = context.read<CreateProductCubit>();

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
          child: Column(children: [
            CustomTextField(
              title: 'Name',
              maxLines: 1,
              controller: cubit.nameController,
              onChanged: cubit.nameChanged,
              validation: true,
              state: state.errors.productName,
            ),
            const SizedBox(height: 30),
            CustomTextField(
              title: 'Description',
              controller: cubit.descriptionController,
              onChanged: cubit.descriptionChanged,
              validation: true,
              state: state.errors.productDescription,
            ),
            const SizedBox(height: 30),
            CustomTextField(
              title: 'IdName',
              maxLines: 1,
              controller: cubit.idNameController,
              onChanged: cubit.idNameChanged,
              validation: true,
              state: state.errors.productIdName,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.allDimensions.length,
                      itemBuilder: (context, index) {
                        final dimen = state.allDimensions[index];

                        return _buildColorQuantityRow(dimen, cubit, index);
                      },
                    ),
                  ),
                ]),
              ),
            )
          ]),
        );
        ;
      },
    );
  }
}

Widget _buildColorQuantityRow(
    Dimension colorDimen, CreateProductCubit cubit, int index) {
  return GestureDetector(
      onTap: () {
        cubit.toggleColorField(index);
      },
      child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: colorDimen.isSelected ? AppTheme.black : null,
            border: Border.all(
              color:
                  colorDimen.isSelected ? AppTheme.black : Colors.transparent,
              width: 1,
            ),
          ),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: AppTheme.white,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: AppTheme.pink,
              backgroundImage: AssetImage(colorDimen.image!),
            ),
          )));
}
