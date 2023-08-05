import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/home/home_cubit.dart';
import 'package:moxy/domain/client/home/home_state.dart';

class HomePage extends StatelessWidget {
  late TabController _tabController;
  HomePage({required tabController, Key? key}) : super(key: key) {
    _tabController = tabController;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (BuildContext context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return TabBarView(
            controller: _tabController,
            children: const [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_boat_filled),
            ],
          );
        },
      ),
    );
  }
}
