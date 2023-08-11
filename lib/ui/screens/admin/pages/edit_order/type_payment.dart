import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/constant/order_constants.dart';
import 'package:moxy/domain/admin/edit_order/edit_order_cubit.dart';
import 'package:moxy/domain/admin/edit_order/edit_order_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class TypePayment extends StatelessWidget {
  final EditOrderState state;
  const TypePayment({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditOrderCubit>();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.filterTypePayment,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        onTap: () {
                          cubit.changePayment(PaymentType.fullPayment);
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              state.paymentType == PaymentType.fullPayment
                                  ? AppTheme.pinkDark
                                  : AppTheme.greyLigth,
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: AppTheme.white,
                            child: SvgPicture.asset(IconPath.fullPayment,
                                width: 30),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          AppLocalizations.of(context)!.fullPayment,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        onTap: () {
                          cubit.changePayment(PaymentType.cashAdvance);
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              state.paymentType == PaymentType.cashAdvance
                                  ? AppTheme.pinkDark
                                  : AppTheme.greyLigth,
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: AppTheme.white,
                            child: SvgPicture.asset(
                              IconPath.cashPayment,
                              width: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(AppLocalizations.of(context)!.cashAdvance,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            )),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: AnimatedOpacity(
            opacity: state.paymentType == PaymentType.cashAdvance ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: state.paymentType == PaymentType.cashAdvance
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: 80,
                          height: 40,
                          child: TextField(
                            controller: cubit.paymentController,
                            onChanged: (value) {
                              cubit.cashAdvancePrepayment(value);
                            },
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
          ),
        ),
      ],
    );
  }
}
