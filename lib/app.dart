import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grocceries_app_flutter_firebase/core/constants/app_constants.dart';
import 'package:grocceries_app_flutter_firebase/core/theme/app_theme.dart';
import 'package:grocceries_app_flutter_firebase/features/auth/presentation/screens/login_screen.dart';
import 'package:grocceries_app_flutter_firebase/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:grocceries_app_flutter_firebase/features/auth/presentation/screens/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.light,
      locale: const Locale('tr', 'TR'),
      supportedLocales: const [
        Locale('tr', 'TR'),
        Locale('en', 'US'),
      ],
      initialRoute: AppConstants.routeSplash,
      routes: {
        AppConstants.routeSplash: (_) => const SplashScreen(),
        AppConstants.routeOnboarding: (_) => const OnboardingScreen(),
        AppConstants.routeLogin: (_) => const LoginScreen(),
      },
      onGenerateRoute: (settings) {
        // Placeholder for routes not yet implemented
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: Text(settings.name ?? '')),
            body: Center(child: Text('Sayfa: ${settings.name}')),
          ),
        );
      },
    );
  }
}
