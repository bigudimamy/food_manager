import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_manager/features/products/widgets/widgets.dart';
import 'package:food_manager/features/widgets/drawer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<String> filteredDishesID = [];
  bool menuCreated = false;

  @override
  void initState() {
    super.initState();
    getMenu();
  }

  Future<void> getMenu() async {
    // Получить ссылку на SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Получить список ID блюд из SharedPreferences
    final dishesJson = prefs.getString('filteredDishesID') ?? '[]';

    // Преобразовать JSON-строку обратно в список
    final filteredDishesID = jsonDecode(dishesJson);

    // Получить значение menuCreated из SharedPreferences
    final menuCreated = prefs.getBool('menuCreated') ?? false;

    /// Использовать полученные данные
    setState(() {
      this.filteredDishesID = filteredDishesID.cast<String>();
      this.menuCreated = menuCreated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Мои продукты'),
        ),
        drawer: const DrawerWidget(),
        body: Center(
          child: menuCreated
              ? ListView.builder(
                  itemCount: filteredDishesID.length,
                  itemBuilder: (context, index) {
                    return ProductsTile(dishID: filteredDishesID[index]);
                  })
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Здравствуйте!',
                        style: Theme.of(context).textTheme.bodyLarge),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Text('Здесь будут отображаться',
                        style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text('продукты необходимые',
                        style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text('для приготовления блюд',
                        style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text('из вашего индивидуального меню',
                        style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text('Оно пока еще не сформировано',
                        style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text('Чтобы сформировать ваше',
                        style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text('индивидуальное меню',
                        style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text('нажмите на кнопку ниже',
                        style: Theme.of(context).textTheme.bodyMedium),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    const Icon(
                      Icons.keyboard_double_arrow_down_rounded,
                      color: Colors.black,
                      size: 40,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/menuCreate');
                      },
                      child: Text('Создать меню',
                          style: Theme.of(context).textTheme.labelSmall),
                    ),
                  ],
                ),
        ));
  }
}