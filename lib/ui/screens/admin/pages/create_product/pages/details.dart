import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/admin/create_product/create_product_cubit.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/ui/screens/components/product_category_chooser.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';
import '../../../../../components/custom_textfield.dart';
import '../../../../../../domain/admin/create_product/create_product_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdminProductDetailsPage extends StatelessWidget {
  const AdminProductDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        final cubit = context.read<CreateProductCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
          child: SingleChildScrollView(
            child: SizedBox(
              child: Column(children: [
                CustomTextField(
                  title: AppLocalizations.of(context)!.createProductName,
                  maxLines: 1,
                  controller: cubit.nameController,
                  onChanged: cubit.nameChanged,
                  validation: true,
                  state: state.errors.productName,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  maxLines: 6,
                  title: AppLocalizations.of(context)!.createProductDescription,
                  controller: cubit.descriptionController,
                  onChanged: cubit.descriptionChanged,
                  validation: true,
                  state: state.errors.productDescription,
                ),
                const SizedBox(height: 10),
                ProductCategoryChooser(
                    categories: state.productCategories,
                    onCategoryChosen: (String categoryName) {
                      cubit.categorySelected(categoryName);
                    }),
                const SizedBox(height: 10),
                CustomTextField(
                  title: AppLocalizations.of(context)!.createProductIdName,
                  maxLines: 1,
                  controller: cubit.idNameController,
                  onChanged: cubit.idNameChanged,
                  validation: true,
                  state: state.errors.productIdName,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _renderBorder(isValid(state.errors.dimensions)),
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: Row(children: [
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.allConfigColors.length,
                          itemBuilder: (context, index) {
                            final color = state.allConfigColors[index];
                            return _buildColorQuantityRow(color, cubit, index);
                          },
                        ),
                      ),
                    ]),
                  ),
                ),
                ..._buildAttributesFields(context, state, cubit),
              ]),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildAttributesFields(BuildContext context,
      CreateProductState state, CreateProductCubit cubit) {
    return [
      CustomTextField(
        title: AppLocalizations.of(context)!.createProductHeightInCm,
        maxLines: 1,
        controller: cubit.heightController,
        onChanged: cubit.heightInCmChanged,
        validation: true,
        state: state.errors.heightInCm,
      ),
      const SizedBox(height: 15),
      CustomTextField(
        title: AppLocalizations.of(context)!.createProductWidthInCm,
        maxLines: 1,
        controller: cubit.widthController,
        onChanged: cubit.widthInCmChanged,
        validation: true,
        state: state.errors.widthInCm,
      ),
      const SizedBox(height: 15),
      CustomTextField(
        title: AppLocalizations.of(context)!.createProductLengthInCm,
        maxLines: 1,
        controller: cubit.lengthController,
        onChanged: cubit.lengthInCmChanged,
        validation: true,
        state: state.errors.lengthInCm,
      ),
      const SizedBox(height: 15),
      CustomTextField(
        title: AppLocalizations.of(context)!.createProductDepthInCm,
        maxLines: 1,
        controller: cubit.depthController,
        onChanged: cubit.depthInCmChanged,
      ),
      const SizedBox(height: 15),
      CustomTextField(
        title: AppLocalizations.of(context)!.createProductSeason,
        maxLines: 1,
        controller: cubit.seasonController,
        onChanged: cubit.seasonChanged,
      ),
      const SizedBox(height: 15),
      CustomTextField(
        title: AppLocalizations.of(context)!.createProductFurniture,
        maxLines: 1,
        controller: cubit.furnitureController,
        onChanged: cubit.furnitureChanged,
      ),
      const SizedBox(height: 15),
      CustomTextField(
        title: AppLocalizations.of(context)!.createProductStrap,
        maxLines: 1,
        controller: cubit.strapController,
        onChanged: cubit.strapChanged,
      ),
      const SizedBox(height: 15),
      CustomTextField(
        title: AppLocalizations.of(context)!.createProductProducer,
        maxLines: 1,
        controller: cubit.producerController,
        onChanged: cubit.producerChanged,
      ),
      const SizedBox(height: 15),
      CustomTextField(
        title: AppLocalizations.of(context)!.createProductStyle,
        maxLines: 1,
        controller: cubit.styleController,
        onChanged: cubit.styleChanged,
      ),
      const SizedBox(height: 15),
    ];
  }
}

Widget _buildColorQuantityRow(
    ProductColor color, CreateProductCubit cubit, int index) {
  return GestureDetector(
      onTap: () {
        cubit.toggleColorField(index);
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.isSelected ? AppTheme.black : null,
              border: Border.all(
                style: BorderStyle.solid,
                color: color.isSelected ? AppTheme.black : Colors.transparent,
                width: 1,
              ),
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppTheme.white,
              child: CircleAvatar(
                radius: 15,
                backgroundColor: _generateColor(color),
              ),
            )),
      ));
}

Color _generateColor(ProductColor color) {
  return hexToColor(color.hexCode);
}

Color _renderBorder(bool isValid) {
  return isValid ? Colors.transparent : Colors.red;
}
