import 'package:flutter/material.dart';
import 'package:moxy/ui/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProductDetails extends StatelessWidget {
  const ShimmerProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[300]!,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TitleLine(),
            _SimpleLine(),
            SizedBox(height: 40),
            _DescriptionLines(),
            SizedBox(height: 40),
            _SimpleLine(),
            _DescriptionLines(),
            _DescriptionLines(),
          ],
        ),
      ),
    );
  }
}

class _TitleLine extends StatelessWidget {
  const _TitleLine();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        color: AppTheme.white,
        constraints: const BoxConstraints.expand(width: 400, height: 50),
      ),
    );
  }
}

class _SimpleLine extends StatelessWidget {
  const _SimpleLine();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Container(
        color: AppTheme.white,
        constraints: const BoxConstraints(
          maxHeight: 30,
          maxWidth: 400,
          minHeight: 30,
          minWidth: 100,
        ),
      ),
    );
  }
}

class _DescriptionLines extends StatelessWidget {
  const _DescriptionLines();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Container(
              color: AppTheme.white,
              constraints: const BoxConstraints(
                maxHeight: 10,
                maxWidth: 400,
                minHeight: 10,
                minWidth: 100,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Container(
              color: AppTheme.white,
              constraints: const BoxConstraints(
                maxHeight: 10,
                maxWidth: 400,
                minHeight: 10,
                minWidth: 100,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Container(
              color: AppTheme.white,
              constraints: const BoxConstraints(
                maxHeight: 10,
                maxWidth: 400,
                minHeight: 10,
                minWidth: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
