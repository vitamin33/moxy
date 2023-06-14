import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constant/order_status.dart';
import '../../../../../domain/create_order/create_order_cubit.dart';
import '../../../../../domain/create_order/create_order_state.dart';
import '../../../../../theme/app_theme.dart';
import '../create_order_page.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrderCubit, CreateOrderState>(
      builder: (context, state) {
        final cubit = context.read<CreateOrderCubit>();
        return Padding(
          padding: const EdgeInsets.all(9.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: allStatusOrder.length,
                  itemBuilder: (context, index) {
                    final status = allStatusOrder[index];
                    final isSelected = status.statusTitle == state.status;
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: isSelected
                              ? Border.all(
                                  color: AppTheme.black,
                                  width: 2.0,
                                )
                              : Border.all(
                                  color: AppTheme.white,
                                  width: 2.0,
                                ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: RadioListTile(
                          contentPadding: const EdgeInsets.all(4),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(status.iconPath),
                              const SizedBox(width: 15),
                              Text(
                                status.statusTitle,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          activeColor: AppTheme.black,
                          tileColor: AppTheme.white,
                          groupValue: state.status,
                          value: status.statusTitle,
                          onChanged: (newValue) {
                            context
                                .read<CreateOrderCubit>()
                                .updateSelectedStatusTitle(newValue!);
                          },
                        ),
                      ),
                    );
                  },
                ),
                positionOrderButton(state, cubit)
              ],
            ),
          ),
        );
      },
    );
  }
}
