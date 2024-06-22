import 'package:food_manager/features/calorie_counting/calorie_counting.dart';
import 'package:food_manager/features/dish_single/dish_single.dart';
import 'package:food_manager/features/dishes_list/dishes_list.dart';
import 'package:food_manager/features/menu_create/menu_create.dart';
import 'package:food_manager/features/products/products.dart';
import 'package:food_manager/features/refrigerator/refrigerator.dart';
import 'package:food_manager/features/refrigerator_menu/refrigerator_menu.dart';
import 'package:food_manager/features/user_menu/user_menu.dart';


final routes = {
  '/dishes' : (context) => const DishesListScreen(),
  '/dish' : (context) => const DishScreen(),
  '/products' : (context) => const Products(),
  '/calorieCounting' : (context) => const CalorieCounting(),
  '/menuCreate' : (context) => const MenuCreate(),
  '/userMenu' : (context) => const UserMenu(),
  '/refrigerator' : (context) => const RefrigeratorCreate(),
  '/refrigeratorMenu' : (context) => const RefrigeratorMenu(),
};