import 'package:flutter/material.dart';

class DishHeader extends StatelessWidget {
  final Map<String, dynamic>? dishData;

  const DishHeader({super.key, required this.dishData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          dishData?['image'] ?? '',
          height: MediaQuery.of(context).size.height * 0.33,
          width: MediaQuery.of(context).size.width * 0.9,
          errorBuilder: (_, __, ___) => const Icon(Icons.error),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      ],
    );
  }
}