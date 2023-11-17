import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/admin/edit_order/edit_order_cubit.dart';
import 'package:moxy/domain/admin/edit_order/edit_order_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class ContactDetails extends StatelessWidget {
  final EditOrderState state;
  const ContactDetails({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EditOrderCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.contactDetails,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        _buildClientNameWidget(context, state, cubit),
        _buildClientPhoneWidget(context, state, cubit),
        _buildOrderProductsSummaryWidget(context, state, cubit),
      ],
    );
  }

  String _formSelectedProductsName(EditOrderState state) {
    return state.selectedProducts.map((item) => item.name).join(', ');
  }

  Widget _buildClientNameWidget(
      BuildContext context, EditOrderState state, EditOrderCubit cubit) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: state.isEditName
          ? Row(
              key: const ValueKey<String>('edit'),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  IconPath.personName,
                ),
                SizedBox(
                    width: 130,
                    height: 45,
                    child: TextField(
                      controller: cubit.nameEditController,
                    )),
                IconButton(
                    onPressed: () {
                      cubit.addEditName();
                    },
                    icon: const Icon(Icons.check))
              ],
            )
          : Row(
              key: const ValueKey<String>('view'),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  IconPath.personName,
                ),
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      '${state.client.firstName}  ${state.client.secondName}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.gray,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        cubit.changeEditName();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.change,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.pinkDark,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildClientPhoneWidget(
      BuildContext context, EditOrderState state, EditOrderCubit cubit) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: state.isEditPhone
          ? Row(
              key: const ValueKey<String>('edit'),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(IconPath.phone),
                SizedBox(
                    width: 130,
                    height: 40,
                    child: TextField(
                      controller: cubit.phoneEditController,
                    )),
                IconButton(
                    onPressed: () {
                      cubit.addEditPhone();
                    },
                    icon: const Icon(Icons.check))
              ],
            )
          : Row(
              key: const ValueKey<String>('view'),
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(IconPath.phone),
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      state.client.mobileNumber,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.gray,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        cubit.changeEditPhone();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.change,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.pinkDark,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildOrderProductsSummaryWidget(
      BuildContext context, EditOrderState state, EditOrderCubit cubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(IconPath.selectedProduct),
        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              _formSelectedProductsName(state),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.gray,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                cubit.editSelectedProduct();
                context.push(RouterProvider.adminOrderProductListPath());
              },
              child: Text(
                AppLocalizations.of(context)!.change,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.pinkDark,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
