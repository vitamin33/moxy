import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/new_product_list/new_product_list_cubit.dart';
import 'package:moxy/domain/client/new_product_list/new_product_list_effects.dart';
import 'package:moxy/ui/components/snackbar_widgets.dart';
import 'package:moxy/ui/screens/components/product_grid.dart';

import '../../../domain/client/new_product_list/new_product_list_state.dart';

class NewProductList extends StatefulWidget {
  const NewProductList({Key? key}) : super(key: key);

  @override
  _NewProductListState createState() => _NewProductListState();
}

class _NewProductListState extends State<NewProductList> {
  late NewProductListCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = NewProductListCubit();

    cubit.effectStream.listen((effect) {
      if (effect is ChangeFavoriteFailed) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
            snackBarFailureText: 'Failed to change favorite state.'));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<NewProductListCubit, NewProductListState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: state.isLoading
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      NewProductListGrid(
                        bigBlockLeading: false,
                        allSellingProduct: state.allSellingProduct,
                      ),
                      NewProductListGrid(
                        bigBlockLeading: true,
                        allSellingProduct: state.allSellingProduct,
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
