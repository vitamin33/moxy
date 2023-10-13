import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:moxy/constant/icon_path.dart';
import 'package:moxy/ui/screens/components/carousel_indicator.dart';
import 'package:moxy/ui/screens/components/onhover.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> images;
  const ImageCarousel({super.key, required this.images});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final PageController _pageController = PageController(initialPage: 0);

  int activePage = 0;

  @override
  Widget build(BuildContext context) {
    return OnHover(
      builder: (isHovered) {
        return Stack(children: [
          SizedBox(
            width: 400,
            height: 500,
            child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemCount: widget.images.length,
                onPageChanged: (newPage) {
                  setState(() {
                    activePage = newPage;
                  });
                },
                itemBuilder: (context, pagePosition) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.images[pagePosition]))),
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
                              child: OnHover(
                                builder: ((isHovered) {
                                  return InkWell(
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
                                        color: isHovered
                                            ? AppTheme.white
                                            : Colors.transparent,
                                        border:
                                            Border.all(color: AppTheme.white),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      height: 50,
                                      width: 50,
                                      child: Center(
                                        child: SvgPicture.asset(
                                          IconPath.backArrow,
                                          width: 20,
                                          color: isHovered
                                              ? Colors.transparent
                                                  .withOpacity(0.9)
                                              : AppTheme.white,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: OnHover(builder: ((isHovered) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: isHovered
                                          ? AppTheme.white
                                          : Colors.transparent,
                                      border: Border.all(color: AppTheme.white),
                                      borderRadius: BorderRadius.circular(50)),
                                  height: 50,
                                  width: 50,
                                  child: InkWell(
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
                                          color: isHovered
                                              ? Colors.transparent
                                                  .withOpacity(0.9)
                                              : AppTheme.white,
                                        ),
                                      )),
                                );
                              })),
                            ),
                          ],
                        )
                      : Container(),
                  const SizedBox(height: 150),
                  SizedBox(
                      height: 50,
                      child: Center(
                        child: SmoothPageIndicator(
                          controller: _pageController,
                          count: widget.images.length,
                          onDotClicked: (index) {
                            _pageController.animateToPage(index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                          },
                          effect: const ExpandingDotsEffect(
                            dotHeight: 16,
                            dotWidth: 16,
                          ),
                        ),
                      )),
                ],
              ))
        ]);
      },
    );
  }
}
