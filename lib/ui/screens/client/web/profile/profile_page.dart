import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/profile/profile_cubit.dart';
import 'package:moxy/domain/client/profile/profile_state.dart';
import 'package:moxy/ui/screens/client/web/profile/pages/profile_adress.dart';
import 'package:moxy/ui/screens/client/web/profile/pages/profile_contact_info.dart';
import 'package:moxy/ui/screens/client/web/profile/pages/profile_history_order.dart';
import 'package:moxy/ui/screens/components/footer_web.dart';
import 'package:moxy/ui/screens/components/promo_container.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import '../../../../components/snackbar_widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (BuildContext context) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.errorMessage != '') {
            ScaffoldMessenger.of(context).showSnackBar(
                snackBarWhenFailure(snackBarFailureText: 'Failed'));
            context.read<ProfileCubit>().clearErrorState();
          }
        },
        builder: (context, state) {
          return Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: AppTheme.white,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  state.isLoading
                      ? const CircularProgressIndicator()
                      : ProfileTabPage(),
                  const PromoContainer(),
                  const Footer()
                ],
              )));
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
  final List<Widget> tabPages = [
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
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 600,
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
