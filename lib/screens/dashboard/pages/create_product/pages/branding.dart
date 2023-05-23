import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/components/custom_textfield.dart';
import 'package:moxy/domain/create_product/create_product_cubit.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/theme/app_theme.dart';
import '../../../../../components/dashed_path_painter.dart';
import '../../../../../constant/icon_path.dart';
import '../../../../../domain/create_product/create_product_state.dart';

class Branding extends StatelessWidget {
  const Branding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        final cubit = context.read<CreateProductCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
          child: Column(
            children: [
              Column(
                children: [
                  state.product.images.isNotEmpty
                      ? Row(children: [
                          Expanded(
                            child: SizedBox(
                              height: 120,
                              width: double.maxFinite,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.product.images.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: SizedBox(
                                      child: _buildImage(
                                          state.product, index, cubit),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ])
                      : InkWell(
                          onTap: () {
                            cubit.pickImage();
                          },
                          // borderRadius: BorderRadius.all(Radius.circular(6)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                child: CustomPaint(
                                  foregroundPainter: DashedPathPainter(
                                    originalPath: Path()
                                      ..addRect(
                                        const Rect.fromLTWH(0, 0, 365, 100),
                                      ),
                                    pathColor: Colors.grey,
                                    strokeWidth: 1.0,
                                    dashGapLength: 5.0,
                                    dashLength: 3.0,
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(IconPath.pickImage),
                                        Text('Pick Image From Gallery')
                                      ]),
                                ),
                              ),
                              // Container(
                              //   width: MediaQuery.of(context).size.width,
                              //   height: 100,
                              //   decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(6.0),
                              //       border: Border.all(
                              //           width: 1.0, color: AppTheme.black)),
                              //   child: Column(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       children: [
                              //         SvgPicture.asset(IconPath.pickImage),
                              //         Text('Pick Image From Gallery')
                              //       ]),
                              // ),
                            ],
                          ),
                        )
                ],
              ),
              SizedBox(height: 50),
              CustomTextField(
                title: ' Price(\$)',
                controller: cubit.costPriceController,
                onChanged: cubit.costPriceChanged,
                state: state.errors.costPrice,
                maxLines: 1,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                ],
              ),
              const SizedBox(height: 30),
              CustomTextField(
                title: 'Sale Price(\$)',
                controller: cubit.salePriceController,
                onChanged: cubit.salePriceChanged,
                state: state.errors.salePrice,
                maxLines: 1,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                ],
              ),
              const SizedBox(width: AppTheme.cardPadding),
            ],
          ),
        );
      },
    );
  }

  _buildImage(Product product, int index, cubit) {
    final images = product.images;
    if (images.isEmpty) {
      return Container();
    } else {
      final image = images[index];
      if (image.type == Type.file) {
        return Stack(
          children: [
            Image.file(
              File(image.imagePath),
              width: 80,
              height: 100,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  cubit.removeImage(index);
                },
                child: const Icon(Icons.close, color: AppTheme.blackLight),
              ),
            ),
          ],
        );
      } else {
        return Stack(
          children: [
            Image.network(image.imagePath),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  cubit.removeImage(index);
                },
                child: const Icon(Icons.close, color: AppTheme.blackLight),
              ),
            ),
          ],
        );
      }
    }
  }
}
