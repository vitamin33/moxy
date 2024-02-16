// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:moxy/domain/admin/overview/products_stats_state.dart';
import 'package:moxy/domain/mappers/product_stats_mapper.dart';
import 'package:moxy/domain/models/product_stats.dart';
import 'package:moxy/utils/common.dart';
import '../../../data/repositories/overview_repository.dart';
import '../../../services/get_it.dart';

class ProductsStatsCubit extends Cubit<ProductsStatsState> {
  final ProductStats stats;
  final overviewRepository = locate<OverviewRepository>();
  final mapper = locate<ProductStatsMapper>();

  ProductsStatsCubit({required this.stats})
      : super(ProductsStatsState(
          isLoading: false,
          orderCountStats: stats.orderStats,
          profitStats: stats.profitStats,
        ));

  void getProductsStatistics({DateTime? fromDate, DateTime? toDate}) async {
    try {
      emit(state.copyWith(isLoading: false, animated: false));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to get Products Stats'));
      moxyPrint(e);
    }
  }
}
