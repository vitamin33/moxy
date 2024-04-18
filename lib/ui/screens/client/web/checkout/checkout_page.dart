import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/admin/create_order/search_cities/search_cities_cubit.dart';
import 'package:moxy/domain/admin/create_order/search_warehouse/search_warehouse_cubit.dart';
import 'package:moxy/domain/client/basket/basket_cubit.dart';
import 'package:moxy/domain/client/checkout/checkout_cubit.dart';
import 'package:moxy/domain/client/checkout/checkout_effects.dart';
import 'package:moxy/domain/client/checkout/checkout_state.dart';
import 'package:moxy/ui/components/snackbar_widgets.dart';
import 'package:moxy/ui/screens/components/back_container.dart';
import 'package:moxy/ui/screens/components/footer.dart';
import 'package:moxy/ui/screens/components/resale_products.dart';
import 'package:moxy/ui/screens/components/scrollable_section.dart';
import 'package:moxy/utils/responsive_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import 'checkout_info.dart';
import 'checkout_products.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late CheckoutCubit cubit;

  @override
  void initState() {
    super.initState();
    BasketCubit basketCubit = context.read<BasketCubit>();
    cubit = CheckoutCubit(basketCubit.state.basket);
    cubit.effectStream.listen((effect) {
      handleEffect(effect);
    });
  }

  void handleEffect(dynamic effect) async {
    if (effect is ValidationFailed) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
          snackBarFailureText: 'Wrong input, please check fields.'));
    } else if (effect is NavigateToPaymentProccess) {
      // Use Future.delayed to wait for the launchUrl to complete
      await Future.delayed(Duration.zero);
      await launchUrl(effect.paymentUri);
    } else if (effect is UnableToLoadPaymentUrl) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
          snackBarFailureText:
              'Unable to open payment URL, please try again later.'));
    } else if (effect is NewOrderCreationFailed) {
      ScaffoldMessenger.of(context).showSnackBar(snackBarWhenFailure(
          snackBarFailureText:
              'Unable to create order, contact our support please.'));
    }
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CheckoutCubit>(
          create: (BuildContext context) => cubit,
        ),
        BlocProvider<SearchCitiesCubit>(
          create: (BuildContext context) =>
              SearchCitiesCubit(selectedCity: cubit.state.selectedCity),
        ),
        BlocProvider<SearchWarehouseCubit>(
          create: (BuildContext context) => SearchWarehouseCubit(
            selectedWarehouse: cubit.state.selectedWarehouse,
          ),
        ),
      ],
      child: BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          final isMobile = ResponsiveUtil.isMobile(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ScrollableSection(
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BackContainer(),
                        isMobile
                            ? Column(
                                children: [
                                  CheckoutInfo(
                                    state: state,
                                  ),
                                  CheckoutProducts(
                                    state: state,
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 40),
                                      child: CheckoutInfo(state: state),
                                    ),
                                  ),
                                  const VerticalDivider(width: 1, thickness: 1),
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CheckoutProducts(state: state),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                      ],
                    ),
                  ),
                  const ResaleProducts(),
                  const Footer()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
