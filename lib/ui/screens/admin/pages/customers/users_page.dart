import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/ui/theme/app_theme.dart';

import '../../../../components/snackbar_widgets.dart';
import '../../../../../domain/admin/all_users/all_users_cubit.dart';
import '../../../../../domain/admin/all_users/all_users_effects.dart';
import '../../../../../domain/admin/all_users/all_users_state.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;

    final AllUsersCubit cubit = AllUsersCubit();
    cubit.effectStream.listen((effect) {
      if (effect is UsersLoadingFailed) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
            snackBarFailureText:
                'Users loading failed: ${effect.failureText}'));
      }
    });

    return BlocProvider<AllUsersCubit>(
      create: (BuildContext context) => cubit,
      child:
          BlocBuilder<AllUsersCubit, AllUsersState>(builder: (context, state) {
        return Scaffold(
          backgroundColor: AppTheme.pink,
          body: Column(
            children: [
              Expanded(
                  child: state.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.allUsers.length,
                              itemBuilder: (BuildContext context, int index) {
                                final user = state.allUsers[index];
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: AppTheme.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: ListTile(
                                      title: Text(
                                        '${user.firstName} ${user.secondName}',
                                        style: theme.largeSemiBoltText,
                                      ),
                                      subtitle: Text(user.mobileNumber,
                                          style: theme.largeText),
                                      trailing:
                                          const Icon(Icons.arrow_forward_ios),
                                    ),
                                  ),
                                );
                              }),
                        ))
            ],
          ),
        );
      }),
    );
  }
}
