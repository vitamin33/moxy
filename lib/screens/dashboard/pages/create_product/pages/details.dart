import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/product_cubit.dart';
import 'package:moxy/theme/app_theme.dart';
import '../../../../../domain/product_state.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, ProductState>(
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
                  hintText: 'Color',
                ),
                controller: cubit.colorController,
                onChanged: (value) => cubit.colorChanged(value),
              ),
            ],
          ),
        );
        ;
      },
    );
  }
}
