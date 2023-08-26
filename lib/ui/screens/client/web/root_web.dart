import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:moxy/services/navigation/web/web_home_router_cubit.dart';
import 'package:moxy/services/navigation/web/web_home_router_delegate.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class RootWebWidget extends StatefulWidget {
  const RootWebWidget({Key? key}) : super(key: key);

  @override
  _RootWebWidgetState createState() => _RootWebWidgetState();
}

class _RootWebWidgetState extends State<RootWebWidget>
    with SingleTickerProviderStateMixin {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  TabController? _tabController;
  ClientHomeRouterCubit? routerCubit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
      routerCubit?.tabControlPressed();
    }
  }

  @override
  Widget build(BuildContext context) {
    routerCubit = context.read<ClientHomeRouterCubit>();
    return DefaultTabController(
      length: 3,
      child: BlocBuilder<ClientHomeRouterCubit, ClientHomeRouterState>(
        builder: (context, state) {
          return Material(
            child: Scaffold(
              appBar: AppBar(
                  leadingWidth: 150,
                  leading: Padding(
                    padding: const EdgeInsets.all(15.0),
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
                          GestureDetector(
                            onTap: () {
                              routerCubit?.tabControlPressed();
                            },
                            child: SizedBox(
                              width: 350, // Adjust the width as needed
                              child: TabBar(
                                overlayColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (Set<MaterialState> states) {
                                    if (states
                                        .contains(MaterialState.hovered)) {
                                      return AppTheme.greyLigth;
                                    }
                                    return null;
                                  },
                                ),
                                controller: _tabController,
                                indicatorColor: AppTheme.black,
                                labelColor: AppTheme.black,
                                tabs: const [
                                  Tab(text: 'Новинки'),
                                  Tab(text: 'Сумки'),
                                  Tab(
                                    text: 'Аксесуари',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: _buildActions(context, state)),
              body: _buildRouter(context, _tabController!),
            ),
          );
        },
      ),
    );
  }

  Widget _buildRouter(BuildContext context, TabController controller) {
    return Router(
      routerDelegate: ClientHomeRouterDelegate(
          navigatorKey, context.read<ClientHomeRouterCubit>(), controller),
      backButtonDispatcher: RootBackButtonDispatcher(),
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

  List<Widget> _buildActions(
      BuildContext context, ClientHomeRouterState state) {
    return [
      _buildPaddedIconButton(
        IconPath.searchWeb,
        false,
        () {
          routerCubit?.searchPressed();
        },
      ),
      _buildPaddedIconButton(
        IconPath.favouritesWeb,
        state is FavouritesRouteState,
        () {
          routerCubit?.favouritesPressed();
        },
      ),
      _buildPaddedIconButton(
        IconPath.profileWeb,
        state is ProfileRouteState,
        () {
          routerCubit?.profilePressed();
        },
      ),
      _buildPaddedIconButton(
        IconPath.bagWeb,
        state is CheckoutRouteState,
        () {
          routerCubit?.basketPressed();
        },
      ),
    ];
  }
}
