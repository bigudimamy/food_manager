import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsTile extends StatefulWidget {
  const ProductsTile({
    super.key,
    required this.dishID,
  });

  final String dishID;

  @override
  State<ProductsTile> createState() => _ProductsTileState();
}

class _ProductsTileState extends State<ProductsTile> {
  Map<String, dynamic>? dishData;
  List<Map<String, dynamic>> ingredients = [];
  bool isExpanded = false;

    @override
    void initState() {
      super.initState();
      _fetchDishData();
      fetchIngredients();
    }

    Future<void> _fetchDishData() async {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('dishes')
          .doc(widget.dishID)
          .get();
      if (snapshot.exists) {
        setState(() {
          dishData = snapshot.data() as Map<String, dynamic>;
        });
      }
    }

  Future<void> fetchIngredients() async {
    try {
      final ingredientsSnapshot = await FirebaseFirestore.instance
          .collection('dishes')
          .doc(widget.dishID)
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
    return Card(
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: Text(
          dishData?['dish_name'] ?? '',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        initiallyExpanded: isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            isExpanded = expanded;
          });
        },
        children: [
          if (isExpanded)
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ingredients.length,
              itemBuilder: (context, index) {
                final ingredient = ingredients[index];
                return Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                  ),
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
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
        ],
      ),
    );
  }
}