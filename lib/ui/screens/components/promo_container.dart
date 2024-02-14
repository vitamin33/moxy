import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/client/promo/promo_cubit.dart';
import 'package:moxy/ui/screens/components/promo_page.dart';

import '../../../domain/client/promo/promo_state.dart';

class PromoContainer extends StatefulWidget {
  const PromoContainer({super.key});

  @override
  State<PromoContainer> createState() => _PromoContainerState();
}

class _PromoContainerState extends State<PromoContainer> {
  Timer? _timer;
  late PromoCubit _promoCubit;

  @override
  void initState() {
    super.initState();
    _promoCubit = PromoCubit();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_promoCubit.state.allPromo.isNotEmpty) {
        _promoCubit.moveToNextPage();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _promoCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _promoCubit,
      child: BlocConsumer<PromoCubit, PromoState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = context.read<PromoCubit>();

          final pages = state.allPromo.map((e) {
            return PromoPage(
              backgroundImage: e.imageUrl,
              discountPercentage: e.discount.toString(),
              collectionName: e.title,
              product: e.product,
              finalDate: e.finalDate,
              activePage: state.activePage,
              allPromoCounth: state.allPromo.length,
              moveToPreviusPage: cubit.moveToPreviustPage,
              moveToNextPage: cubit.moveToNextPage,
              animatedToPage: cubit.animatedToPage,
            );
          }).toList();
          return state.allPromo.isNotEmpty
              ? SizedBox(
                  width: double.infinity,
                  height: 350,
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
              : const SizedBox();
        },
      ),
    );
  }
}
