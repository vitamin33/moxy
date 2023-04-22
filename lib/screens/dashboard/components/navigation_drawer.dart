import 'package:flutter/material.dart';
import 'package:moxy/constant/route_name.dart';
import 'package:moxy/domain/auth/login_cubit.dart';
import 'package:provider/provider.dart';
import '../../../constant/image_path.dart';
import '../../../constant/menu.dart';
import '../../../services/navigation_service.dart';
import '../../../theme/app_theme.dart';
import 'navigation_card.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return ClipRRect(
      child: Container(
        width: AppTheme.drawerWidth,
        height: AppTheme.size(context).height,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
        child: Column(
          children: [
            const SizedBox(height: AppTheme.elementSpacing * 0.85),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    navigatePushReplaceName(overview);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.cardPadding),
                    child: Image.asset(ImagePath.logo, height: 35),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppTheme.elementSpacing * 0.85),
            Divider(
                color: Theme.of(context).dividerColor,
                height: 0,
                thickness: 0.1),
            const SizedBox(height: AppTheme.elementSpacing),
            Expanded(
              child: ListView.builder(
                itemCount: menus.length,
                itemBuilder: (_, index) {
                  final menu = menus[index];
                  return NavigationBarCard(menu: menu);
                },
              ),
            ),
            Divider(
                color: Theme.of(context).dividerColor,
                height: 0,
                thickness: 0.1),
            const SizedBox(height: AppTheme.cardPadding * 0.5),
            InkWell(
              onTap: () => {
                cubit.signOut(),
                navigatePushReplaceName(authPath),
                Scaffold.of(context).closeDrawer()
              },
              focusColor: AppTheme.primaryColor,
              highlightColor: AppTheme.primaryColor,
              splashColor: AppTheme.primaryColor,
              child: Text(
                'Logout',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: AppTheme.elementSpacing * 3),
          ],
        ),
      ),
    );
  }
}
