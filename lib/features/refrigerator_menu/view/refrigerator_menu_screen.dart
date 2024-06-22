import 'package:flutter/material.dart';
import 'package:food_manager/features/widgets/drawer_widget.dart';
import 'package:food_manager/features/refrigerator_menu/widgets/widgets.dart';

class RefrigeratorMenu extends StatefulWidget {
  const RefrigeratorMenu({super.key});

  @override
  State<RefrigeratorMenu> createState() => _RefrigeratorMenuState();
}

class _RefrigeratorMenuState extends State<RefrigeratorMenu> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final menuCreated = args?['menuCreated'] as bool? ?? false;
    final filteredDishesIDDynamic = args?['filteredDishesID'] as List<dynamic>?;
    final filteredDishesID = filteredDishesIDDynamic != null
        ? filteredDishesIDDynamic.cast<String>().toList()
        : [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Блюда из холодильника'),
      ),
      drawer: const DrawerWidget(),
      body: Center(
        child: menuCreated
            ? ListView.builder(
                itemCount: filteredDishesID.length,
                itemBuilder: (context, index) {
                  return RefrigeratorMenuTile(dishID: filteredDishesID[index]);
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
                  Text('подобранные для вас блюда',
                      style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text('на основе имеющихся у вас продуктов',
                      style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text('Вы еще не указывали продукты',
                      style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Text('Чтобы подобрать блюда из холодильника',
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
                      Navigator.of(context).pushNamed('/refrigerator');
                    },
                    child: Text('Подобрать блюда',
                        style: Theme.of(context).textTheme.labelSmall),
                  ),
                ],
              ),
      ),
    );
  }
}
