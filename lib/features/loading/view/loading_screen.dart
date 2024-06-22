import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _progress = 1.0;
      });
      Navigator.pushReplacementNamed(context, '/dishes');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Text('Менеджер питания',
                  style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 16),
              SizedBox(
                width: 100,
                height: 5,
                child: LinearProgressIndicator(
                  backgroundColor: const Color.fromARGB(255, 251, 248, 248),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 22, 20, 21)),
                  value: _progress, 
                ),
              ),
            ]
        ),
      ),
    );
  }
}