import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/home/home_cubit.dart';
import 'package:moxy/domain/client/home/home_state.dart';
import 'package:moxy/ui/screens/components/footer_web.dart';
import 'package:moxy/ui/theme/app_theme.dart';

import '../../../components/filter_container.dart';
import '../../../components/product_list.dart';
import '../../../components/promo_container.dart';

@immutable
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
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              Scaffold(
                backgroundColor: AppTheme.white,
                body: SingleChildScrollView(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      FilterContainer(),
                      ProductList(),
                      PromoContainer(),
                      SizedBox(height: 30),
                      Footer(),
                    ],
                  ),
                )),
              ),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          );
        },
      ),
    );
  }
}
