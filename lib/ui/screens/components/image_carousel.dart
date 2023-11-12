import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/domain/models/product.dart';
import 'package:moxy/ui/screens/components/carousel_indicator.dart';
import 'package:moxy/ui/screens/components/onhover.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class ImageCarousel extends StatefulWidget {
  final List<Dimension> dimensions;

  const ImageCarousel({super.key, required this.dimensions});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final PageController _pageController = PageController(initialPage: 0);
  int activePage = 0;
  List<ImagePath> allImages = [];

  @override
  void initState() {
    super.initState();
    _updateImages();
  }

  void _updateImages() {
    bool allDimensionsSelected =
        widget.dimensions.any((dimension) => dimension.isSelected);

    if (allDimensionsSelected) {
      allImages = widget.dimensions
          .where((dimension) => dimension.isSelected)
          .expand((dimension) => dimension.images)
          .toList();
    } else {
      allImages =
          widget.dimensions.expand((dimension) => dimension.images).toList();
      
    }
  }

  @override
  void didUpdateWidget(ImageCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.dimensions != oldWidget.dimensions) {
      _updateImages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OnHover(
          builder: (isHovered) {
            return Stack(children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 2.2,
                height: 550,
                child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    itemCount: allImages.length,
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
                                    allImages[pagePosition].imagePath))),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              if (_pageController.hasClients) {
                                                _pageController.nextPage(
                                                    duration: const Duration(
                                                        milliseconds: 300),
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
                              count: allImages.length,
                              onDotClicked: (index) {
                                _pageController.animateToPage(index,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              },
                              effect: const ExpandingDotsEffect(
                                dotHeight: 6,
                                dotWidth: 10,
                              ),
                            ),
                          )),
                    ],
                  ))
            ]);
          },
        ),
        SizedBox(
          height: 100,
          width: 400,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: allImages.length,
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
                        allImages[index].imagePath,
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
  }
}
