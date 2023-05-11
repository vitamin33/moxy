import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          child: Column(children: [
            TextField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Name',
                ),
                controller: cubit.nameController,
                onChanged: (value) => cubit.nameChanged(value)),
            TextField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Description',
              ),
              controller: cubit.descriptionController,
              onChanged: (value) => cubit.descriptionChanged(value),
              maxLines: 6,
            ),
            TextField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'idName',
              ),
              controller: cubit.idNameController,
              onChanged: (value) => cubit.idNameChanged(value),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: Color.fromARGB(255, 254, 182, 191),
                width: 300,
                height: 150,
                child: Column(children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.dimensions.isNotEmpty
                          ? state.dimensions.length
                          : 1,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppTheme.blackLight, width: 1.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DropdownButton<String>(
                                value: dropdownValue,
                                icon: const Icon(Icons.arrow_drop_down),
                                dropdownColor: AppTheme.primaryContainerColor,
                                underline: Container(
                                  height: 1,
                                  color: AppTheme.secondaryColor,
                                ),
                                onChanged: (value) {
                                  dropdownValue = value!;
                                  // cubit.updateColor(index, value);
                                },
                                items: productColors
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                width: 50,
                                child: TextField(
                                    decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Queke',
                                    ),
                                    controller: cubit.quantityController,
                                    onChanged: (value) =>
                                        {cubit.quantityChanged(value)},
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(16),
                                    ]),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                      width: 100,
                      height: 20,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('add'),
                      ))
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
