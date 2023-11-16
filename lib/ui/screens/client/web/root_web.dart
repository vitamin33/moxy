import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/config/routes.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/client/basket/basket_cubit.dart';
import 'package:moxy/domain/client/basket/basket_state.dart';
import 'package:moxy/services/navigation/navigation_event.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/services/navigation/splash/root_router_cubit.dart';
import 'package:moxy/ui/components/sidesheet.dart';
import 'package:moxy/ui/screens/client/web/basket/basket_page.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/animated_branch_container.dart';
import 'package:provider/provider.dart';

class RootWebWidget extends HookWidget {
  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  /// The children (branch Navigators) to display in a custom container
  final List<Widget> children;

  const RootWebWidget({
    Key? key,
    required this.navigationShell,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int routeIndex = navigationShell.currentIndex;
    int initialIndex = routeIndex > 3 ? 0 : routeIndex;
    // ignore: unused_local_variable
    final tabController =
        useTabController(initialLength: 3, initialIndex: initialIndex);
    return Scaffold(
      appBar: AppBar(
          leadingWidth: 150,
          leading: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset(
              IconPath.moxyLogoWeb,
              width: 50,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppTheme.white,
          elevation: 8.0,
          title: SizedBox(
            width: 380,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildTabsWidget(context, tabController),
                ],
              ),
            ),
          ),
          actions: _buildActions(context)),
      body: AnimatedBranchContainer(
        currentIndex: navigationShell.currentIndex,
        children: children,
      ),
    );
  }

  Widget _buildPaddedIconButton(
    String iconData,
    bool selected,
    Function onPressed,
  ) {
    const double initialSize = 20.0;
    const double finalSize = 48.0;
    final double size = selected ? finalSize : initialSize;

    return Container(
      alignment: Alignment.center, // Center the icon in the container
      width: finalSize,
      height: finalSize,
      child: AnimatedContainer(
          alignment:
              Alignment.center, // Center the icon in the AnimatedContainer
          duration: const Duration(milliseconds: 200),
          width: size,
          height: size,
          decoration: selected
              ? BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.pinkDark.withOpacity(0.3),
                )
              : null,
          child: SizedBox(
            child: GestureDetector(
              onTap: () {
                onPressed.call();
              },
              child: SvgPicture.asset(
                iconData,
                color: selected ? AppTheme.white : null,
              ),
            ),
          )),
    );
  }

  Widget _buildBasketIconButton(
    String iconData,
    Function onPressed,
  ) {
    const double finalSize = 46.0;

    return BlocBuilder<BasketCubit, BasketState>(
      builder: (context, state) {
        final cubit = context.read<BasketCubit>();

        return Stack(children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              alignment: Alignment.center,
              width: finalSize,
              height: finalSize,
              child: GestureDetector(
                onTap: () {
                  onPressed.call();
                },
                child: SvgPicture.asset(
                  iconData,
                ),
              ),
            ),
          ),
          if (state.basket.basketItems.isNotEmpty)
            Positioned(
              top: 10,
              right: 10,
              child: CircleAvatar(
                radius: 8,
                backgroundColor: AppTheme.red,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    cubit.getBasketCount(),
                    style: const TextStyle(color: AppTheme.white, fontSize: 10),
                  ),
                ),
              ),
            ),
        ]);
      },
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    final currentRoute =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();
    bool profileSelected = currentRoute == RouterProvider.profileInfoPath() ||
        currentRoute == RouterProvider.profileOrdersPath() ||
        currentRoute == RouterProvider.profileAdressesPath();
    bool favoritesSelected = currentRoute == RouterProvider.favoritesPath();
    bool searchSelected = currentRoute == RouterProvider.searchPath();
    return [
      _buildPaddedIconButton(
        IconPath.searchWeb,
        searchSelected,
        () {
          navigateToBranch(context, searchIndex);
        },
      ),
      _buildPaddedIconButton(
        IconPath.favouritesWeb,
        favoritesSelected,
        () {
          navigateToBranch(context, favoritesIndex);
        },
      ),
      _buildPaddedIconButton(
        IconPath.profileWeb,
        profileSelected,
        () {
          navigateToBranch(context, profileIndex);
        },
      ),
      _buildBasketIconButton(
        IconPath.bagWeb,
        () {
          SideSheet.right(
              body: const BasketPage(),
              context: context,
              barrierColor: Colors.grey.withOpacity(0.5));
        },
      )
    ];
  }

  Widget _buildTabsWidget(BuildContext context, TabController controller) {
    return SizedBox(
      width: 350,
      child: TabBar(
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return AppTheme.greyLigth;
            }
            return null;
          },
        ),
        controller: controller,
        indicatorColor: AppTheme.black,
        labelColor: AppTheme.black,
        onTap: (int index) {
          navigateToBranch(context, index);
        },
        tabs: const [
          Tab(text: 'Новинки'),
          Tab(text: 'Сумки'),
          Tab(text: 'Аксесуари'),
        ],
      ),
    );
  }

  void navigateToBranch(BuildContext context, int index) {
    navigationShell.goBranch(index);
    final navCubit = context.read<RootRouterCubit>();
    navCubit.sendNavEvent(eventByIndex(index));
  }

  NavigationEvent eventByIndex(int index) {
    String routeName;
    switch (index) {
      case 0:
        routeName = Routes.newPath;
      case 1:
        routeName = Routes.homeBagsPath;
      case 2:
        routeName = Routes.accessoriesPath;
      case 3:
        routeName = Routes.searchPath;
      case 4:
        routeName = Routes.favoritesPath;
      case 5:
        routeName = Routes.homeBagsPath;
      case 6:
        routeName = Routes.checkoutPath;
      default:
        routeName = Routes.newPath;
    }
    return NavigationEvent(routeName: routeName);
  }
}
