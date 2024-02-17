import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/constants.dart';
import 'package:moxy/domain/admin/overview/products_stats_cubit.dart';
import 'package:moxy/domain/admin/overview/products_stats_state.dart';
import 'package:moxy/domain/models/product_stats.dart';
import 'package:moxy/ui/components/product_image.dart';

import '../../../../theme/app_theme.dart';

class ProductsStatsPage extends StatefulWidget {
  final ProductStats stats;
  const ProductsStatsPage({
    super.key,
    required this.stats,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProductsStatsPageState createState() => _ProductsStatsPageState();
}

class _ProductsStatsPageState extends State<ProductsStatsPage>
    with SingleTickerProviderStateMixin {
  late ProductsStatsCubit _cubit;
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _cubit = ProductsStatsCubit(stats: widget.stats);
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsStatsCubit>(
      create: (BuildContext context) => _cubit,
      child: BlocBuilder<ProductsStatsCubit, ProductsStatsState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                controller: _controller,
                tabs: const [
                  Tab(text: 'Count Stats'),
                  Tab(text: 'Profit Stats'),
                ],
              ),
            ),
            body: Material(
              color: AppTheme.pink,
              child: Stack(
                children: [
                  _buildLoadingIfNeeded(state),
                  TabBarView(
                    controller: _controller,
                    children: [
                      _buildCountStatsList(state),
                      _buildProfitStatsList(state),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCountStatsList(ProductsStatsState state) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: state.orderCountStats.length,
      itemBuilder: (BuildContext context, int index) {
        final item = state.orderCountStats[index];
        return _CountStatsItem(item: item);
      },
    );
  }

  Widget _buildProfitStatsList(ProductsStatsState state) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: state.profitStats.length,
      itemBuilder: (BuildContext context, int index) {
        final item = state.profitStats[index];
        return _ProfitStatsItem(item: item);
      },
    );
  }

  Widget _buildLoadingIfNeeded(ProductsStatsState state) {
    return state.isLoading
        ? const LinearProgressIndicator(
            color: AppTheme.pinkDark,
            backgroundColor: AppTheme.pink,
          )
        : Container();
  }
}

class _CountStatsItem extends StatelessWidget {
  final ProductOrderCountStat item;
  const _CountStatsItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.all(14.0),
        tileColor: AppTheme.white,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProductImage(product: item.product, size: 30),
            const SizedBox(width: 10),
            Text(item.product.name),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Text('${item.orderCount.toString()} $piece'),
              ),
              Text(
                '${item.percentageFromAllOrdersCount.toString()} $percent',
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfitStatsItem extends StatelessWidget {
  final ProductProfitStat item;
  const _ProfitStatsItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.all(14.0),
        tileColor: AppTheme.white,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProductImage(product: item.product, size: 30),
            const SizedBox(width: 10),
            Text(item.product.name),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Text('${item.profit.toString()}  $uah'),
              ),
              Text(
                '${item.percentageFromAllProfit.toString()} $percent',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
