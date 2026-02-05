import 'package:flutter/material.dart';
import 'package:grocceries_app_flutter_firebase/core/constants/app_constants.dart';
import 'package:grocceries_app_flutter_firebase/core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(AppConstants.routeOnboarding);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppConstants.assetIcSplash,
                height: 120,
                width: 120,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.restaurant,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                AppConstants.appName,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                AppConstants.appTagline,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
