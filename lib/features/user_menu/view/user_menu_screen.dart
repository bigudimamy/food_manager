import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_manager/features/widgets/drawer_widget.dart';
import 'package:food_manager/features/user_menu/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserMenu extends StatefulWidget {
  const UserMenu({super.key});

  @override
  State<UserMenu> createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {

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
        title: const Text('Мое меню'),
      ),
      drawer: const DrawerWidget(),
      body: Center(
        child: menuCreated
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredDishesID.length,
                      itemBuilder: (context, index) {
                        return MenuTile(dishID: filteredDishesID[index]);
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.005,
                      bottom: MediaQuery.of(context).size.height * 0.005,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/menuCreate');
                      },
                      child: Text('Новое меню',
                          style: Theme.of(context).textTheme.labelSmall),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Здравствуйте!',
                      style: Theme.of(context).textTheme.bodyLarge),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Text('Здесь будет отображаться',
                      style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text('ваше индивидуальое меню',
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
                  const Icon(Icons.keyboard_double_arrow_down_rounded, color: Colors.black, size: 40,),
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
      ),
    );
  }
}