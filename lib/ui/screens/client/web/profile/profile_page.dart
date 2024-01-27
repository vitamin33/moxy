import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/domain/client/profile/profile_cubit.dart';
import 'package:moxy/domain/client/profile/profile_effects.dart';
import 'package:moxy/domain/client/profile/profile_state.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/services/navigation/splash/root_router_cubit.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/components/moxy_loader.dart';
import 'package:moxy/ui/components/snackbar_widgets.dart';
import 'package:moxy/ui/screens/client/web/profile/pages/profile_adress.dart';
import 'package:moxy/ui/screens/client/web/profile/pages/profile_contact_info.dart';
import 'package:moxy/ui/screens/client/web/profile/pages/profile_history_order.dart';
import 'package:moxy/ui/screens/components/footer.dart';
import 'package:moxy/ui/screens/components/promo_container.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import '../../../../../domain/admin/create_order/search_cities/search_cities_cubit.dart';
import '../../../../../domain/admin/create_order/search_warehouse/search_warehouse_cubit.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  String? extraPage;
  ProfilePage({super.key, this.extraPage});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

const double contentHeight = 400.0;

class _ProfilePageState extends State<ProfilePage> {
  late ProfileCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = ProfileCubit(extraPagePath: widget.extraPage);

    cubit.effectStream.listen((effect) {
      if (effect is ProfileApiRequestFailed) {
        ScaffoldMessenger.of(context).showSnackBar(
            snackBarWhenFailure(snackBarFailureText: effect.failureText));
      }
      if (effect is ProfileSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
            snackBarWhenSuccess(snackBarSuccessText: effect.successText));
      }
      if (effect is ProfileValidationFailed) {
        ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
            snackBarFailureText: 'Wrong input, please check fields.'));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(
          create: (BuildContext context) => cubit,
        ),
        BlocProvider<SearchCitiesCubit>(
          create: (BuildContext context) =>
              SearchCitiesCubit(selectedCity: cubit.state.profile.city),
        ),
        BlocProvider<SearchWarehouseCubit>(
          create: (BuildContext context) => SearchWarehouseCubit(
            selectedWarehouse: cubit.state.profile.warehouse,
          ),
        ),
      ],
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: AppTheme.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 600,
                      child: AnimatedSwitcher(
                        duration: const Duration(
                            milliseconds: 500), // Adjust the duration as needed
                        child: state.isLoading
                            ? const MoxyLoader(
                                iconSize: 40,
                              )
                            : ProfileTabPage(),
                      ),
                    ),
                    const PromoContainer(),
                    const Footer(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ProfileTabPage extends StatelessWidget {
  final List<String> tabTitles = [
    'Контактна Інформація',
    'Історія замовлень',
    'Адресна книга',
  ];
  final List<Widget> tabPages = const [
    ProfileContactInfo(),
    ProfileHistoryOrder(),
    ProfileAdress(),
  ];

  ProfileTabPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();
        final theme = AppTheme.of(context)!;
        final router = context.read<RootRouterCubit>();
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(
                height: contentHeight,
                child: Row(
                  children: [
                    // Drawer Menu
                    _drawerMenu(context, cubit, state, theme, router),
                    // Selected Tab Content
                    _selectedTabContent(cubit, state),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              AnimatedOpacity(
                opacity: state.showSaveButton ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: _buildSaveButton(cubit),
              ),
              const SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }

  Widget _selectedTabContent(ProfileCubit cubit, ProfileState state) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: contentHeight,
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: cubit.pageController,
                onPageChanged: (int page) {
                  cubit.onChangePage(page);
                },
                itemCount: tabPages.length,
                itemBuilder: (context, index) {
                  return tabPages[index % tabPages.length];
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerMenu(BuildContext context, ProfileCubit cubit,
      ProfileState state, AppTheme theme, RootRouterCubit router) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.cardPadding),
      child: SizedBox(
        width: 250,
        height: contentHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(tabTitles.length, (index) {
            return GestureDetector(
              onTap: () {
                if (cubit.pageController.hasClients) {
                  cubit.pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn,
                  );
                  updateNavigator(context, index);
                }
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: state.activePage == index
                      ? const Border(
                          right: BorderSide(
                            color: AppTheme.black,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        )
                      : const Border(
                          right: BorderSide(
                            color: AppTheme.greyLigth,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Text(
                  tabTitles[index],
                  style: theme.largeBoltText.copyWith(
                    color: state.activePage == index
                        ? AppTheme.pinkDark
                        : AppTheme.black,
                  ),
                ),
              ),
            );
          })
            ..add(
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: InkWell(
                    onTap: () {
                      cubit.signOut();
                      context.go(RouterProvider.loginPath());
                    },
                    child: Text('Вихід',
                        style: theme.largeSemiBoltText
                            .copyWith(color: AppTheme.gray)),
                  ),
                ),
              ),
            ),
        ),
      ),
    );
  }

  Widget _buildSaveButton(ProfileCubit cubit) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: CustomButton(
        title: 'Зберегти',
        onTap: () {
          if (cubit.validateFields()) {
            cubit.editProfile();
            cubit.editPassword();
          }
        },
        buttonWidth: 200,
      ),
    );
  }

  void updateNavigator(BuildContext context, int index) {
    String path;
    switch (index) {
      case 1:
        path = RouterProvider.profileOrdersPath();
        break;
      case 2:
        path = RouterProvider.profileAdressesPath();
        break;
      default:
        path = RouterProvider.profileInfoPath();
        break;
    }
    context.go(path);
  }
}
