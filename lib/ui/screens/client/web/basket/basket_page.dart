import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/profile/profile_cubit.dart';
import 'package:moxy/domain/client/profile/profile_state.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class BasketPage extends StatelessWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height,
          color: AppTheme.pink,
          child: Text('Basket'),
        );
      },
    );
  }
}
