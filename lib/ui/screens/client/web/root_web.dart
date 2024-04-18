import 'package:add_to_cart_animation/add_to_cart_animation.dart';
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
import 'package:moxy/utils/responsive_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RootWebWidget extends HookWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// The navigation shell and container for the branch Navigators.
  final StatefulNavigationShell navigationShell;

  /// The children (branch Navigators) to display in a custom container
  final List<Widget> children;

  RootWebWidget({
    super.key,
    required this.navigationShell,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;
    final cubit = context.read<RootRouterCubit>();
    int routeIndex = navigationShell.currentIndex;
    int initialIndex = routeIndex >= 3 ? 0 : routeIndex;
    final isMobile = ResponsiveUtil.isMobile(context);

    // ignore: unused_local_variable
    final tabController =
        useTabController(initialLength: 3, initialIndex: initialIndex);
    return AddToCartAnimation(
      cartKey: cubit.cartKey,
      height: 30,
      width: 30,
      opacity: 0.85,
      dragAnimation: const DragToCartAnimationOptions(
        rotation: true,
      ),
      jumpAnimation: const JumpAnimationOptions(),
      createAddToCartAnimation: (runAnimation) {
        cubit.runAddToCartAnimation = runAnimation;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: buildAppBar(context, theme, tabController, isMobile),
        drawer: isMobile ? _buildMobileDrawer(context) : null,
        body: AnimatedBranchContainer(
          currentIndex: navigationShell.currentIndex,
          children: children,
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, AppTheme theme,
      TabController tabController, bool isMobile) {
    return AppBar(
      shape: const Border(
          bottom: BorderSide(
        color: Color(0xFFF0F1F5),
      )),
      leadingWidth: isMobile ? 56 : 150,
      leading: isMobile ? _buildHamburgerButton(context) : _buildLogo(),
      backgroundColor: AppTheme.white,
      elevation: 0.0,
      title: isMobile
          ? SvgPicture.asset(IconPath.moxyLogoWeb, width: 60)
          : _buildTabsWidget(context, tabController),
      centerTitle: true,
      actions: isMobile
          ? _buildMobileActions(context, theme)
          : _buildActions(context, theme),
    );
  }

  Widget _buildHamburgerButton(BuildContext context) {
    return Row(children: [
      IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        },
      ),
    ]);
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
      String iconData, Function onPressed, AppTheme theme) {
    const double finalSize = 46.0;

    return BlocBuilder<BasketCubit, BasketState>(
      builder: (context, state) {
        final cubit = context.read<BasketCubit>();
        final rootCubit = context.read<RootRouterCubit>();

        return AddToCartIcon(
          key: rootCubit.cartKey,
          badgeOptions: const BadgeOptions(
            active: false,
          ),
          icon: Stack(
            children: [
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
                  top: 6,
                  right: 6,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: AppTheme.red,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        cubit.getBasketCount(),
                        style: theme.xSmallText.copyWith(color: AppTheme.white),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _buildActions(BuildContext context, AppTheme theme) {
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
        IconPath.favoritesWeb,
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
      _buildBasketIconButton(IconPath.bagWeb, () {
        SideSheet.right(
            body: const BasketPage(),
            context: context,
            barrierColor: Colors.grey.withOpacity(0.5));
      }, theme)
    ];
  }

  Widget _buildTabsWidget(BuildContext context, TabController controller) {
    final theme = AppTheme.of(context)!;

    return SizedBox(
      width: 430,
      child: TabBar(
        labelStyle: theme.mediumBoltText,
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
        tabs: [
          Tab(text: AppLocalizations.of(context)!.newCategory.toUpperCase()),
          Tab(text: AppLocalizations.of(context)!.bagsCategory.toUpperCase()),
          Tab(
              text: AppLocalizations.of(context)!
                  .accessoriesCategory
                  .toUpperCase()),
        ],
      ),
    );
  }

  List<Widget> _buildMobileActions(BuildContext context, AppTheme theme) {
    final currentRoute =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();
    bool searchSelected = currentRoute == RouterProvider.searchPath();
    return [
      _buildPaddedIconButton(
        IconPath.searchWeb,
        searchSelected,
        () {
          navigateToBranch(context, searchIndex);
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
        theme,
      ),
    ];
  }

  Drawer _buildMobileDrawer(BuildContext context) {
    final theme = AppTheme.of(context)!;

    return Drawer(
      child: Column(
        children: [
          Expanded(flex: 1, child: _buildLogo()),
          Expanded(
            flex: 10,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                // Add drawer header if needed
                ListTile(
                  leading: SvgPicture.asset(
                    IconPath.newIcon,
                    height: 26,
                    width: 24,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.newCategory.toUpperCase(),
                    style: theme.largeSemiBoltText,
                  ),
                  onTap: () {
                    navigateToBranch(context, 0);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    IconPath.bagWeb,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.bagsCategory.toUpperCase(),
                    style: theme.largeSemiBoltText,
                  ),
                  onTap: () {
                    navigateToBranch(context, 1);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(IconPath.accessoriesIcon),
                  title: Text(
                    AppLocalizations.of(context)!
                        .accessoriesCategory
                        .toUpperCase(),
                    style: theme.largeSemiBoltText,
                  ),
                  onTap: () {
                    navigateToBranch(context, 2);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    IconPath.favoritesWeb,
                    height: 26,
                    width: 24,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.favorites.toUpperCase(),
                    style: theme.largeSemiBoltText,
                  ),
                  onTap: () {
                    navigateToBranch(context, 4);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    IconPath.profileWeb,
                    height: 26,
                    width: 24,
                  ),
                  title: Text(
                    AppLocalizations.of(context)!.profile.toUpperCase(),
                    style: theme.largeSemiBoltText,
                  ),
                  onTap: () {
                    navigateToBranch(context, 5);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
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
        routeName = Routes.brandNew;
      case 1:
        routeName = Routes.homeBags;
      case 2:
        routeName = Routes.accessories;
      case 3:
        routeName = Routes.search;
      case 4:
        routeName = Routes.favorites;
      case 5:
        routeName = Routes.homeBags;
      case 6:
        routeName = Routes.checkout;
      default:
        routeName = Routes.brandNew;
    }
    return NavigationEvent(routeName: routeName);
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SvgPicture.asset(IconPath.moxyLogoWeb, width: 60),
    );
  }
}
