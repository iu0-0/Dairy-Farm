import 'package:flutter/material.dart';
import '../utils/smooth_page_route.dart';
import '../screens/animal_gallery_screen.dart';
import '../screens/animal_listing_screen.dart';
import '../screens/breed_catalog_screen.dart';
import '../screens/feed_screen.dart';
import '../screens/health_screen.dart';
import '../screens/milk_yield_screen.dart';
import '../screens/products_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/home_screen.dart';
import '../screens/about_screen.dart';
import '../screens/admin_panel_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRouteName = ModalRoute.of(context)?.settings.name;

    return Drawer(
      backgroundColor: const Color(0xFFEFF6F1),
      child: Column(
        children: [
          // ── Drawer Header ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
            decoration: const BoxDecoration(
              color: Color(0xFF0C3823),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: const Color(0xFF86EFAC),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/dairy_logo.png',
                          height: 52,
                          width: 52,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Text(
                            'K',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0C3823),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Krishna Dairy Farm',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'karan@krishnadairy.com',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '★ Premium Farm Account',
                    style: TextStyle(
                      color: Color(0xFF86EFAC),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Navigation Menu Items ──
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.home_outlined,
                  title: 'Home',
                  subtitle: 'Farm dashboard & overview',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRouteName == '/home') return;
                    Navigator.pushReplacement(
                      context,
                      SmoothPageRoute(
                        page: const HomeScreen(),
                        settings: const RouteSettings(name: '/home'),
                      ),
                    );
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.pets,
                  title: 'All Animals',
                  subtitle: 'Manage cattle & livestock',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRouteName == '/animals') return;
                    Navigator.pushReplacement(
                      context,
                      SmoothPageRoute(
                        page: const AnimalListingScreen(),
                        settings: const RouteSettings(name: '/animals'),
                      ),
                    );
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.photo_library_outlined,
                  title: 'Animal Gallery',
                  subtitle: 'Photos & inspection videos',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRouteName == '/gallery') return;
                    Navigator.push(
                      context,
                      SmoothPageRoute(
                        page: const AnimalGalleryScreen(),
                        settings: const RouteSettings(name: '/gallery'),
                      ),
                    );
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.category_outlined,
                  title: 'Breeds Catalog',
                  subtitle: 'Holstein, Jersey, Gir, Murrah',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRouteName == '/breeds') return;
                    Navigator.push(
                      context,
                      SmoothPageRoute(
                        page: const BreedCatalogScreen(),
                        settings: const RouteSettings(name: '/breeds'),
                      ),
                    );
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.grass_outlined,
                  title: 'Feed Management',
                  subtitle: 'Stock levels & monthly cost analysis',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRouteName == '/feed') return;
                    Navigator.push(
                      context,
                      SmoothPageRoute(
                        page: const FeedScreen(),
                        settings: const RouteSettings(name: '/feed'),
                      ),
                    );
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.water_drop_outlined,
                  title: 'Milk Production',
                  subtitle: 'Daily yield & analytics',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRouteName == '/milk') return;
                    Navigator.push(
                      context,
                      SmoothPageRoute(
                        page: const MilkYieldScreen(),
                        settings: const RouteSettings(name: '/milk'),
                      ),
                    );
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.inventory_2_outlined,
                  title: 'Farm Products',
                  subtitle: 'Fresh Milk, Butter, Ghee, Paneer',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRouteName == '/products') return;
                    Navigator.push(
                      context,
                      SmoothPageRoute(
                        page: const ProductsScreen(),
                        settings: const RouteSettings(name: '/products'),
                      ),
                    );
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.health_and_safety_outlined,
                  title: 'Health & Vaccination',
                  subtitle: 'Herd wellness, alerts & medical tasks',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRouteName == '/health') return;
                    Navigator.push(
                      context,
                      SmoothPageRoute(
                        page: const HealthScreen(),
                        settings: const RouteSettings(name: '/health'),
                      ),
                    );
                  },
                ),
                const Divider(height: 20, color: Color(0xFFF3F4F6)),
                _buildDrawerItem(
                  context,
                  icon: Icons.admin_panel_settings_outlined,
                  title: 'Admin Control Center',
                  subtitle: 'Cattle, Staff, Prices & System Logs',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRouteName == '/admin') return;
                    Navigator.push(
                      context,
                      SmoothPageRoute(
                        page: const AdminPanelScreen(),
                        settings: const RouteSettings(name: '/admin'),
                      ),
                    );
                  },
                ),
                const Divider(height: 20, color: Color(0xFFF3F4F6)),
                _buildDrawerItem(
                  context,
                  icon: Icons.person_outline,
                  title: 'Profile',
                  subtitle: 'Manage farm profile & staff',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRouteName == '/profile') return;
                    Navigator.push(
                      context,
                      SmoothPageRoute(
                        page: const ProfileScreen(),
                        settings: const RouteSettings(name: '/profile'),
                      ),
                    );
                  },
                ),
                const Divider(height: 20, color: Color(0xFFF3F4F6)),
                _buildDrawerItem(
                  context,
                  icon: Icons.info_outline,
                  title: 'About Farm',
                  subtitle: 'Krishna Dairy Farm details & contact',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRouteName == '/about') return;
                    Navigator.push(
                      context,
                      SmoothPageRoute(
                        page: const AboutScreen(),
                        settings: const RouteSettings(name: '/about'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // ── Footer ──
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFF9FAFB),
            child: const Row(
              children: [
                Icon(Icons.shield_outlined, size: 16, color: Color(0xFF6B7280)),
                SizedBox(width: 8),
                Text(
                  'Krishna Dairy Farm v1.0.0',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFD1FAE5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 20, color: const Color(0xFF0C3823)),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1F2937),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 11,
          color: Color(0xFF6B7280),
        ),
      ),
      trailing: const Icon(Icons.chevron_right, size: 18, color: Color(0xFF9CA3AF)),
      onTap: onTap,
    );
  }
}
