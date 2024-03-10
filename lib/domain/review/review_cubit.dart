import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moxy/data/repositories/review_repository.dart';
import 'package:moxy/domain/review/review_state.dart';
import 'package:moxy/domain/mappers/review_mapper.dart';
import 'package:moxy/services/get_it.dart';
import 'package:moxy/utils/common.dart';

const itemWidth = 400;

class ReviewCubit extends Cubit<ReviewState> {
  ReviewCubit() : super(ReviewState.defaultReviewState()) {
    fetchFeadback();
  }

  final reviewRepository = locate<ReviewRepository>();
  final reviewMapper = locate<ReviewMapper>();
  final ScrollController scrollController = ScrollController();
  final PageController pageController = PageController(viewportFraction: 0.9);

  void moveToPreviousProduct(bool isMobile) {
    if (isMobile) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      final currentOffset = scrollController.offset;

      final targetOffset = currentOffset - itemWidth;

      scrollController.animateTo(
        targetOffset,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  void moveToNextProduct(bool isMobile) {
    if (isMobile) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      final currentOffset = scrollController.offset;
      final targetOffset = currentOffset + itemWidth;

      scrollController.animateTo(
        targetOffset,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  void fetchFeadback() async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await reviewRepository.getReviews();
      result.when((success) {
        final allReviewsList = reviewMapper.mapToReviews(success);
        emit(state.copyWith(reviewsList: allReviewsList, isLoading: false));
      }, (error) {
        emit(state.copyWith(errorMessage: 'Failed allReviewsList'));
      });
    } catch (e) {
      moxyPrint('$e');
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    pageController.dispose();
    return super.close();
  }
}
