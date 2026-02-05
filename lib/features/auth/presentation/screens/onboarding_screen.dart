import 'package:flutter/material.dart';
import 'package:grocceries_app_flutter_firebase/core/constants/app_constants.dart';
import 'package:grocceries_app_flutter_firebase/core/theme/app_colors.dart';
import 'package:grocceries_app_flutter_firebase/shared/widgets/app_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppConstants.assetOnboarding,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: AppColors.primary.withValues(alpha: 0.3)),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.6),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Image.asset(
                  AppConstants.assetIcSplash,
                  height: 56,
                  width: 56,
                  color: Colors.white,
                  errorBuilder: (_, __, ___) => const Icon(Icons.restaurant, size: 56, color: Colors.white),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Welcome to our store',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Get your groceries in as fast as one hour',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: AppButton(
                    label: 'Get Started',
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed(AppConstants.routeLogin);
                    },
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
