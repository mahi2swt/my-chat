//splash screen
import 'dart:developer';
import 'package:example/apis/apis.dart';
import 'package:example/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _scale = 0.0;

  @override
  void initState() {
    animate();
    super.initState();
  }

  Future<void> animate() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _scale = _scale == 0.0 ? 0.6 : 0.0;
    });
    if (Apis.auth.currentUser != null) {
      log('user: ${Apis.auth.currentUser}');
      await Future.delayed(const Duration(milliseconds: 1000)).then(
        (value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) {
              return const HomeScreen();
            },
          ),
        ),
      );
    } else {
      await Future.delayed(const Duration(milliseconds: 1000)).then(
        (value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: _scale),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              builder: (BuildContext context, double scale, Widget? child) {
                return Transform.scale(
                  scale: scale,
                  child: child,
                );
              },
              child: SvgPicture.asset('assets/chat.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
