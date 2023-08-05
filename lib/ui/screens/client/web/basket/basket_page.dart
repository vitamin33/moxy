import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/basket/basket_cubit.dart';
import 'package:moxy/domain/client/basket/basket_state.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class BasketPage extends StatelessWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BasketCubit>(
      create: (BuildContext context) => BasketCubit(),
      child: BlocBuilder<BasketCubit, BasketState>(
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height,
            color: AppTheme.pink,
            child: Text('Basket'),
          );
        },
      ),
    );
  }
}
