import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../constant/icon_path.dart';
import '../../../../../constant/order_constants.dart';
import '../../../../../domain/create_order/create_order_cubit.dart';
import '../../../../../domain/create_order/create_order_state.dart';
import '../../../../../theme/app_theme.dart';
import '../create_order_page.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrderCubit, CreateOrderState>(
        builder: (context, state) {
      final cubit = context.read<CreateOrderCubit>();

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppTheme.cardPadding),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        cubit.selectPaymentType(PaymentType.FullPayment);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: state.paymentType == PaymentType.FullPayment
                                ? Colors.black
                                : AppTheme.white,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: AppTheme.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(IconPath.fullPayment),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text('Full Payment',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        cubit.selectPaymentType(PaymentType.CashAdvance);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 3,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: state.paymentType == PaymentType.CashAdvance
                                ? Colors.black
                                : AppTheme.white,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          color: AppTheme.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(IconPath.cashPayment),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text('Cash advance',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          positionOrderButton(state, cubit)
        ],
      );
    });
  }
}
