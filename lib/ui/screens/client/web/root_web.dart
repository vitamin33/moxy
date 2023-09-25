import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/client/basket/basket_cubit.dart';
import 'package:moxy/domain/client/basket/basket_state.dart';
import 'package:moxy/services/navigation/web/client_home_info_parser.dart';
import 'package:moxy/services/navigation/web/client_home_router_cubit.dart';
import 'package:moxy/services/navigation/web/client_home_router_delegate.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/ui/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class RootWebWidget extends StatefulWidget {
  final ClientHomeRouterCubit routerCubit;
  const RootWebWidget(this.routerCubit, {Key? key}) : super(key: key);

  @override
  _RootWebWidgetState createState() => _RootWebWidgetState();
}

class _RootWebWidgetState extends State<RootWebWidget>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    final state = widget.routerCubit.state;
    int initialIndex = 0;
    if (state.runtimeType == HomeRoute) {
      initialIndex = (state as HomeRoute).tabIndex ?? 0;
    }
    _tabController =
        TabController(length: 3, vsync: this, initialIndex: initialIndex);
    _tabController?.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController?.removeListener(_handleTabSelection);
    _tabController?.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController?.indexIsChanging == true) {
      int index = _tabController?.index ?? 0;
      widget.routerCubit.tabControlSelected(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: BlocBuilder<ClientHomeRouterCubit, ClientHomeRoute>(
        builder: (context, route) {
          return Material(
            child: Scaffold(
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
                          _buildTabsWidget(),
                        ],
                      ),
                    ),
                  ),
                  actions: _buildActions(context, route)),
              body: _buildRouter(context, _tabController!),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRouter(BuildContext context, TabController controller) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp.router(
          routerDelegate: ClientHomeRouterDelegate(
              navigatorKey, context.read<ClientHomeRouterCubit>(), controller),
          backButtonDispatcher: RootBackButtonDispatcher(),
          routeInformationParser: ClientHomeRouteInfoParser(),
          theme: themeProvider.themeData.theme,
          darkTheme: themeProvider.themeData.darkTheme,
          debugShowCheckedModeBanner: false,
        );
      },
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
          child: Container(
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

  List<Widget> _buildActions(BuildContext context, ClientHomeRoute route) {
    return [
      _buildPaddedIconButton(
        IconPath.searchWeb,
        false,
        () {
          widget.routerCubit.searchPressed();
        },
      ),
      _buildPaddedIconButton(
        IconPath.favouritesWeb,
        route is FavouritesRoute,
        () {
          widget.routerCubit.favouritesPressed();
        },
      ),
      _buildPaddedIconButton(
        IconPath.profileWeb,
        route is ProfileRoute,
        () {
          widget.routerCubit.profilePressed();
        },
      ),
      _buildBasketIconButton(
        IconPath.bagWeb,
        () {
          widget.routerCubit.basketPressed(context);
        },
      )
    ];
  }

  Widget _buildTabsWidget() {
    int controllerIndex = _tabController?.index ?? 0;
    return SizedBox(
      width: 350, // Adjust the width as needed
      child: TabBar(
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return AppTheme.greyLigth;
            }
            return null;
          },
        ),
        controller: _tabController,
        indicatorColor: AppTheme.black,
        labelColor: AppTheme.black,
        tabs: [
          Listener(
            onPointerDown: (_) {
              widget.routerCubit.tabControlTouched(
                  controllerIndex: controllerIndex, newIndex: 0);
            },
            child: const Tab(text: 'Новинки'),
          ),
          Listener(
            onPointerDown: (_) {
              widget.routerCubit.tabControlTouched(
                  controllerIndex: controllerIndex, newIndex: 1);
            },
            child: const Tab(text: 'Сумки'),
          ),
          Listener(
            onPointerDown: (_) {
              widget.routerCubit.tabControlTouched(
                  controllerIndex: controllerIndex, newIndex: 2);
            },
            child: const Tab(
              text: 'Аксесуари',
            ),
          ),
        ],
      ),
    );
  }
}
