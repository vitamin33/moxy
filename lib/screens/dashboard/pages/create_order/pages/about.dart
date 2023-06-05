import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../components/custom_textfield.dart';
import '../../../../../components/dashed_path_painter.dart';
import '../../../../../constant/icon_path.dart';
import '../../../../../domain/create_order/create_order_cubit.dart';
import '../../../../../domain/create_order/create_order_state.dart';
import '../../../../../theme/app_theme.dart';

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
              title: ' First Name',
              maxLines: 1,
              controller: cubit.firstNameController,
              onChanged: cubit.firstNameChanged,
              validation: true,
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
            ),
            const SizedBox(
              height: 10,
            ),
             CustomTextField(
              title: 'Phone Number',
              controller: cubit.phoneNumberController,
                  onChanged: cubit.phoneNumberChanged,
                  state: state.errors.costPrice,
                  maxLines: 1,
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
                const Text(
                  'List of products',
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildGalleryArea(context, state, cubit)
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
        state.isLoading
            ? Container()
            //  Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Flexible(
            //         child: SizedBox(
            //           height: 120,
            //           width: double.maxFinite,
            //           child: ListView.builder(
            //             scrollDirection: Axis.horizontal,
            //             itemCount: state.product.images.length,
            //             itemBuilder: (context, index) {
            //               return Padding(
            //                 padding: const EdgeInsets.all(2.0),
            //                 child: SizedBox(
            //                   child: _buildImage(state.product, index, cubit),
            //                 ),
            //               );
            //             },
            //           ),
            //         ),
            //       ),
            //     ],
            //   )
            : InkWell(
                onTap: () {
                  cubit.pickProduct();
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
