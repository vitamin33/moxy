import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/create_product/create_product_cubit.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/theme/app_theme.dart';
import '../../../../../domain/create_product/create_product_state.dart';

class Branding extends StatelessWidget {
  const Branding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        final cubit = context.read<CreateProductCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
          child: Column(
            children: [
              Column(
                children: [
                  state.product.images.isNotEmpty
                      ? Row(children: [
                          Expanded(
                            child: SizedBox(
                              height: 120,
                              width: double.maxFinite,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.product.images.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: SizedBox(
                                      child: _buildImage(
                                          state.product, index, cubit),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ])
                      : const Icon(
                          Icons.cloud_upload_sharp,
                          color: AppTheme.blackLight,
                        ),
                  TextButton(
                      child: const Text('Pick Image from Gallery'),
                      onPressed: () {
                        cubit.pickImage();
                      }),
                ],
              ),
              SizedBox(
                width: 300,
                height: 200,
                child: Column(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            border:
                                _renderBorder(!_costPriceIsValid(state), false),
                            enabledBorder:
                                _renderBorder(_costPriceIsValid(state), false),
                            focusedBorder:
                                _renderBorder(_costPriceIsValid(state), true),
                            hintStyle:
                                _renderHintStyle(context, _nameIsValid(state)),
                            hintText: 'Price(\$)'),
                        controller: cubit.costPriceController,
                        onChanged: (value) => {cubit.costPriceChanged(value)},
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppTheme.cardPadding),
                    Expanded(
                      child: TextField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            hintText: 'Sale Price(\$)',
                          ),
                          controller: cubit.salePriceController,
                          onChanged: (value) => {cubit.salePriceChanged(value)},
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(16),
                          ]),
                    ),
                    const SizedBox(width: AppTheme.cardPadding),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _buildImage(Product product, int index, cubit) {
    final images = product.images;
    if (images.isEmpty) {
      return Container();
    } else {
      final image = images[index];
      if (image.type == Type.file) {
        return Stack(
          children: [
            Image.file(
              File(image.imagePath),
              width: 80,
              height: 100,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  cubit.removeImage(index);
                },
                child: const Icon(Icons.close, color: AppTheme.blackLight),
              ),
            ),
          ],
        );
      } else {
        return Stack(
          children: [
            Image.network(image.imagePath),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  cubit.removeImage(index);
                },
                child: const Icon(Icons.close, color: AppTheme.blackLight),
              ),
            ),
          ],
        );
      }
    }
  }

  UnderlineInputBorder _renderBorder(bool isValid, bool focused) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
          color: isValid ? AppTheme.secondaryColor : Colors.red,
          width: focused ? 2 : 1),
    );
  }

  bool _costPriceIsValid(CreateProductState state) =>
      state.errors.costPrice == null;

  bool _salePriceIsValid(CreateProductState state) =>
      state.errors.salePrice == null;

  TextStyle _renderHintStyle(BuildContext context, bool isValid) {
    return TextStyle(
      color: isValid ? Theme.of(context).hintColor : Colors.red,
    );
  }
}
