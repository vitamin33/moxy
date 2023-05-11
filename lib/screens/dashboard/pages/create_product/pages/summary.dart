import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/domain/create_product/create_product_cubit.dart';
import 'package:moxy/theme/app_theme.dart';
import '../../../../../domain/create_product/create_product_state.dart';

class Summary extends StatelessWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateProductCubit, CreateProductState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SummaryTextCard(
                    title: "Title",
                    text: state.product.name,
                  ),
                  const SizedBox(width: AppTheme.cardPadding),
                  // SummaryTextCard(
                  //   title: "Color",
                  //   text: state.color,
                  // ),
                  const SizedBox(width: AppTheme.cardPadding),
                ],
              ),
              const SizedBox(height: AppTheme.cardPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: AppTheme.cardPadding),
                  Expanded(
                    child: SummaryTextCard(
                        title: "Descripiton",
                        maxLine: 6,
                        text: state.product.description),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.cardPadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SummaryTextCard(
                        title: "Cost Price",
                        text: "\$ ${state.product.costPrice}",
                      ),
                      const SizedBox(width: AppTheme.cardPadding),
                      SummaryTextCard(
                        title: "Sale Price",
                        text: "\$ ${state.product.salePrice}",
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class SummaryTextCard extends StatelessWidget {
  final String title;
  final String text;
  final int maxLine;
  const SummaryTextCard({
    Key? key,
    required this.title,
    required this.text,
    this.maxLine = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(height: AppTheme.elementSpacing * 0.25),
        Container(
          padding: const EdgeInsets.all(AppTheme.elementSpacing),
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SelectableText(
            text,
            maxLines: maxLine,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}
