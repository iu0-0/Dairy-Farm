import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/animal_listing_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/about_screen.dart';
import 'screens/admin_panel_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const DairyFarmApp());
}

class DairyFarmApp extends StatelessWidget {
  const DairyFarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Krishna Dairy Farm',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        '/':        (_) => const SplashScreen(),
        '/login':   (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/home':    (_) => const HomeScreen(),
        '/animals': (_) => const AnimalListingScreen(),
        '/profile': (_) => const ProfileScreen(),
        '/about':   (_) => const AboutScreen(),
        '/admin':   (_) => const AdminPanelScreen(),
      },
    );
  }
}
