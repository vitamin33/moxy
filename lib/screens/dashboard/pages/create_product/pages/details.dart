import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/create_product/create_product_cubit.dart';
import 'package:moxy/theme/app_theme.dart';
import '../../../../../constant/product_colors.dart';
import '../../../../../domain/create_product/create_product_state.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dropdownValue = productColors.first;

    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        final cubit = context.read<CreateProductCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Name',
                ),
                controller: cubit.nameController,
                onChanged: (value) => cubit.nameChanged(value )
              ),
              TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Description',
                ),
                controller: cubit.descriptionController,
                onChanged: (value) => cubit.descriptionChanged(value),
                maxLines: 6,
              ),
              Padding(
                padding: const EdgeInsets.all(AppTheme.cardPadding),
                child: DropdownButton<String>(
                  value:dropdownValue ,
                  icon: const Icon(Icons.arrow_drop_down),
                  dropdownColor: AppTheme.primaryContainerColor,
                  underline: Container(
                    height: 1,
                    color: AppTheme.secondaryColor,
                  ),
                  onChanged: (value) {
                    dropdownValue = value!;
                    cubit.colorChanged(value);
                  },
                  items: productColors
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
        ;
      },
    );
  }
}
