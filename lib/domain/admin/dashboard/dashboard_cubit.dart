// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moxy/data/repositories/auth_repository.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import '../../../services/get_it.dart';
import '../../../services/navigation_service.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final authRepository = locate<AuthRepository>();
  final navigationService = locate<NavigationService>();

  DashboardCubit() : super(DashboardState.defaultDashboardState());

  Future<void> selectDate(context) async {
    final DateTimeRange? result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      currentDate: DateTime.now(),
      saveText: 'Confirm',
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
      emit(state.copyWith(selectedDate: result));
      String firstDate = DateFormat('dd MM yyyy')
          .format(DateTime.parse(result.start.toString()));
      String lastDate = DateFormat('dd MM yyyy')
          .format(DateTime.parse(result.end.toString()));
    }
  }
}
