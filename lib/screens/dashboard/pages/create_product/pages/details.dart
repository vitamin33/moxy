import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/create_product/create_product_cubit.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';
import '../../../../../components/custom_textfield.dart';
import '../../../../../constant/colors_image.dart';
import '../../../../../constant/product_colors.dart';
import '../../../../../domain/create_product/create_product_state.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        final cubit = context.read<CreateProductCubit>();
        List<Dimension> dropDownItems = allColorsDimens.toList();
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
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Row(children: [
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dropDownItems.length,
                      itemBuilder: (context, index) {
                        return _buildColorQuantityRow(state, cubit, index);
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

  Widget _buildColorQuantityRow(
      CreateProductState state, CreateProductCubit cubit, int index) {
    List<Dimension> dropDownItems = allColorsDimens.toList();
    Dimension? dropdownValue = state.product.dimensions[index];
    return InkWell(
        onTap: () {
          cubit.addColorField (dropDownItems[index]);
          moxyPrint(state.product.dimensions);
        },
        child: Container(
            padding: EdgeInsets.all(3),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppTheme.white,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: AppTheme.gray,
                backgroundImage: NetworkImage(colorsImage[index]),
              ),
            )
            ));
  }
}
