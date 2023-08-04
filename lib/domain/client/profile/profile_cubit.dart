// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState.defaultState()) {}
}
