// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:moxy/data/repositories/basket_repository.dart';
import 'package:moxy/services/get_it.dart';
import 'basket_state.dart';

class BasketCubit extends Cubit<BasketState> {
  final BasketRepository repository = locate<BasketRepository>();

  BasketCubit() : super(BasketState.defaultState()) {
    repository.getBasket();
  }
}
