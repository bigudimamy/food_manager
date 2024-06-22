import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class DishScreen extends StatefulWidget {
  const DishScreen({super.key});

  @override
  State<DishScreen> createState() => _DishScreenState();
}

class _DishScreenState extends State<DishScreen> {
  String? dishID;
  Map<String, dynamic>? dishData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args == null || args is! String) {
      log('You must provide a valid String argument');
      return;
    }

    dishID = args;
    _fetchDishData();
  }

  Future<void> _fetchDishData() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('dishes')
          .doc(dishID)
          .get();
      if (snapshot.exists) {
        setState(() {
          dishData = snapshot.data() as Map<String, dynamic>;
        });
      } else {
        log('Dish not found');
      }
    } catch (e) {
      log('Error fetching dish data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dishData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(dishData?['dish_name'] ?? ''),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: ListView(
          children: [
            DishHeader(dishData: dishData),
            DishIngredients(dishIdIng: dishID),
            DishNutrition(dishData: dishData),
          ],
        ),
      ),
    );
  }
}