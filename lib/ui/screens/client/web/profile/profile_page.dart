import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/client/profile/profile_cubit.dart';
import 'package:moxy/domain/client/profile/profile_effects.dart';
import 'package:moxy/domain/client/profile/profile_state.dart';
import 'package:moxy/ui/components/custom_button.dart';
import 'package:moxy/ui/components/moxy_loader.dart';
import 'package:moxy/ui/components/snackbar_widgets.dart';
import 'package:moxy/ui/screens/client/web/profile/pages/profile_adress.dart';
import 'package:moxy/ui/screens/client/web/profile/pages/profile_contact_info.dart';
import 'package:moxy/ui/screens/client/web/profile/pages/profile_history_order.dart';
import 'package:moxy/ui/screens/components/footer_web.dart';
import 'package:moxy/ui/screens/components/promo_container.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import '../../../../../domain/admin/create_order/search_cities/search_cities_cubit.dart';
import '../../../../../domain/admin/create_order/search_warehouse/search_warehouse_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(
          create: (BuildContext context) => ProfileCubit(),
        ),
        BlocProvider<SearchCitiesCubit>(
          create: (BuildContext context) => SearchCitiesCubit(),
        ),
        BlocProvider<SearchWarehouseCubit>(
          create: (BuildContext context) => SearchWarehouseCubit(),
        ),
      ],
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final ProfileCubit cubit = context.read<ProfileCubit>();
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
          return Scaffold(
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                color: AppTheme.white,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    state.isLoading
                        ? const MoxyLoader(
                            iconSize: 40,
                          )
                        : ProfileTabPage(),
                    const PromoContainer(),
                    const Footer()
                  ],
                ))),
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

  ProfileTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            children: [
              // Drawer Menu
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: AppTheme.cardPadding),
                child: SizedBox(
                  width: 250,
                  height: 600,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(tabTitles.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          if (cubit.pageController.hasClients) {
                            cubit.pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
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
                                        style: BorderStyle.solid),
                                  )
                                : const Border(
                                    right: BorderSide(
                                        color: AppTheme.greyLigth,
                                        width: 2,
                                        style: BorderStyle.solid)),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 25),
                          child: Text(
                            tabTitles[index],
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: state.activePage == index
                                    ? AppTheme.pinkDark
                                    : AppTheme.black),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              // Selected Tab Content
              Expanded(
                child: SizedBox(
                  height: 600,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                            height: 350,
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
                        const SizedBox(height: 30),
                        Padding(
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
                        )
                      ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
