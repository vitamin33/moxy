import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/components/app_scaffold.dart';
import 'package:moxy/components/textfield.dart';
import 'package:moxy/domain/product_cubit.dart';
import 'package:moxy/domain/product_state.dart';
import 'package:moxy/screens/dashboard/pages/create_product/pages/branding.dart';
import 'package:moxy/screens/dashboard/pages/create_product/pages/details.dart';
import 'package:moxy/screens/dashboard/pages/create_product/pages/summary.dart';
import 'package:moxy/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';
import 'package:provider/provider.dart';

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
          body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(AppTheme.cardPadding),
                  child: Container(
                    width: 400,
                    height: 550,
                    child: RoundedCard(
                        padding: const EdgeInsets.all(0),
                        child: Stack(
                          children: [
                            PageView.builder(
                              controller: cubit.pageController,
                              onPageChanged: (int page) {
                                cubit.onChangePage(page);
                              },
                              itemCount: pages.length,
                              itemBuilder: (context, index) {
                                return pages[index % pages.length];
                              },
                            ),
                            Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                height: 50,
                                child: Container(
                                  color: AppTheme.primaryColor,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List<Widget>.generate(
                                        pages.length,
                                        (index) => Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: InkWell(
                                                  onTap: () {
                                                    cubit.pageController
                                                        .animateToPage(index,
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        300),
                                                            curve:
                                                                Curves.easeIn);
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 8,
                                                    backgroundColor:
                                                        state.activePage ==
                                                                index
                                                            ? Colors.red
                                                            : AppTheme
                                                                .secondaryColor,
                                                  )),
                                            )),
                                  ),
                                ))
                          ],
                        )),
                  ))));
    });
  }
}

// class CreateProductView extends StatelessWidget {
//   const CreateProductView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) =>$ProductStateCopyWith,
//       child: const CreateProductPage(),
//     );
//   }
// }
