// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:moxy/domain/admin/overview/products_stats_state.dart';
import 'package:moxy/domain/mappers/product_stats_mapper.dart';
import 'package:moxy/utils/common.dart';
import '../../../data/repositories/overview_repository.dart';
import '../../../services/get_it.dart';

class ProductsStatsCubit extends Cubit<ProductsStatsState> {
  final DateTime? fromDate;
  final DateTime? toDate;
  final overviewRepository = locate<OverviewRepository>();
  final mapper = locate<ProductStatsMapper>();

  ProductsStatsCubit({required this.fromDate, required this.toDate})
      : super(ProductsStatsState.defaultState()) {
    getProductsStatistics(fromDate: fromDate, toDate: toDate);
  }

  void getProductsStatistics({DateTime? fromDate, DateTime? toDate}) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result =
          await overviewRepository.getProductsStatistics(fromDate, toDate);
      result.when((success) {
        final stats = mapper.mapToProductStats(success);
        emit(
          state.copyWith(
            isLoading: false,
            orderCountStats: stats.orderStats,
            profitStats: stats.profitStats,
          ),
        );
      },
          (error) => emit(state.copyWith(
              isLoading: false, errorMessage: 'Failed to get Products Stats')));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to get Products Stats'));
      moxyPrint(e);
    }
  }
}
