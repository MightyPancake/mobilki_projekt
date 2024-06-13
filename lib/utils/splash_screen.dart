import 'package:flutter/material.dart';
import 'package:proj/main.dart';
import 'package:proj/utils/themes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();

    // Navigate to home after the animation
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myTheme.colorScheme.primary,
      body: Center(
        child: Opacity(
          opacity: _animation.value,
          child: Image.asset(
            'assets/icon/friendiary-logo.png',
            width: 200.0,
            height: 200.0,
          ),
        ),
      ),
    );
  }
}
