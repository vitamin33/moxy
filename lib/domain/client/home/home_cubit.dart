// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import '../../../data/repositories/overview_repository.dart';
import '../../../services/get_it.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final overviewRepository = locate<OverviewRepository>();

  HomeCubit() : super(HomeState.defaultState()) {}
}
