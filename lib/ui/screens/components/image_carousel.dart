import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/client/product_details/product_details_cubit.dart';
import 'package:moxy/domain/client/product_details/product_details_state.dart';
import 'package:moxy/ui/screens/components/carousel_indicator.dart';
import 'package:moxy/ui/screens/components/onhover.dart';
import 'package:moxy/ui/screens/components/shimmer/shimmer_image_carusel.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:moxy/utils/responsive_utils.dart';

class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final PageController _pageController = PageController(initialPage: 0);
  int activePage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const ShimmerImageCarusel();
        }

        final isMobile = ResponsiveUtil.isMobile(context);
        double imageWidth = isMobile ? 1.1 : 2.2;
        double height = isMobile ? 370 : 550;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OnHover(
              builder: (isHovered) {
                return Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / imageWidth,
                      height: height,
                      child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          itemCount: state.allImages.length,
                          onPageChanged: (newPage) {
                            setState(() {
                              activePage = newPage;
                            });
                          },
                          itemBuilder: (context, pagePosition) {
                            return Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    state.allImages[pagePosition].imagePath,
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: [
                          isHovered
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (_pageController.hasClients) {
                                                _pageController.previousPage(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.easeIn,
                                                );
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppTheme.greyLigth,
                                              borderRadius:
                                                  BorderRadius.circular(50),
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
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: AppTheme.greyLigth,
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          height: 50,
                                          width: 50,
                                          child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (_pageController
                                                      .hasClients) {
                                                    _pageController.nextPage(
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    300),
                                                        curve: Curves.easeIn);
                                                  }
                                                });
                                              },
                                              child: Center(
                                                child: SvgPicture.asset(
                                                  IconPath.forwardArrow,
                                                  width: 20,
                                                ),
                                              )),
                                        )),
                                  ],
                                )
                              : Container(),
                          const SizedBox(height: 200),
                          SizedBox(
                              height: 50,
                              child: Center(
                                child: SmoothPageIndicator(
                                  controller: _pageController,
                                  count: state.allImages.length,
                                  onDotClicked: (index) {
                                    _pageController.animateToPage(index,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeIn);
                                  },
                                  effect: const ExpandingDotsEffect(
                                    dotHeight: 6,
                                    dotWidth: 10,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
            if (!isMobile)
              SizedBox(
                height: 100,
                width: 400,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.allImages.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              activePage = index;
                              if (_pageController.hasClients) {
                                _pageController.animateToPage(
                                  index,
                                  duration: const Duration(microseconds: 100),
                                  curve: Curves.easeIn,
                                );
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: activePage == index
                                    ? AppTheme.pinkDark
                                    : Colors.white,
                              ),
                            ),
                            width: 70,
                            height: 75,
                            child: Image.network(
                              state.allImages[index].imagePath,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10)
                      ],
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
