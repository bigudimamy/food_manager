import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  fontFamily: 'TitilliumWeb',
  primaryColor: const Color.fromARGB(255, 22, 20, 21),
  scaffoldBackgroundColor: const Color.fromARGB(255, 251, 248, 248),
  dividerColor: const Color.fromARGB(255, 22, 20, 21),
  brightness: Brightness.light,

  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Color.fromARGB(255, 251, 248, 248),
    scrolledUnderElevation: 0.0,
    iconTheme: IconThemeData(
      size: 35,
      color: Color.fromARGB(255, 22, 20, 21),
    ),

    titleTextStyle: TextStyle(
      color: Color.fromARGB(255, 22, 20, 21),
      fontSize: 22,
      fontWeight: FontWeight.w700,
    ),
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Color.fromARGB(255, 22, 20, 21),
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    
    bodyMedium: TextStyle(
      color: Color.fromARGB(255, 22, 20, 21),
      fontSize: 15,
      fontWeight: FontWeight.w400,
    ),

    labelSmall: TextStyle(
      color: Color.fromARGB(255, 251, 248, 248),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),

    headlineLarge: TextStyle(
      color: Color.fromARGB(255, 251, 248, 248),
      fontSize: 72,
      fontWeight: FontWeight.bold,
    ),
  ),

  drawerTheme: const DrawerThemeData(
    backgroundColor: Color.fromARGB(255, 251, 248, 248),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const MaterialStatePropertyAll<Color>(Color.fromARGB(255, 22, 20, 21)),
      shape:MaterialStatePropertyAll<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    ),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color.fromARGB(255, 22, 20, 21),
    foregroundColor: Color.fromARGB(255, 251, 248, 248),
    shape: CircleBorder(),
  ),

  cardTheme: CardTheme(
    color: const Color.fromARGB(255, 239, 236, 236),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
    ),
  ),

  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.all(const Color.fromARGB(255, 22, 20, 21)),
    thumbColor: MaterialStateProperty.all(const Color.fromARGB(255, 251, 248, 248)),
    trackOutlineWidth:  MaterialStateProperty.all(0.0),
  ),

  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color.fromARGB(255, 251, 248, 248),
  ),

  iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 251, 248, 248),
    size: 30
  ),

  sliderTheme: const SliderThemeData(
    thumbColor: Color.fromARGB(255, 22, 20, 21), 
    overlayColor: Color.fromARGB(155, 22, 20, 21),
    activeTrackColor: Color.fromARGB(255, 22, 20, 21),
    inactiveTrackColor: Color.fromARGB(255, 239, 236, 236),
    valueIndicatorColor: Color.fromARGB(255, 22, 20, 21),
  ),

  dropdownMenuTheme: DropdownMenuThemeData(
    menuStyle: MenuStyle(
      backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 239, 236, 236)),
    )
  ),

  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(const Color.fromARGB(255, 251, 248, 248)),
    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.disabled)) {
          return const Color.fromARGB(255, 58, 60, 66);
        }
        if (states.contains(MaterialState.selected)) {
          return const Color.fromARGB(255, 22, 20, 21);
        }
        return const Color.fromARGB(255, 251, 248, 248);
      }
    ),
  ),

  expansionTileTheme: ExpansionTileThemeData(
    backgroundColor: const Color.fromARGB(255, 239, 236, 236),
    iconColor: const Color.fromARGB(255, 22, 20, 21),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    collapsedShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
  ),

);

final darkTheme = ThemeData(
  fontFamily: 'TitilliumWeb',
  primaryColor: const Color.fromARGB(255, 251, 248, 248),
  scaffoldBackgroundColor: const Color.fromARGB(255, 22, 20, 21),
  dividerColor: const Color.fromARGB(255, 251, 248, 248),
  brightness: Brightness.dark,

  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: Color.fromARGB(255, 22, 20, 21),
    scrolledUnderElevation: 0.0,
    iconTheme: IconThemeData(
      size: 35,
      color: Color.fromARGB(255, 251, 248, 248),
    ),

    titleTextStyle: TextStyle(
      color: Color.fromARGB(255, 251, 248, 248),
      fontSize: 22,
      fontWeight: FontWeight.w700,
    ),
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Color.fromARGB(255, 251, 248, 248),
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    
    bodyMedium: TextStyle(
      color: Color.fromARGB(255, 251, 248, 248),
      fontSize: 15,
      fontWeight: FontWeight.w400,
    ),

    labelSmall: TextStyle(
      color: Color.fromARGB(255, 22, 20, 21),
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),

    headlineLarge: TextStyle(
      color: Color.fromARGB(255, 22, 20, 21),
      fontSize: 72,
      fontWeight: FontWeight.bold,
    ),
  ),

  drawerTheme: const DrawerThemeData(
    backgroundColor: Color.fromARGB(255, 22, 20, 21),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: const MaterialStatePropertyAll<Color>(Color.fromARGB(255, 251, 248, 248)),
      shape:MaterialStatePropertyAll<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    ),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color.fromARGB(255, 251, 248, 248),
    foregroundColor: Color.fromARGB(255, 22, 20, 21),
    shape: CircleBorder(),
  ),

  cardTheme: CardTheme(
    color: const Color.fromARGB(255, 37, 37, 37), 
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
    ),
  ),

  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.all(const Color.fromARGB(255, 251, 248, 248)),
    thumbColor: MaterialStateProperty.all(const Color.fromARGB(255, 22, 20, 21)),
    trackOutlineWidth:  MaterialStateProperty.all(0.0),
  ),

  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color.fromARGB(255, 22, 20, 21),
  ),

  iconTheme: const IconThemeData(
    color: Color.fromARGB(255, 22, 20, 21),
    size: 30
  ),

  sliderTheme: const SliderThemeData(
    thumbColor: Color.fromARGB(255, 251, 248, 248), 
    overlayColor: Color.fromARGB(155, 251, 248, 248),
    activeTrackColor: Color.fromARGB(255, 251, 248, 248),
    inactiveTrackColor: Color.fromARGB(255, 136, 136, 136),
    valueIndicatorColor: Color.fromARGB(255, 251, 248, 248),
  ),

  dropdownMenuTheme: DropdownMenuThemeData(
    menuStyle: MenuStyle(
      backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 22, 20, 21)),
    )
  ),

  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all(const Color.fromARGB(255, 22, 20, 21)),
    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.disabled)) {
          return const Color.fromARGB(255, 37, 37, 37);
        }
        if (states.contains(MaterialState.selected)) {
          return const Color.fromARGB(255, 251, 248, 248);
        }
        return const Color.fromARGB(255, 22, 20, 21);
      }
    ),
  ),

  expansionTileTheme: ExpansionTileThemeData(
    backgroundColor: const Color.fromARGB(255, 37, 37, 37),
    iconColor: const Color.fromARGB(255, 251, 248, 248),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
    collapsedShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
  ),

);
