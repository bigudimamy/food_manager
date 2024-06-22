import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_manager/firebase_options.dart';
import 'package:food_manager/food_manager.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const FoodManager());
}