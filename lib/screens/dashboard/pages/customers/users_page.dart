import 'package:bloc_effects/bloc_effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/all_users/all_users_cubit.dart';
import '../../../../domain/all_users/all_users_state.dart';
import '../../../../domain/ui_effect.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AllUsersCubit>(
      create: (BuildContext context) => AllUsersCubit(),
      child: BlocEffectListener<AllUsersCubit, UiEffect, AllUsersState>(
        listener: (context, effect, state) {},
        child: BlocBuilder<AllUsersCubit, AllUsersState>(
            builder: (context, state) {
          return Scaffold(
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
                                  return Card(
                                    margin: const EdgeInsets.all(3.0),
                                    child: ListTile(
                                      title: Text(
                                          '${user.firstName} ${user.secondName}'),
                                      subtitle: Text(user.mobileNumber),
                                      trailing:
                                          const Icon(Icons.arrow_forward_ios),
                                    ),
                                  );
                                }),
                          ))
              ],
            ),
          );
        }),
      ),
    );
  }
}
