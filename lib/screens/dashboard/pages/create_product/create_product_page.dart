import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/product_cubit.dart';
import 'package:moxy/domain/product_state.dart';
import 'package:moxy/screens/dashboard/pages/create_product/pages/branding.dart';
import 'package:moxy/screens/dashboard/pages/create_product/pages/details.dart';
import 'package:moxy/screens/dashboard/pages/create_product/pages/summary.dart';
import 'package:moxy/theme/app_theme.dart';
import '../../../../components/rounded_card.dart';

class CreateProductPage extends StatelessWidget {
  const CreateProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = const [
      ProductDetails(),
      Branding(),
      Summary(),
    ];
    return BlocBuilder<CreateProductCubit, ProductState>(
      builder: (context, state) {
        final cubit = context.read<CreateProductCubit>();
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(AppTheme.cardPadding),
                        child: SizedBox(
                            width: double.maxFinite,
                            height: 550,
                            child: RoundedCard(
                                padding: const EdgeInsets.all(0),
                                child: Column(children: [
                                  SizedBox(
                                      height: 50,
                                      child: Container(
                                        color: AppTheme.primaryContainerColor,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List<Widget>.generate(
                                              pages.length,
                                              (index) => Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: InkWell(
                                                        onTap: () {
                                                          cubit.pageController
                                                              .animateToPage(
                                                                  index,
                                                                  duration: const Duration(
                                                                      milliseconds:
                                                                          300),
                                                                  curve: Curves
                                                                      .easeIn);
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 6,
                                                          backgroundColor: state
                                                                      .activePage ==
                                                                  index
                                                              ? Colors.red
                                                              : AppTheme
                                                                  .secondaryColor,
                                                        )),
                                                  )),
                                        ),
                                      )),
                                  Expanded(
                                    child: PageView.builder(
                                      controller: cubit.pageController,
                                      onPageChanged: (int page) {
                                        cubit.onChangePage(page);
                                      },
                                      itemCount: pages.length,
                                      itemBuilder: (context, index) {
                                        return pages[index % pages.length];
                                      },
                                    ),
                                  )
                                ]))))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      child: const Text('Previus'),
                      onPressed: () {
                        cubit.moveToPreviustPage();
                      }),
                  TextButton(
                    child: Text(state.activePage != 2 ? 'Next' : 'Add'),
                    onPressed: () {
                      cubit.moveToNextPage();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
