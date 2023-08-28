import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/services/navigation/admin/admin_home_router_cubit.dart';
import 'package:moxy/services/navigation/web/client_home_router_cubit.dart';
import 'package:moxy/ui/screens/client/web/root_web.dart';

import 'mobile/root_mobile.dart';

class RootView extends StatelessWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (context) {
            return BlocBuilder<AdminHomeRouterCubit, AdminHomeRouterState>(
                builder: (context, state) {
              if (kIsWeb) {
                ClientHomeRouterCubit cubit =
                    context.read<ClientHomeRouterCubit>();
                return RootWebWidget(cubit);
              } else {
                return const RootMobileWidget();
              }
            });
          },
        ),
      ],
    );
  }
}
