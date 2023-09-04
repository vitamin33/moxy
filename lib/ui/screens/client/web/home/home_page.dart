import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/home/home_cubit.dart';
import 'package:moxy/domain/client/home/home_state.dart';
import 'package:moxy/ui/screens/client/web/home/pages/accessories_product_page.dart';
import 'package:moxy/ui/screens/client/web/home/pages/bags_product_page.dart';
import 'package:moxy/ui/screens/client/web/home/pages/new_product_page.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  late TabController _tabController;
  int tabIndex;
  HomePage(TabController tabController, this.tabIndex, {Key? key})
      : super(key: key) {
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
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              NewProductPage(),
              BagsProductPage(),
              AccessoriesProductPage(),
            ],
          );
        },
      ),
    );
  }
}
