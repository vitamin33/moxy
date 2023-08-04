import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/home/home_cubit.dart';
import 'package:moxy/domain/client/home/home_state.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height,
          color: AppTheme.pink,
          child: Text('Home'),
        );
      },
    );
  }
}
