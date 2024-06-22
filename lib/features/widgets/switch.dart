import 'package:flutter/material.dart';
import 'package:food_manager/theme/theme_provider.dart';

class SwitchDrawerWidget extends StatefulWidget {
  const SwitchDrawerWidget({super.key});

  @override
  State<SwitchDrawerWidget> createState() => _SwitchDrawerWidgetState();
}

class _SwitchDrawerWidgetState extends State<SwitchDrawerWidget> {

  @override
  Widget build(BuildContext context){
    final themeProvider = ThemeProvider.of(context);
    return SwitchListTile(
      title: Text(
        'Темная тема',
        style: Theme.of(context).textTheme.bodyMedium
      ),
      value: themeProvider.isDarkTheme,
      onChanged: themeProvider.toggleTheme,
    );
  }
}