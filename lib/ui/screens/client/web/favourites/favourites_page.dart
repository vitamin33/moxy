import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/favourites/favourites_cubit.dart';
import 'package:moxy/domain/client/favourites/favourites_state.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavouritesCubit>(
      create: (BuildContext context) => FavouritesCubit(),
      child: BlocBuilder<FavouritesCubit, FavouritesState>(
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height,
            color: AppTheme.pink,
            child: Text('Favourites'),
          );
        },
      ),
    );
  }
}
