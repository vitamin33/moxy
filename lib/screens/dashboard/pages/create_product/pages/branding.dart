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
import '../create_product_page.dart';

class Branding extends StatelessWidget {
  const Branding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        final cubit = context.read<CreateProductCubit>();
        return SingleChildScrollView(
            child: SizedBox(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
            child: Column(
              children: [
                _buildGalleryArea(context, state, cubit),
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
                _buildSelectedDimensWidget(state, cubit),
                const SizedBox(
                  height: 20,
                ),
                positionProductButton(state, cubit)
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

  Widget _buildSelectedDimensWidget(
      CreateProductState state, CreateProductCubit cubit) {
    if (state.allDimensions.isEmpty) {
      return Container();
    }
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(state.product.dimensions.length, (index) {
          Dimension dimen = state.product.dimensions[index];
          final imagePath = _generateImagePath(dimen);
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
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
                        backgroundImage: AssetImage(imagePath),
                      ),
                    )),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onLongPress: () {
                    cubit.quantityLongRemove(index, dimen.quantity);
                  },
                  child: IconButton(
                    constraints: const BoxConstraints(maxHeight: 30),
                    iconSize: 15,
                    color: AppTheme.black,
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(AppTheme.white),
                    ),
                    onPressed: () {
                      cubit.quantityRemove(index, dimen.quantity);
                    },
                    icon: const Icon(Icons.remove),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '${dimen.quantity}',
                  style: const TextStyle(fontSize: 17),
                ),
                const SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onLongPress: () {
                    cubit.quantityLongAdd(index, dimen.quantity);
                  },
                  child: IconButton(
                    constraints: const BoxConstraints(maxHeight: 30),
                    iconSize: 15,
                    color: AppTheme.black,
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(AppTheme.white),
                    ),
                    onPressed: () {
                      cubit.quantityAdd(index, dimen.quantity);
                    },
                    icon: const Icon(Icons.add),
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildGalleryArea(BuildContext context, CreateProductState state,
      CreateProductCubit cubit) {
    return LayoutBuilder(builder: (context, constraints) {
      final lineWidth = constraints.maxWidth;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          state.product.images.isNotEmpty
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
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
                                child: _buildImage(state.product, index, cubit),
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
                    cubit.pickImage();
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
                                SvgPicture.asset(IconPath.pickImage),
                                const Text('Pick Image From Gallery')
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

  String _generateImagePath(Dimension dimen) {
    if (dimen.image != null) {
      return dimen.image!;
    } else {
      return 'assets/images/logo.png';
    }
  }
}
