import 'package:flutter/material.dart';
import 'package:food_manager/features/loading/loading.dart';
import 'package:food_manager/router/router.dart';
import 'package:food_manager/theme/theme.dart';
import 'package:food_manager/theme/theme_provider.dart';

class FoodManager extends StatefulWidget {
  const FoodManager({super.key});

  @override
  State<FoodManager> createState() => _FoodManagerState();
}

class _FoodManagerState extends State<FoodManager> {
  bool _isDarkTheme = false;

  @override
  void initState() {
    super.initState();
    _loadThemeSettings();
  }

  Future<void> _loadThemeSettings() async {
    final isDarkThemeEnabled = await ThemeProvider.isDarkThemeEnabled();
    setState(() {
      _isDarkTheme = isDarkThemeEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      isDarkTheme: _isDarkTheme,
      toggleTheme: toggleTheme,
      child: MaterialApp(
        title: 'Менеджер питания',
        theme: _isDarkTheme ? darkTheme : lightTheme,
        routes: routes,
        home: const SplashScreen(),
      ),
    );
  }

  void toggleTheme(bool value) {
    setState(() {
      _isDarkTheme = value;
    });
    ThemeProvider.setDarkTheme(value);
  }
}