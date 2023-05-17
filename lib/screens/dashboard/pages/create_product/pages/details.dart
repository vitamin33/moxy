import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/create_product/create_product_cubit.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/theme/app_theme.dart';
import '../../../../../constant/product_colors.dart';
import '../../../../../domain/create_product/create_product_state.dart';
import '../../../../../domain/validation_mixin.dart';

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
            TextField(
                decoration: InputDecoration(
                  border: _renderBorder(!_nameIsValid(state), false),
                  enabledBorder: _renderBorder(_nameIsValid(state), false),
                  focusedBorder: _renderBorder(_nameIsValid(state), true),
                  hintStyle: _renderHintStyle(context, _nameIsValid(state)),
                  hintText: 'Name',
                ),
                controller: cubit.nameController,
                onChanged: (value) => cubit.nameChanged(value)),
            TextField(
              decoration: InputDecoration(
                border: _renderBorder(!_descriptionIsValid(state), false),
                enabledBorder: _renderBorder(_descriptionIsValid(state), false),
                focusedBorder: _renderBorder(_descriptionIsValid(state), true),
                hintStyle:
                    _renderHintStyle(context, _descriptionIsValid(state)),
                hintText: 'Description',
              ),
              controller: cubit.descriptionController,
              onChanged: (value) => cubit.descriptionChanged(value),
              maxLines: 6,
            ),
            TextField(
              decoration: InputDecoration(
                border: _renderBorder(_idNameIsValid(state), false),
                enabledBorder: _renderBorder(_idNameIsValid(state), false),
                focusedBorder: _renderBorder(_idNameIsValid(state), true),
                hintStyle: _renderHintStyle(context, _idNameIsValid(state)),
                hintText: 'idName',
              ),
              controller: cubit.idNameController,
              onChanged: (value) => cubit.idNameChanged(value),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: const Color.fromARGB(255, 254, 182, 191),
                width: 300,
                height: 150,
                child: Column(children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.product.dimensions.length,
                      itemBuilder: (context, index) {
                        return _buildColorQuantityRow(state, cubit, index);
                      },
                    ),
                  ),
                  SizedBox(
                      width: 100,
                      height: 20,
                      child: TextButton(
                        onPressed: () {
                          cubit.addColorField();
                        },
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
                  border: UnderlineInputBorder(),
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

  UnderlineInputBorder _renderBorder(bool isValid, bool focused) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
          color: isValid ? AppTheme.secondaryColor : Colors.red,
          width: focused ? 2 : 1),
    );
  }

  bool _nameIsValid(CreateProductState state) =>
      state.errors.productName == null;

  bool _descriptionIsValid(CreateProductState state) =>
      state.errors.productDescription == null;

  bool _idNameIsValid(CreateProductState state) =>
      state.errors.productIdName == null;

  TextStyle _renderHintStyle(BuildContext context, bool isValid) {
    return TextStyle(
      color: isValid ? Theme.of(context).hintColor : Colors.red,
    );
  }
}
