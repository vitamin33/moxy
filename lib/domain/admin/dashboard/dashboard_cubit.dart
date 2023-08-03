// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';
import '../../../data/repositories/overview_repository.dart';
import '../../../services/get_it.dart';
import '../../../services/navigation_service.dart';
import 'dashboard_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final overviewRepository = locate<OverviewRepository>();
  final navigationService = locate<NavigationService>();

  DashboardCubit() : super(DashboardState.defaultDashboardState()) {
    getDashboard(
        fromDate: state.selectedDate?.start, toDate: state.selectedDate?.end);
  }

  void getDashboard({DateTime? fromDate, DateTime? toDate}) async {
    try {
      emit(state.copyWith(isLoading: true, animated: false));
      final result = await overviewRepository.getOverview(fromDate, toDate);
      result.when((success) {
        emit(state.copyWith(
          totalSale: success.totalSaleValue,
          totalCost: success.totalCostValue,
          totalOrders: success.totalOrdersCount,
          previousTotalSaleValue: success.previousTotalSaleValue,
          previousTotalCostValue: success.previousTotalCostValue,
          previousTotalOrdersCount: success.previousTotalOrdersCount,
          saleValuePercentageChange: success.saleValuePercentageChange,
          costValuePercentageChange: success.costValuePercentageChange,
          ordersCountPercentageChange: success.ordersCountPercentageChange,
          saleFromTimeFrame: success.totalSaleValueByTimeFrame,
          costFromTimeFrame: success.totalCostValueByTimeFrame,
          ordersFromTimeFrame: success.ordersCountByTimeFrame,
          isLoading: false,
          animated: true,
        ));
      }, (error) {
        emit(state.copyWith(errorMessage: 'Failed GetDashboard'));
      });
    } catch (e) {
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
        animated: false,
      ));
      emit(state.copyWith(
        animated: true,
      ));
      getDashboard(
        fromDate: result.start,
        toDate: result.end,
      );
    }
  }

  bool changeLoading() {
    return state.isLoading;
  }
}
