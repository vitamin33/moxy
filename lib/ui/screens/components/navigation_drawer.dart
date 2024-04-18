import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/config/routes.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/auth/login/login_cubit.dart';
import 'package:provider/provider.dart';
import '../admin/menu.dart';
import '../../theme/app_theme.dart';
import 'navigation_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    final menus = getLocalizedMenus(context);

    return ClipRRect(
      child: Material(
        color: Theme.of(context).canvasColor,
        child: SizedBox(
          width: AppTheme.drawerWidth,
          height: AppTheme.size(context).height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70, left: 25, right: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          IconPath.moxylogo,
                          height: 30,
                          width: 60,
                        ),
                        IconButton(
                            onPressed: () {
                              Scaffold.of(context).closeDrawer();
                            },
                            icon: SvgPicture.asset(IconPath.closeDrawer)),
                      ],
                    ))
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.elementSpacing * 0.85),
              Divider(
                color: Theme.of(context).dividerColor,
                height: 1.0,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: menus.length,
                  itemBuilder: (_, index) {
                    final menu = menus[index];
                    return NavigationBarCard(menu: menu, showIcon: true);
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
                  context.go('/${Routes.login}'),
                  Scaffold.of(context).closeDrawer()
                },
                focusColor: AppTheme.darkPink,
                highlightColor: AppTheme.darkPink,
                splashColor: AppTheme.darkPink,
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.cardPadding),
                  child: Row(
                    children: [
                      SvgPicture.asset(IconPath.logout),
                      const SizedBox(width: AppTheme.elementSpacing),
                      Text(
                        AppLocalizations.of(context)!.logout,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(height: AppTheme.elementSpacing * 6),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
