import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_manager/features/dishes_list/widgets/widgets.dart';
import 'package:food_manager/features/widgets/drawer_widget.dart';

class DishesListScreen extends StatefulWidget {
  const DishesListScreen({super.key});

  @override
  State<DishesListScreen> createState() => _DishesListScreenState();
}

class _DishesListScreenState extends State<DishesListScreen> {

  List<String> dishesID = [];

  Future getDishesID() async {
    await FirebaseFirestore.instance.collection('dishes').get().then(
          (snapshot) => snapshot.docs.forEach((element) {
            dishesID.add(element.reference.id);
          }),
    );
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text(
          'Блюда', 
        ),
      ),

      drawer: const DrawerWidget(),

      body: FutureBuilder(
        future: getDishesID(),
        builder: ((context, snapshot) {
          return ListView.builder(
            itemCount: dishesID.length,
            itemBuilder: (context, index) {
              return DishesTile(dishID: dishesID[index]);
            }
          ); 
        }),
      )
    );
  }
}



