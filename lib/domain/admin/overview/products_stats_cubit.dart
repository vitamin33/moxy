// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:moxy/data/models/response/products_stats_response.dart';
import 'package:moxy/domain/admin/overview/products_stats_state.dart';
import 'package:moxy/domain/models/ads_report.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';
import '../../../data/repositories/overview_repository.dart';
import '../../../services/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductsStatsCubit extends Cubit<ProductsStatsState> {
  final overviewRepository = locate<OverviewRepository>();

  ProductsStatsCubit() : super(ProductsStatsState.defaultState()) {
    getProductsStatistics(
        fromDate: state.selectedDate?.start, toDate: state.selectedDate?.end);
  }

  void getProductsStatistics({DateTime? fromDate, DateTime? toDate}) async {
    try {
      emit(state.copyWith(isLoading: true, animated: false));
      final result =
          await overviewRepository.getProductsStatistics(fromDate, toDate);
      result.when((success) {
        final currentReport = NetworkProductsStats.fromResponse(success.currentAdsReport);
        emit(state.copyWith(
          saleFromTimeFrame: success.totalSaleValueByTimeFrame,
          ordersFromTimeFrame: success.ordersCountByTimeFrame,
          isLoading: false,
          animated: true,
        ));
      }, (error) {
        emit(state.copyWith(
            isLoading: false, errorMessage: 'Failed to get Products Stats'));
      });
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, errorMessage: 'Failed to get Products Stats'));
      moxyPrint(e);
    }
  }

  Future<void> selectDate(context) async {
    // emit(state.copyWith(animated: false));
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      initialDateRange: state.selectedDate,
      currentDate: DateTime.now(),
      saveText: AppLocalizations.of(context)!.confirm,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.pinkDark,
              onPrimary: AppTheme.white,
              onSurface: AppTheme.greyDark,
            ),
            dialogBackgroundColor: AppTheme.darkPink,
          ),
          child: child!,
        );
      },
    );
    if (result != null) {
      emit(state.copyWith(
        selectedDate: result,
        animated: true,
      ));
      getProductsStatistics(
        fromDate: result.start,
        toDate: result.end,
      );
    }
  }
}
