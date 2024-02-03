import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/auth/profile_scope_cubit.dart';
import 'package:moxy/domain/auth/profile_scope_state.dart';
import 'package:moxy/domain/models/profile.dart';

class ProfileScope extends StatefulWidget {
  final Widget child;
  const ProfileScope({Key? key, required this.child}) : super(key: key);

  @override
  State<ProfileScope> createState() => _ProfileScopeState();

  static Profile? of(BuildContext context) {
    final profileState = context.watch<ProfileScopeCubit>().state;
    return profileState.profile;
  }
}

class _ProfileScopeState extends State<ProfileScope> {
  late ProfileScopeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = ProfileScopeCubit();
    _cubit.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileScopeCubit>(
      create: (_) => _cubit,
      child: BlocBuilder<ProfileScopeCubit, ProfileScopeState>(
        builder: (context, state) {
          // Optionally handle loading and error states
          return _InheritedProfile(
            profile: state.profile,
            child: widget.child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}

class _InheritedProfile extends InheritedWidget {
  final Profile? profile;

  const _InheritedProfile({
    super.key,
    required this.profile,
    required super.child,
  });

  @override
  bool updateShouldNotify(_InheritedProfile oldWidget) {
    return profile != oldWidget.profile;
  }
}
