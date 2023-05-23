import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/create_product/create_product_cubit.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/theme/app_theme.dart';
import '../../../../../components/custom_textfield.dart';
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
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Container(
            //     color: const Color.fromARGB(255, 254, 182, 191),
            //     width: 300,
            //     height: 150,
            //     child: Column(children: [
            //       Expanded(
            //         child: ListView.builder(
            //           itemCount: state.product.dimensions.length,
            //           itemBuilder: (context, index) {
            //             return _buildColorQuantityRow(state, cubit, index);
            //           },
            //         ),
            //       ),
            //       SizedBox(
            //           width: 100,
            //           height: 20,
            //           child: TextButton(
            //             onPressed: () {
            //               cubit.addColorField();
            //             },
            //             child: const Text('add'),
            //           ))
            //     ]),
            //   ),
            // )
          ]),
        );
        ;
      },
    );
  }

  Widget _buildColorQuantityRow(
      CreateProductState state, CreateProductCubit cubit, int index) {
    List<Dimension> dropDownItems = allColorsDimens.toList();

    List<DropdownMenuItem<Dimension>> items = dropDownItems
        .map(
          (dimen) => DropdownMenuItem(
            value: dimen,
            child: Text(dimen.color),
          ),
        )
        .toList();
    Dimension? dropdownValue = state.product.dimensions[index];
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppTheme.blackLight, width: 1.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DropdownButton<Dimension>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_drop_down),
              dropdownColor: AppTheme.primaryContainerColor,
              underline: Container(
                height: 1,
                color: AppTheme.secondaryColor,
              ),
              items: items,
              onChanged: (newDimen) {
                if (newDimen == null) {
                  return;
                }
                Dimension? currentDimen = state.product.dimensions[index];
                cubit.colorChanged(index, currentDimen, newDimen);
              }),
          SizedBox(
            width: 50,
            child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Quantity',
                ),
                // controller: cubit.quantityControllers![index]!,
                onChanged: (value) {
                  cubit.quantityChanged(index, value);
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                ]),
          )
        ],
      ),
    );
  }
}
