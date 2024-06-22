import 'package:flutter/material.dart';
import 'package:food_manager/features/recipe/recipe.dart';

class DishNutrition extends StatelessWidget {
  final Map<String, dynamic>? dishData;

  const DishNutrition({super.key, required this.dishData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        const Divider(thickness: 3),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '${dishData?['fats']}/${dishData?['proteins']}/${dishData?['carbs']}',
                    style: Theme.of(context).textTheme.bodyMedium),
                Text('Ж/Б/У', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${dishData?['calories']}',
                    style: Theme.of(context).textTheme.bodyMedium),
                Text('Ккал', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('4 Порции', style: Theme.of(context).textTheme.bodyMedium),
                Text('Количество',
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.9,
              alignment: const Alignment(0.0, 0.9),
              child: ConstrainedBox(
                constraints: const BoxConstraints.expand(),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Recipe(dishData: dishData),
                        ),
                      );
                    },
                  child: Text(
                    'Начать готовить',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ),
            ),
      ],
    );
  }
}