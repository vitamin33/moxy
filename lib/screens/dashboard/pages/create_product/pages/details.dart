import 'package:flutter/material.dart';
import 'package:moxy/components/moxy_button.dart';
import 'package:moxy/components/textfield.dart';
import 'package:moxy/theme/app_theme.dart';
import 'package:moxy/utils/common.dart';
import 'package:provider/provider.dart';

import '../../../../../constant/product_categories.dart';
import '../create_product_state.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CreateProductState>();

    moxyPrint(state.detailPageIsValid);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      child: Column(
        children: [
          MoxyTextfield(
            title: "Title",
            controller: state.titleController,
          ),
          const SizedBox(height: AppTheme.elementSpacing),
          MoxyTextfield(
            controller: state.descriptionController,
            title: "Description",
            maxLines: 6,
          ),
          const SizedBox(height: AppTheme.cardPadding),
          DropdownButtonFormField<String>(
            dropdownColor: AppTheme.darkBlue,
            hint: Text(
              "Select Category",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: AppTheme.white.withOpacity(.6)),
            ),
            items: categories
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: AppTheme.white),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              state.setCategory(value!);
            },
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MoxyButton(
                title: "Next",
                state: state.detailPageIsValid
                    ? ButtonState.idle
                    : ButtonState.disabled,
                onTap: () {
                  state.moveToNexPage();
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
