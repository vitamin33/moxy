import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/navigation/home_router_cubit.dart';

import '../../../constant/menu.dart';
import '../../../theme/app_theme.dart';

class NavigationBarCard extends StatefulWidget {
  const NavigationBarCard({
    Key? key,
    required this.menu,
  }) : super(key: key);
  final Menu menu;

  @override
  State<NavigationBarCard> createState() => _NavigationBarCardState();
}

class _NavigationBarCardState extends State<NavigationBarCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    final title = widget.menu.title;
    final initialRoute = widget.menu.route;
    final icon = widget.menu.icon;
    final subItems = widget.menu.subRoutes;

    return BlocBuilder<HomeRouterCubit, HomeRouterState>(
      builder: (context, state) {
        final isTapped = initialRoute == state;

        if (subItems.isNotEmpty) {
          return NavigationBarCardList(menu: widget.menu, isTapped: isTapped);
        }

        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.elementSpacing,
              vertical: AppTheme.elementSpacing * 0.5),
          child: InkWell(
            onHover: (v) {
              setState(() {
                isHover = v;
              });
            },
            hoverColor: Theme.of(context).hoverColor,
            focusColor: Theme.of(context).focusColor,
            onTap: () {
              context.read<HomeRouterCubit>().navigateTo(initialRoute);
            },
            child: Container(
              padding: const EdgeInsets.all(AppTheme.elementSpacing),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(),
                    child: Row(
                      children: [
                        Icon(icon,
                            color: isTapped
                                ? AppTheme.primaryColor
                                : AppTheme.onPrimaryContainerColor),
                        const SizedBox(width: AppTheme.elementSpacing),
                        Text(
                          title,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    color: isTapped
                                        ? AppTheme.primaryColor
                                        : AppTheme.onPrimaryContainerColor,
                                    fontWeight: isTapped
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class NavigationBarCardList extends StatelessWidget {
  const NavigationBarCardList(
      {Key? key, required this.menu, required, required this.isTapped})
      : super(key: key);

  final Menu menu;
  final bool isTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.elementSpacing),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ListTileTheme(
          dense: true,
          horizontalTitleGap: AppTheme.elementSpacing * 1.5,
          minLeadingWidth: 10,
          child: ExpansionTile(
            backgroundColor: Theme.of(context).canvasColor,
            tilePadding: const EdgeInsets.symmetric(
              horizontal: AppTheme.elementSpacing,
              vertical: AppTheme.elementSpacing * 0.25,
            ),
            childrenPadding:
                const EdgeInsets.only(left: AppTheme.elementSpacing),
            iconColor: Theme.of(context).iconTheme.color,
            leading: Icon(menu.icon,
                color: isTapped
                    ? AppTheme.primaryColor
                    : AppTheme.onPrimaryContainerColor),
            title: Text(
              menu.title,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: isTapped
                        ? AppTheme.primaryColor
                        : AppTheme.onPrimaryContainerColor,
                    fontWeight: isTapped ? FontWeight.w700 : FontWeight.w500,
                  ),
            ),
            children: List.generate(
              menu.subRoutes.length,
              (index) {
                final menu1 = menu.subRoutes[index];
                return NavigationBarCard(menu: menu1);
              },
            ),
          ),
        ),
      ),
    );
  }
}
