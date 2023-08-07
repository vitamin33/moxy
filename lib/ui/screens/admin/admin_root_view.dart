import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/admin/dashboard/dashboard_cubit.dart';
import 'package:moxy/domain/admin/filter_orders/filter_orders_cubit.dart';
import 'package:moxy/services/navigation/admin/admin_home_router_cubit.dart';
import 'package:moxy/services/navigation/admin/admin_home_router_delegate.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';
import '../../components/app_scaffold.dart';
import '../components/action_button.dart';
import '../components/flutter_expandable_fab.dart';
import '../components/navigation_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AdminRootView extends StatelessWidget {
  AdminRootView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (context) {
            return BlocBuilder<AdminHomeRouterCubit, AdminHomeRouterState>(
                builder: (context, state) => mobileWidget(context, state));
          },
        ),
      ],
    );
  }

  Widget mobileWidget(BuildContext context, AdminHomeRouterState state) {
    final arrIcons = _mapStateToActionIcon(state, context);

    return AppScaffold(
      appbar: AppBar(
        elevation: 0,
        actions: [
          arrIcons.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: LayoutBuilder(
                    builder: (BuildContext ctx, BoxConstraints constraints) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (final item in arrIcons) ...[
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: SizedBox(
                                width: 60,
                                height: 38,
                                child: InkWell(
                                  onTap: () {
                                    item.onPress(ctx);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: item.text != null
                                        ? Text(
                                            item.text!,
                                            textAlign: TextAlign.center,
                                            textDirection: TextDirection.rtl,
                                            style: const TextStyle(
                                              color: AppTheme.pinkDark,
                                              fontSize: 14,
                                            ),
                                          )
                                        : SvgPicture.asset(item.icon),
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ],
                      );
                    },
                  ),
                )
              : Container()
        ],
        backgroundColor: state.runtimeType == EditOrderPageState ||
                state.runtimeType == FilterOrderPageState
            ? AppTheme.white
            : AppTheme.pink,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            _mapStateToTitleText(context, state),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            if (state.runtimeType == OrderProductListPageState) {
              bool fromEdit = (state as OrderProductListPageState).isFromEdit;
              return IconButton(
                  onPressed: () {
                    if (fromEdit) {
                      context.read<AdminHomeRouterCubit>().navigateTo(
                            const EditOrderPageState(),
                          );
                    } else {
                      context.read<AdminHomeRouterCubit>().navigateTo(
                            const CreateOrderPageState(),
                          );
                    }
                  },
                  icon: SvgPicture.asset(IconPath.backArrow));
            } else if (state.runtimeType == EditOrderPageState) {
              return IconButton(
                  onPressed: () {
                    context.read<AdminHomeRouterCubit>().navigateTo(
                          const OrdersPageState(),
                        );
                  },
                  icon: SvgPicture.asset(IconPath.backArrow));
            } else if (state.runtimeType == FilterOrderPageState) {
              return IconButton(
                  onPressed: () {
                    context.read<AdminHomeRouterCubit>().navigateTo(
                          const OrdersPageState(),
                        );
                  },
                  icon: SvgPicture.asset(IconPath.backArrow));
            } else {
              return IconButton(
                icon: SvgPicture.asset(IconPath.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: 'Open side bar',
              );
            }
          },
        ),
      ),
      drawer: const DashboardDrawer(),
      floatingActionButton: _buildFabWidget(context, state),
      body: _routers,
    );
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Widget get _routers =>
      BlocBuilder<AdminHomeRouterCubit, AdminHomeRouterState>(
        builder: (context, state) => Router(
          routerDelegate: AdminHomeRouterDelegate(
            navigatorKey,
            context.read<AdminHomeRouterCubit>(),
          ),
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      );

  String _mapStateToTitleText(
      BuildContext context, AdminHomeRouterState state) {
    switch (state.runtimeType) {
      case OverviewPageState:
        return AppLocalizations.of(context)!.overview;
      case ProductsPageState:
        return AppLocalizations.of(context)!.products;
      case UsersPageState:
        return AppLocalizations.of(context)!.customers;
      case OrdersPageState:
        return AppLocalizations.of(context)!.orders;
      case CreateProductPageState:
        final createProductState = state as CreateProductPageState;
        if (createProductState.isEditMode ?? false) {
          return AppLocalizations.of(context)!.editProduct;
        } else {
          return AppLocalizations.of(context)!.createProduct;
        }
      case CreateOrderPageState:
        return AppLocalizations.of(context)!.createOrder;
      case EditOrderPageState:
        return AppLocalizations.of(context)!.editOrder;
      case FilterOrderPageState:
        return AppLocalizations.of(context)!.filter;
      case OrderProductListPageState:
        return AppLocalizations.of(context)!.orderProductList;
      case CreateUserPageState:
        return AppLocalizations.of(context)!.createUser;
      case TransactionsPageState:
        return 'Products';
      case FeedbacksPageState:
        return AppLocalizations.of(context)!.feedbacks;
    }
    return AppLocalizations.of(context)!.overview;
  }

  List<AppBarIcon> _mapStateToActionIcon(
      AdminHomeRouterState state, BuildContext context) {
    switch (state.runtimeType) {
      case OverviewPageState:
        return [
          AppBarIcon(
              icon: IconPath.dataRange,
              onPress: (ctx) {
                ctx.read<DashboardCubit>().selectDate(ctx);
              }),
        ];
      case ProductsPageState:
        return [
          AppBarIcon(
              icon: IconPath.filter,
              onPress: (ctx) {
                moxyPrint('filter');
              })
        ];
      case UsersPageState:
        return [];
      case OrdersPageState:
        return [
          AppBarIcon(
              icon: IconPath.filter,
              onPress: (ctx) {
                ctx.read<AdminHomeRouterCubit>().navigateTo(
                      const FilterOrderPageState(),
                    );
              })
        ];
      case CreateProductPageState:
        return [];
      case FilterOrderPageState:
        return [
          AppBarIcon(
              icon: IconPath.bag,
              text: AppLocalizations.of(context)!.reset,
              onPress: (ctx) {
                ctx.read<FilterOrdersCubit>().resetFilter();
              })
        ];
      case CreateOrderPageState:
        return [];
      case TransactionsPageState:
        return [];
      case FeedbacksPageState:
        return [];
    }
    return [];
  }

  Widget _buildFabWidget(BuildContext context, AdminHomeRouterState state) {
    switch (state.runtimeType) {
      case CreateProductPageState:
      case CreateUserPageState:
      case CreateOrderPageState:
      case EditOrderPageState:
      case OrderProductListPageState:
      case FilterOrderPageState:
        return Container();
    }
    return ExpandableFab(distance: 100, children: [
      ActionButton(
        icon: const Icon(
          Icons.add_business,
          color: Colors.white,
        ),
        onPressed: () {
          context
              .read<AdminHomeRouterCubit>()
              .navigateTo(const CreateOrderPageState());
        },
      ),
      ActionButton(
        icon: const Icon(
          Icons.people,
          color: Colors.white,
        ),
        onPressed: () {
          context
              .read<AdminHomeRouterCubit>()
              .navigateTo(const CreateUserPageState());
        },
      ),
      ActionButton(
        icon: const Icon(
          Icons.add_box,
          color: Colors.white,
        ),
        onPressed: () {
          context
              .read<AdminHomeRouterCubit>()
              .navigateTo(const CreateProductPageState());
        },
      ),
    ]);
  }
}

class AppBarIcon {
  final String icon;
  final String? text;
  final bool? loader;
  final Function(BuildContext ctx) onPress;
  const AppBarIcon(
      {required this.icon, this.text, this.loader, required this.onPress});
}
