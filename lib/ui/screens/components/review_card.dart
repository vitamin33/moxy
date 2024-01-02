import 'package:flutter/material.dart';
import 'package:moxy/domain/models/review.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;

    return SizedBox(
        width: 330,
        height: 340,
        child: Column(children: [Text(review.reviewText)]));
  }
}
