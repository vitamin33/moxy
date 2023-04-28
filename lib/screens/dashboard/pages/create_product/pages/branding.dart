import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/components/moxy_button.dart';
import 'package:moxy/components/textfield.dart';
import 'package:moxy/domain/product_cubit.dart';
import 'package:moxy/theme/app_theme.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/product_state.dart';

class Branding extends StatelessWidget {
  const Branding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, ProductState>(
      builder: (context, state) {
        final cubit = context.read<CreateProductCubit>();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
          child: Column(
            children: [
              Column(
                children: [
                  state.image != ''
                      ? Image.file(
                          File(state.image),
                          width: 100,
                          height: 100,
                        )
                      : Icon(
                          Icons.cloud_upload_sharp,
                          color: AppTheme.primaryContainerColor,
                        ),
                  MoxyButton(
                      title: "Pick Image from Gallery",
                      onTap: () {
                        cubit.pickImage();
                      }),
                ],
              ),
              Container(
                width: 300,
                height: 200,
                child: Column(
                  children: [
                    Expanded(
                      child: MoxyTextfield(
                        title: "Price(\$)",
                        controller: cubit.costPriceController,
                        onChanged: (value) => {cubit.costPriceChanged(value)},
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(16),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppTheme.cardPadding),
                    Expanded(
                      child: MoxyTextfield(
                        title: "Sale Price(\$)",
                        controller: cubit.salePriceController,
                        onChanged: (value) => {cubit.salePriceChanged(value)},
                      ),
                    ),
                    const SizedBox(width: AppTheme.cardPadding),
                    Expanded(
                      child: MoxyTextfield(
                        title: "Regular Price(\$)",
                        onChanged: (value) =>
                            {cubit.regularPriceChanged(value)},
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          //  Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     // InkWell(
          //     //   borderRadius: BorderRadius.circular(15),
          //     //   onTap: () {
          //     //     context.read<CreateProductCubit>().pickImage();
          //     //   },
          //     //   // child: Container(
          //     //   //   height: 350,
          //     //   //   width: 350,
          //     //   //   decoration: BoxDecoration(
          //     //   //     color:  Colors.black,
          //     //   //     image: state.image!= null
          //     //   //         ? DecorationImage(
          //     //   //             image: MemoryImage(imageUnit8List!))
          //     //   //         : null,
          //     //   //     borderRadius: BorderRadius.circular(15),
          //     //   //   ),
          //     //   //   child: imageUnit8List != null
          //     //   //       ? const SizedBox.shrink()
          //     //   //       : const Center(
          //     //   //           child: Icon(
          //     //   //           Icons.add_a_photo,
          //     //   //           size: 80,
          //     //   //         )),
          //     //   // ),
          //     // ),
          //     const Spacer(),
          //     // Row(
          //     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     //   children: [
          //     //     MoxyButton(
          //     //       title: "Previous",
          //     //       gradiant: const [
          //     //         AppTheme.blackLight,
          //     //         AppTheme.blackLight,
          //     //       ],
          //     //       onTap: () {
          //     //         context.read<CreateProductCubit>().moveToPreviousPage();
          //     //       },
          //     //     ),
          //     //     MoxyButton(
          //     //       title: "Next",
          //     //       state: imageUnit8List == null
          //     //           ? ButtonState.disabled
          //     //           : ButtonState.idle,
          //     //       onTap: () {
          //     //         context.read<CreateProductCubit>().moveToNexPage();
          //     //       },
          //     //     ),
          //     //   ],
          //     // )
          //   ],
          // ),
        );
      },
    );
  }
}
