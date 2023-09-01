import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/new_product_list/new_product_list_cubit.dart';
import 'package:moxy/ui/screens/components/product_grid.dart';

import '../../../domain/client/new_product_list/new_product_list_state.dart';

class NewProductList extends StatelessWidget {
  const NewProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => NewProductListCubit(),
        child: BlocBuilder<NewProductListCubit, NewProductListState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: state.isLoading
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        NewProductListGrid(
                            bigBlockLeading: false,
                            allSellingProduct: state.allSellingProduct),
                        NewProductListGrid(
                            bigBlockLeading: true,
                            allSellingProduct: state.allSellingProduct),
                      ],
                    ),
            );
          },
        ));
  }
}
