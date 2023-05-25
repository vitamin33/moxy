import 'dart:io';
import 'dart:math';

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
import '../../../../../constant/product_colors.dart';
import '../../../../../domain/create_product/create_product_state.dart';

class Branding extends StatelessWidget {
  const Branding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        final cubit = context.read<CreateProductCubit>();
        List<String> backgroundImage = [];
        return SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
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
                                          const Text('Pick Image From Gallery')
                                        ]),
                                  ),
                                ),
                              ],
                            ),
                          )
                  ],
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
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
                Expanded(
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.product.dimensions.length,
                      itemBuilder: (context, index) {
                        List<Dimension> dropDownItems =
                            allColorsDimens.toList();

                        for (Dimension item in dropDownItems) {
                          if (item.color ==
                              state.product.dimensions[index]?.color) {
                            backgroundImage.add(item.image!);
                          }
                        }
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(3),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: AppTheme.white,
                                    child: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: AppTheme.pink,
                                      backgroundImage:
                                          AssetImage(backgroundImage[index]),
                                    ),
                                  )),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onLongPress: () {
                                  cubit.quantityLongRemove(
                                      index,
                                      state
                                          .product.dimensions[index]?.quantity);
                                },
                                child: IconButton(
                                  constraints:
                                      const BoxConstraints(maxHeight: 30),
                                  iconSize: 15,
                                  color: AppTheme.black,
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        AppTheme.white),
                                  ),
                                  onPressed: () {
                                    cubit.quantityRemove(
                                        index,
                                        state.product.dimensions[index]
                                            ?.quantity);
                                  },
                                  icon: const Icon(Icons.remove),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${state.product.dimensions[index]?.quantity}',
                                style: const TextStyle(fontSize: 17),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onLongPress: () {
                                  cubit.quantityLongAdd(
                                      index,
                                      state
                                          .product.dimensions[index]?.quantity);
                                },
                                child: IconButton(
                                  constraints:
                                      const BoxConstraints(maxHeight: 30),
                                  iconSize: 15,
                                  color: AppTheme.black,
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        AppTheme.white),
                                  ),
                                  onPressed: () {
                                    cubit.quantityAdd(
                                        index,
                                        state.product.dimensions[index]
                                            ?.quantity);
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          ),
        ));
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
