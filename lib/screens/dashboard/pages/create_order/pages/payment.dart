import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/components/custom_textfield.dart';
import '../../../../../constant/icon_path.dart';
import '../../../../../constant/order_constants.dart';
import '../../../../../domain/create_order/create_order_cubit.dart';
import '../../../../../domain/create_order/create_order_state.dart';
import '../../../../../theme/app_theme.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrderCubit, CreateOrderState>(
        builder: (context, state) {
      final cubit = context.read<CreateOrderCubit>();

      return SingleChildScrollView(
        child: Column(
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
                          cubit.selectPaymentType(PaymentType.fullPayment);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 3,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color:
                                  state.paymentType == PaymentType.fullPayment
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          cubit.selectPaymentType(PaymentType.cashAdvance);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height / 3,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color:
                                  state.paymentType == PaymentType.cashAdvance
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
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            state.paymentType.name == 'cashAdvance'
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: CustomTextField(
                      title: 'Prepayment',
                      controller: cubit.prePaymentController,
                      onChanged: cubit.prePaymentChanged,
                      maxLines: 1,
                      state: state.errors.phoneNumber,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(16),
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      );
    });
  }
}
