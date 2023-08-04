// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'favourites_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit() : super(FavouritesState.defaultState()) {}
}
