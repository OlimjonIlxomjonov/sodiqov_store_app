import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_template/core/commons/assets/app_vectors.dart';
import 'package:my_template/core/routes/route_generator.dart';
import 'package:my_template/core/utils/responsiveness/app_responsiveness.dart';
import 'package:my_template/features/home/presentation/screens/home_page.dart';
import 'package:my_template/features/splash/presentation/widget/animated_text.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _textController;
  late AnimationController _logoController;

  late Animation<double> _logoOpacity;
  late Animation<double> _logoScale;

  final String _text = 'Sodiqov Store';

  @override
  void initState() {
    super.initState();

    _textController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _text.length * 100),
    )..forward();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _logoOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    _logoScale = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _textController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _logoController.forward();
      }
    });

    _logoController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        AppRoute.open(HomePage());
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _logoController,
              builder: (context, child) {
                return Opacity(
                  opacity: _logoOpacity.value,
                  child: Transform.scale(scale: _logoScale.value, child: child),
                );
              },
              child: SvgPicture.asset(AppVectors.appLogo, width: appW(100)),
            ),
            AnimatedText(controller: _textController, text: _text),
          ],
        ),
      ),
    );
  }
}
