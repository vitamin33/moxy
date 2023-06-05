import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/create_order/create_order_cubit.dart';
import '../../../../../domain/create_order/create_order_state.dart';
import '../../../../../theme/app_theme.dart';

class Status extends StatelessWidget {
  const Status({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrderCubit, CreateOrderState>(
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              itemCount: 7,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RadioListTile(
                      activeColor: AppTheme.black,
                      tileColor: AppTheme.white,
                      groupValue: true,
                      value: true,
                      onChanged: (onChanged) {}),
                );
              }),
        );
      },
    );
  }
}
