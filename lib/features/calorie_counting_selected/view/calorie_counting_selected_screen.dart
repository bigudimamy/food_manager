import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_manager/features/class/products_class.dart';
import 'package:food_manager/features/widgets/drawer_widget.dart';


class CalorieCountingSelected extends StatefulWidget {
  final List<String> selectedProductIds;
  const CalorieCountingSelected({super.key, required this.selectedProductIds});

  @override
  State<CalorieCountingSelected> createState() => _CalorieCountingSelectedState();
}

class _CalorieCountingSelectedState extends State<CalorieCountingSelected>{

  List<Product> products = [];
  List<double> currentValues = [];
  double totalFats = 0.0;
  double totalProteins = 0.0;
  double totalCarbs = 0.0;
  double totalCalories = 0.0;

  @override
  void initState() {
    super.initState();
    fetchProductsFromFirestore().then((_) {
    });
  }

  Future<void> fetchProductsFromFirestore() async {
    // Извлекаем список id продуктов из selectedProductIds
    List<String> productIds = widget.selectedProductIds;

    // Создаем список запросов для получения продуктов по их id
    List<Future<DocumentSnapshot>> futures = productIds.map((productId) {
      return FirebaseFirestore.instance
          .collection('products')
          .doc(productId)
          .get();
    }).toList();

    // Получаем все продукты по их id
    List<DocumentSnapshot> snapshots = await Future.wait(futures);

    // Создаем список объектов Product из полученных данных
    List<Product> products = [];
    List<double> currentValues = [];
    for (DocumentSnapshot snapshot in snapshots) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        Product product = Product(
          name: data['product_name'],
          fats: data['fats'],
          proteins: data['proteins'],
          carbs: data['carbs'],
          calories: data['calories'],
        );
        products.add(product);
        currentValues.add(0.1);
      }
    }

    // Обновляем состояние products новым списком
    setState(() {
      this.products = products;
      this.currentValues = currentValues;
    });
  }

  void calculateTotalValues() {
    totalFats = 0.0;
    totalProteins = 0.0;
    totalCarbs = 0.0;
    totalCalories = 0.0;

    for (int i = 0; i < products.length; i++) {
      totalFats += (products[i].fats * currentValues[i]).roundToDouble();
      totalProteins += (products[i].proteins * currentValues[i]).roundToDouble();
      totalCarbs += (products[i].carbs * currentValues[i]).roundToDouble();
      totalCalories += (products[i].calories * currentValues[i]).roundToDouble();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Калькулятор калорий',
        ),
      ),
      drawer: const DrawerWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
        Text('Установите вес для продуктов',
            style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Text('Для этого используйте слайдер',
            style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Expanded(
          child: ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Center(
                child: ListTile(
                  title: Text(products[index].name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge),
                  subtitle: Row(
                    children: [
                      Expanded(
                          child: Slider(
                            value: currentValues[index].clamp(0.1, 2.0),
                            min: 0.1,
                            max: 2.0,
                            divisions: 19,
                            label: currentValues[index].toStringAsFixed(1),
                            onChanged: (value) {
                              setState(() {
                                currentValues[index] = value;
                                calculateTotalValues();
                              });
                            },
                          ),
                      ),
                      Text(
                        currentValues[index].toStringAsFixed(1),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        ' кг',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        
        Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.02,
            bottom: MediaQuery.of(context).size.height * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Жиры', style: Theme.of(context).textTheme.bodyMedium),
                  Text(totalFats.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Белки', style: Theme.of(context).textTheme.bodyMedium),
                  Text(totalProteins.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Углеводы',
                      style: Theme.of(context).textTheme.bodyMedium),
                  Text(totalCarbs.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Калорийность',
                      style: Theme.of(context).textTheme.bodyMedium),
                  Text(totalCalories.toStringAsFixed(0),
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ],
          ),
        ),
        
      ]),
    );
  }
}
    