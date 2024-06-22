import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_manager/features/calorie_counting_selected/calorie_counting_selected.dart';
import 'package:food_manager/features/widgets/drawer_widget.dart';


class CalorieCounting extends StatefulWidget {
  const CalorieCounting({super.key});

  @override
  State<CalorieCounting> createState() => _CalorieCountingState();
}

class _CalorieCountingState extends State<CalorieCounting> {

  // bool isChecked = false;
  List<String> ProdID = [];
  final Map<String, bool> _selectedProducts = {};
  List<String> selectedProductIds = [];
  List<String> filteredProductsID = [];
  String _selectedGroup = '';
  Map<String, String> groupKeyToNameMap = {
    'vegetable': 'Овощи',
    'cereal': 'Крупы',
    'flour': 'Мука и мучное',
    'milk': 'Молочные продукты',
    'cheese': 'Сыры и творог',
    'oil': 'Масла',
    'nut': 'Орехи и сухофрукты',
    'fruit': 'Фрукты',
    'berry': 'Ягоды',
    'mushroom': 'Грибы',
    'fish': 'Рыба и морепродукты',
    'meat': 'Мясные продукты',
    'egg': 'Яйца',
    'spice': 'Специи',
  };

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    await _getProductID();
    _selectedGroup = groupKeyToNameMap.values.first;
    _filterProductsByGroup(groupKeyToNameMap.keys.first);
  }

  Future<void> _getProductID() async {
    await FirebaseFirestore.instance.collection('products').get().then(
          (snapshot) => snapshot.docs.forEach((element) {
            setState(() {
              ProdID.add(element.reference.id);
            });
          }),
    );
  }

  void _filterProductsByGroup(String group) {
    filteredProductsID.clear();
    for (final productId in ProdID) {
      if (productId.startsWith(group)) {
        // Продукт принадлежит к выбранной группе
        // Добавляем его в filteredDishesID
        filteredProductsID.add(productId);
      }
    }
    setState(() {
      // Обновляем состояние, чтобы перерисовать GridView
    });
  }

  Widget GetIsChecked({required String ProductID}) {
    return Checkbox(
      value: _selectedProducts[ProductID] ?? false,
      onChanged: (value) {
        setState(() {
          _selectedProducts[ProductID] = value ?? false;
          if (value == true) {
            selectedProductIds.add(ProductID);
          } else {
            selectedProductIds.remove(ProductID);
          }
        });
      },
    );
  }

  Widget GetProductName({required String ProductID}) {
    // Получаем данные продукта из Firestore
    final DocumentReference productRef =
        FirebaseFirestore.instance.collection('products').doc(ProductID);

    return FutureBuilder<DocumentSnapshot>(
      future: productRef.get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Отображаем placeholder, пока данные загружаются
          return const Text('Загрузка...');
        }

        if (snapshot.hasData && snapshot.data!.exists) {
          // Получаем название продукта из данных
          final data = snapshot.data!.data() as Map<String, dynamic>;
          final productName = data['product_name'];

          return Text(productName);
        } else {
          // Отображаем ошибку, если данные недоступны
          return const Text('Ошибка загрузки');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Калькулятор калорий'),
        ),
        drawer: const DrawerWidget(),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text('Выберите интересующие вас продукты',
                  style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text('А затем нажмите на кнопку внизу экрана!',
                  style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.02,
                      right: MediaQuery.of(context).size.width * 0.02,
                    ),
                    child: Row(
                      children: [
                        for (final group in groupKeyToNameMap.values)
                          TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: group == _selectedGroup
                                    ? Theme.of(context).brightness ==
                                            Brightness.light
                                        ? const Color.fromARGB(255, 22, 20, 21)
                                        : const Color.fromARGB(
                                            255, 251, 248, 248)
                                    : Colors.transparent,
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectedGroup = group;
                                });
                                _filterProductsByGroup(groupKeyToNameMap.keys
                                    .firstWhere((key) =>
                                        groupKeyToNameMap[key] == group));
                              },
                              child: Text(
                                group,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                      color: group == _selectedGroup
                                          ? Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? const Color.fromARGB(
                                                  255, 251, 248, 248)
                                              : const Color.fromARGB(
                                                  255, 22, 20, 21)
                                          : Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? const Color.fromARGB(
                                                  255, 22, 20, 21)
                                              : const Color.fromARGB(
                                                  255, 251, 248, 248),
                                    ),
                              ))
                      ],
                    ),
                  )),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.03),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                    ),
                    itemCount: filteredProductsID.length,
                    itemBuilder: (context, index) {
                      final productId = filteredProductsID[index];
                      return Row(
                        children: [
                          GetIsChecked(ProductID: productId),
                          Expanded(
                            child: GetProductName(ProductID: productId),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.01),
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CalorieCountingSelected(
                          selectedProductIds: selectedProductIds,
                        ),
                      ),
                    );
                  },
                  child: Text('Продолжить',
                      style: Theme.of(context).textTheme.labelSmall),
                ),
              )
            ],
          ),
        ));
  }
}