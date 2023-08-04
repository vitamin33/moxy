// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'basket_state.dart';

class BasketCubit extends Cubit<BasketState> {
  BasketCubit() : super(BasketState.defaultState()) {}
}
