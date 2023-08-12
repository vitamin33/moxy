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
    _tabController = TabController(length: 4, vsync: this);
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
      length: 4,
      child: BlocBuilder<ClientHomeRouterCubit, ClientHomeRouterState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppTheme.white,
              elevation: 8.0,
              titleSpacing: 0.0,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 5),
                  SvgPicture.asset(
                    IconPath.moxyLogoWeb,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      routerCubit?.tabControlPressed();
                    },
                    child: SizedBox(
                      width: 400, // Adjust the width as needed
                      child: SegmentedTabControl(
                        controller: _tabController,
                        backgroundColor: AppTheme.white,
                        tabPadding: const EdgeInsets.all(10.0),
                        radius: const Radius.circular(15.0),
                        indicatorColor: AppTheme.pinkAvarage,
                        tabTextColor: AppTheme.textColor,
                        selectedTabTextColor: AppTheme.white,
                        splashColor: AppTheme.pink,
                        tabs: const [
                          SegmentTab(label: 'Новинки'),
                          SegmentTab(label: 'Сумки'),
                          SegmentTab(label: 'Одяг'),
                          SegmentTab(label: 'Шапки'),
                        ],
                      ),
                    ),
                  ),
                  _buildActions(context, state),
                ],
              ),
            ),
            body: _buildRouter(context, _tabController!),
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

  Widget _buildActions(BuildContext context, ClientHomeRouterState state) {
    return Row(
      children: [
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
          state is BasketRouteState,
          () {
            routerCubit?.basketPressed();
          },
        ),
      ],
    );
  }
}
