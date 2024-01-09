import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moxy/domain/models/dimension_product.dart';
import 'package:moxy/services/navigation/router_provider.dart';
import '../../../../../components/custom_textfield.dart';
import '../../../../../components/dashed_path_painter.dart';
import '../../../../../../constant/icon_path.dart';
import '../../../../../../domain/admin/create_order/create_order_cubit.dart';
import '../../../../../../domain/admin/create_order/create_order_state.dart';
import '../../../../../theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrderCubit, CreateOrderState>(
        builder: (context, state) {
      final cubit = context.read<CreateOrderCubit>();
      final theme = AppTheme.of(context)!;

      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    cubit.pasteUsersData();
                  },
                  icon: const Icon(Icons.paste)),
              CustomTextField(
                  title: AppLocalizations.of(context)!.userFirstName,
                  maxLines: 1,
                  controller: cubit.firstNameController,
                  onChanged: cubit.firstNameChanged,
                  validation: true,
                  state: state.errors.firstName,
                  isClearButton: true),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                  title: AppLocalizations.of(context)!.userSecondName,
                  maxLines: 1,
                  controller: cubit.secondNameController,
                  onChanged: cubit.secondNameChanged,
                  state: state.errors.secondName,
                  isClearButton: true),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                  title: AppLocalizations.of(context)!.userPhoneNumber,
                  controller: cubit.phoneNumberController,
                  onChanged: cubit.phoneNumberChanged,
                  maxLines: 1,
                  state: state.errors.phoneNumber,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                  ],
                  isClearButton: true),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  state.selectedProducts.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${AppLocalizations.of(context)!.createOrderListPrice}:${state.productListPrice}',
                              textAlign: TextAlign.start,
                              style: theme.largeSemiBoltText,
                            ),
                            InkWell(
                              onTap: () {
                                context.push(
                                    RouterProvider.adminOrderProductListPath());
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(IconPath.plus),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .createOrderAddProduct,
                                    style: theme.largeSemiBoltText,
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      : Text(
                          AppLocalizations.of(context)!
                              .createOrderListOfProduct,
                          textAlign: TextAlign.start,
                          style: renderTitleStyle(context,
                              isValid(state.errors.selectedProduct), theme),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildGalleryArea(context, state, cubit),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

Widget _buildGalleryArea(
    BuildContext context, CreateOrderState state, CreateOrderCubit cubit) {
  return LayoutBuilder(builder: (context, constraints) {
    final lineWidth = constraints.maxWidth;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        state.selectedProducts.isNotEmpty
            ? Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: SizedBox(
                      height: 125,
                      width: double.maxFinite,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.selectedProducts.length,
                        itemBuilder: (context, index) {
                          final item = state.selectedProducts[index];
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              color: AppTheme.white,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ClipOval(child: _buildProductImage(item)),
                                      Text(item.name),
                                      Text(item.dimension.color.name),
                                      Text(
                                          '${AppLocalizations.of(context)!.quantity}:${item.dimension.quantity}'),
                                    ]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )
            : InkWell(
                onTap: () {
                  context.push(RouterProvider.adminOrderProductListPath());
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: CustomPaint(
                        foregroundPainter: DashedPathPainter(
                          originalPath: Path()
                            ..addRect(
                              Rect.fromLTWH(0, 0, lineWidth, 100),
                            ),
                          pathColor: Colors.grey,
                          strokeWidth: 1.0,
                          dashGapLength: 5.0,
                          dashLength: 3.0,
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(IconPath.plus),
                              Text(AppLocalizations.of(context)!
                                  .createOrderAddProduct)
                            ]),
                      ),
                    ),
                  ],
                ),
              )
      ],
    );
  });
}

Widget _buildProductImage(DimensionProduct product) {
  if (product.dimension.images.isNotEmpty) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/placeholder.jpg',
      image: product.dimension.images.first.imagePath,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
    );
  } else {
    return Image.asset(
      'assets/images/placeholder.jpg',
      width: 50,
      height: 50,
      fit: BoxFit.cover,
    );
  }
}

bool isValid(state) => state == null;
TextStyle renderTitleStyle(BuildContext context, bool isValid, AppTheme theme) {
  return theme.largeSemiBoltText
      .copyWith(color: isValid ? Colors.black : Colors.red);
}
