import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moxy/ui/screens/components/shimmer/shimmer_product_attributes.dart';

class ShimmerProfile extends StatelessWidget {
  const ShimmerProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: ShimmerProductDetails()),
        Expanded(child: ShimmerProductDetails())
      ],
    );
  }
}
