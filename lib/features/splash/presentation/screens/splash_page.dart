import 'package:flutter/material.dart';
import 'package:my_template/core/routes/route_generator.dart';
import 'package:my_template/features/app_bottom_nav.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      AppRoute.open(AppBottomNav());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Logo here')));
  }
}
