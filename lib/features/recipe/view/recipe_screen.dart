import 'package:flutter/material.dart';
import 'package:food_manager/features/widgets/countdown.dart';

class Recipe extends StatelessWidget {
  final Map<String, dynamic>? dishData;
  const Recipe({super.key, required this.dishData});

  @override
  Widget build(BuildContext context) {
    String recipeText = '${dishData?['recipe']}';
    List<String> recipeSteps = recipeText.split('Шаг');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Рецепт'),
      ),
      body: ListView(
        children: [
          Image.network(
            dishData?['image'] ?? '',
            height: MediaQuery.of(context).size.height * 0.33,
            width: MediaQuery.of(context).size.width * 0.9,
            errorBuilder: (_, __, ___) => const Icon(Icons.error),
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: 
                recipeSteps.map((step) {
                  if (step.trim().isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Шаг$step',
                          style:
                              Theme.of(context).textTheme.bodyMedium
                        ),
                        Text(
                           ' ',
                          style:
                              Theme.of(context).textTheme.bodyMedium
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return const CountdownPage();
            },
          );
        },
        child: const Icon(Icons.access_time_sharp),
      ),
    );
  }
}
