import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class DishIngredients extends StatefulWidget {
  final String? dishIdIng;
  const DishIngredients({super.key, required this.dishIdIng});

  @override
  State<DishIngredients> createState() => _DishIngredientsState();
}

class _DishIngredientsState extends State<DishIngredients> {
  List<Map<String, dynamic>> ingredients = [];

  @override
  void initState() {
    super.initState();
    fetchIngredients();
  }

  Future<void> fetchIngredients() async {
    try {
      final ingredientsSnapshot = await FirebaseFirestore.instance
          .collection('dishes')
          .doc(widget.dishIdIng)
          .collection('ingridients')
          .get();

      final ingredientsList = ingredientsSnapshot.docs.map((doc) {
        final ingredientData = doc.data();
        return {
          'id': doc.id,
          'name': ingredientData['name'],
          'amount': ingredientData['amount'],
        };
      }).toList();

      setState(() {
        ingredients = ingredientsList;
      });
    } catch (e) {
      log('Error fetching ingredients: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ингредиенты',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.25,
          child: ListView.builder(
            itemCount: ingredients.length,
            itemBuilder: (context, index) {
              final ingredient = ingredients[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ingredient['name'] as String,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      ingredient['amount'] as String,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
