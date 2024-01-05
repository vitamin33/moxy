import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/feadback/review_cubit.dart';
import 'package:moxy/domain/feadback/review_state.dart';
import 'package:moxy/ui/screens/components/review_card.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class ReviewContainer extends StatelessWidget {
  const ReviewContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewCubit(),
      child: BlocBuilder<ReviewCubit, ReviewState>(
        builder: (context, state) {
          final cubit = context.read<ReviewCubit>();
          final theme = AppTheme.of(context)!;

          return state.isLoading
              ? const CircularProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Що говорять наші клієнти',
                        style: theme.headline4BoltText,
                      ),
                    ),
                    Container(
                      color: AppTheme.greyLigth,
                      width: double.infinity,
                      height: 250,
                      child: Stack(
                        children: [
                          ListView.builder(
                            controller: cubit.scrollController,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: state.reviewsList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ReviewCard(
                                    review: state.reviewsList[index]),
                              );
                            },
                          ),
                          Align(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      cubit.moveToPreviousProduct();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppTheme.greyLigth,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      height: 50,
                                      width: 50,
                                      child: Center(
                                        child: SvgPicture.asset(
                                          IconPath.backArrow,
                                          width: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cubit.moveToNextProduct();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppTheme.greyLigth,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    height: 50,
                                    width: 50,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        IconPath.forwardArrow,
                                        width: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
