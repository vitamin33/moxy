import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/constant/image_path.dart';
import 'package:moxy/domain/client/promo/promo_cubit.dart';
import 'package:moxy/ui/screens/components/promo_page.dart';
import 'package:moxy/utils/common.dart';

import '../../../domain/client/promo/promo_state.dart';

class PromoContainer extends StatelessWidget {
  const PromoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PromoCubit(),
      child: BlocConsumer<PromoCubit, PromoState>(
        listener: (context, state) {},
        builder: (context, state) {
          final pages = state.allPromo.map((e) {
            return PromoPage(
              backgroundImage: e.imageUrl,
              discountPercentage: e.discount.toString(),
              collectionName: e.title,
              product: e.product,
              finalDate: e.finalDate,
              activePage: state.activePage,
              allPromoCounth: state.allPromo.length,
            );
          }).toList();
          final cubit = context.read<PromoCubit>();
          return SizedBox(
            width: double.infinity,
            height: 600,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
            ),
          );
        },
      ),
    );
  }
}
