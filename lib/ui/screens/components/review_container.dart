import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/review/review_cubit.dart';
import 'package:moxy/domain/review/review_state.dart';
import 'package:moxy/ui/screens/components/onhover.dart';
import 'package:moxy/ui/screens/components/lottie_loader.dart';
import 'package:moxy/ui/screens/components/review_card.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/responsive_utils.dart';

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
          final isMobile = ResponsiveUtil.isMobile(context);

          return state.isLoading
              ? LottieLoader()
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          'Що говорять наші клієнти',
                          style: theme.headline3BoltText,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 250,
                        child: OnHover(
                          builder: (isHover) {
                            return Stack(
                              children: [
                                if (isMobile)
                                  PageView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    controller: cubit.pageController,
                                    itemCount: state.reviewsList.length,
                                    itemBuilder: (context, index) {
                                      return ReviewCard(
                                          review: state.reviewsList[index]);
                                    },
                                  )
                                else
                                  ListView.builder(
                                    controller: cubit.scrollController,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
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
                                isHover
                                    ? _buildArrows(state, cubit, isMobile)
                                    : const SizedBox.shrink(),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10)
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget _buildArrows(ReviewState state, ReviewCubit cubit, bool isMobile) {
    return Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                cubit.moveToPreviousProduct(isMobile);
              },
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
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
          ),
          GestureDetector(
            onTap: () {
              cubit.moveToNextProduct(isMobile);
            },
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
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
          ),
        ],
      ),
    );
  }
}
