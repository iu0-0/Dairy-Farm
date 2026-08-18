import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../utils/smooth_page_route.dart';
import '../screens/animal_listing_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';

// ─────────────────────────────────────────────────────────────
// Shared Bottom Navigation Bar
//  index 0 = Animals, 1 = Home, 2 = Profile
// ─────────────────────────────────────────────────────────────

class DairyBottomNavBar extends StatelessWidget {
  final int selectedIndex; // 0=Animals, 1=Home, 2=Profile

  const DairyBottomNavBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      decoration: BoxDecoration(
        color: AppTheme.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 14,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            index: 0,
            icon: Icons.pets,
            label: 'Animals',
            selectedIndex: selectedIndex,
            onTap: () => _navigate(context, 0),
          ),
          _NavItem(
            index: 1,
            icon: Icons.home_rounded,
            label: 'Home',
            selectedIndex: selectedIndex,
            onTap: () => _navigate(context, 1),
          ),
          _NavItem(
            index: 2,
            icon: Icons.person_outline,
            label: 'Profile',
            selectedIndex: selectedIndex,
            onTap: () => _navigate(context, 2),
          ),
        ],
      ),
    );
  }

  void _navigate(BuildContext context, int index) {
    if (index == selectedIndex) return;
    Widget targetPage;
    RouteSettings settings;
    switch (index) {
      case 0:
        targetPage = const AnimalListingScreen();
        settings = const RouteSettings(name: '/animals');
        break;
      case 1:
        targetPage = const HomeScreen();
        settings = const RouteSettings(name: '/home');
        break;
      case 2:
        targetPage = const ProfileScreen();
        settings = const RouteSettings(name: '/profile');
        break;
      default:
        return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      SmoothPageRoute(page: targetPage, settings: settings),
      (r) => false,
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavItem({
    required this.index,
    required this.selectedIndex,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: isSelected
                  ? const EdgeInsets.all(6)
                  : EdgeInsets.zero,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.accentSoft
                    : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 22,
                color: isSelected ? AppTheme.primary : AppTheme.navBarUnselected,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                color: isSelected ? Colors.white : AppTheme.navBarUnselected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
