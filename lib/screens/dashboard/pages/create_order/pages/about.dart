import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/domain/models/order.dart';
import '../../../../../components/custom_textfield.dart';
import '../../../../../components/dashed_path_painter.dart';
import '../../../../../constant/icon_path.dart';
import '../../../../../domain/create_order/create_order_cubit.dart';
import '../../../../../domain/create_order/create_order_state.dart';
import '../../../../../domain/models/product.dart';
import '../../../../../navigation/home_router_cubit.dart';
import '../../../../../theme/app_theme.dart';
import '../create_order_page.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateOrderCubit, CreateOrderState>(
        builder: (context, state) {
      final cubit = context.read<CreateOrderCubit>();
      return Padding(
        padding: const EdgeInsets.all(AppTheme.cardPadding),
        child: Column(
          children: [
            CustomTextField(
              title: 'First Name',
              maxLines: 1,
              controller: cubit.firstNameController,
              onChanged: cubit.firstNameChanged,
              validation: true,
              state: state.errors.firstName,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              title: 'Second Name',
              maxLines: 1,
              controller: cubit.secondNameController,
              onChanged: cubit.secondNameChanged,
              validation: true,
              state: state.errors.secondName,
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              title: 'Phone Number',
              controller: cubit.phoneNumberController,
              onChanged: cubit.phoneNumberChanged,
              maxLines: 1,
              state: state.errors.phoneNumber,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
              ],
            ),
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
                            'List Price:${state.productListPrice}',
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                color: AppTheme.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          InkWell(
                            onTap: () {
                              context.read<HomeRouterCubit>().navigateTo(
                                    const OrderProductListPageState(),
                                  );
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(IconPath.plus),
                                const SizedBox(
                                  width: 2,
                                ),
                                const Text(
                                  'Add Product',
                                  style: TextStyle(
                                      color: AppTheme.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    : const Text(
                        'List of products',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: AppTheme.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                const SizedBox(
                  height: 10,
                ),
                _buildGalleryArea(context, state, cubit),
                const SizedBox(
                  height: 20,
                ),
                positionOrderButton(state, cubit)
              ],
            ),
          ],
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
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                                color: AppTheme.white,
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ClipOval(
                                          child: _buildProductImage(
                                              state.selectedProducts[index])),
                                      Text(state
                                          .selectedProducts[index].productName),
                                      Text(state.selectedProducts[index]
                                          .dimensions.first.color),
                                      Text(
                                          ' quantity:${state.selectedProducts[index].dimensions.first.quantity}'),
                                    ])),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )
            : InkWell(
                onTap: () {
                  context.read<HomeRouterCubit>().navigateTo(
                        const OrderProductListPageState(),
                      );
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
                              const Text('Add Product')
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

Widget _buildProductImage(OrderedItem product) {
  if (product.imageUrl == null) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/placeholder.jpg',
      image: product.imageUrl!,
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
