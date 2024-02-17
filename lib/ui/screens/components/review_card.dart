import 'package:flutter/material.dart';
import 'package:moxy/domain/models/review.dart';
import 'package:moxy/ui/screens/components/rate_indicator.dart';
import 'package:moxy/ui/theme/app_theme.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context)!;

    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(16),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        width: 330,
        height: 240,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: AppTheme.cardPadding, horizontal: 36),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RatingBarIndicator(
                  rating: review.rating.toDouble(),
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 15.0,
                ),
                Text(
                  review.reviewText,
                  style: theme.largeSemiBoltText,
                ),
                Row(
                  children: [
                    _buildAvatarImage(review.avatarImageUrl),
                    AppTheme.mediumHorizontalSpacing,
                    Text(
                      review.clientName,
                      style: theme.headlineText,
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}

Widget _buildAvatarImage(String image) {
  return ClipOval(
    child: FadeInImage.assetNetwork(
      placeholder: 'assets/images/placeholder.jpg',
      image: image,
      width: 30,
      height: 30,
      fit: BoxFit.cover,
    ),
  );
}
