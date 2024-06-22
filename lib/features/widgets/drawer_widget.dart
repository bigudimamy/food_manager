import 'package:flutter/material.dart';
import 'package:food_manager/features/widgets/switch.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 75,
            child: DrawerHeader(
                child: Text(
              'Менеджер питания',
              style: Theme.of(context).textTheme.bodyLarge,
            )),
          ),
          ListTile(
            title: Text('Все блюда',
                style: Theme.of(context).textTheme.bodyMedium),
            onTap: () {
              Navigator.of(context).pushNamed(
                '/dishes',
              );
            },
          ),
          ListTile(
            title:
                Text('Мое меню', style: Theme.of(context).textTheme.bodyMedium),
            onTap: () {
              Navigator.of(context).pushNamed(
                '/userMenu',
              );
            },
          ),
          ListTile(
            title: Text('Новое меню',
                style: Theme.of(context).textTheme.bodyMedium),
            onTap: () {
              Navigator.of(context).pushNamed(
                '/menuCreate',
              );
            },
          ),
          ListTile(
            title: Text('Мой холодильник',
                style: Theme.of(context).textTheme.bodyMedium),
            onTap: () {
              Navigator.of(context).pushNamed(
                '/refrigerator',
              );
            },
          ),
          ListTile(
            title: Text('Мои продукты',
                style: Theme.of(context).textTheme.bodyMedium),
            onTap: () {
              Navigator.of(context).pushNamed(
                '/products',
              );
            },
          ),
          ListTile(
            title: Text('Калькулятор калорий',
                style: Theme.of(context).textTheme.bodyMedium),
            onTap: () {
              Navigator.of(context).pushNamed(
                '/calorieCounting',
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.33),
          const SwitchDrawerWidget(),
        ],
      ),
    );
  }
}
