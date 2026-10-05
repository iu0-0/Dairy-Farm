import 'package:flutter/material.dart';
import '../utils/smooth_page_route.dart';
import '../utils/user_session.dart';
import '../screens/home_screen.dart';
import '../screens/products_screen.dart';
import '../screens/animal_listing_screen.dart';
import '../screens/animal_gallery_screen.dart';
import '../screens/breed_catalog_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/about_screen.dart';
import 'cow_head_icon.dart';

// ──────────────────────────────────────────────────────────────
// UserDrawer — Dedicated Customer & Visitor Drawer Navigation
// ──────────────────────────────────────────────────────────────
class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRouteName = ModalRoute.of(context)?.settings.name;

    return Drawer(
      backgroundColor: const Color(0xFFEFF6F1),
      child: Column(
        children: [
          // ── User Drawer Header ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0C3823), Color(0xFF166534)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
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
                          'assets/images/krishna_logo.png',
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
                            'user@krishnadairy.com',
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
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '🌱 Verified Customer Portal',
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

          // ── Customer-Only Navigation Menu Items ──
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.home_outlined,
                  title: 'Farm Home',
                  subtitle: 'Dashboard & latest announcements',
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
                  icon: Icons.shopping_bag_outlined,
                  title: 'Buy Dairy Products',
                  subtitle: 'Pure Milk, Ghee, Butter, Paneer & Dahi',
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
                  icon: Icons.pets_outlined,
                  customLeading: const CowHeadIcon(size: 20, color: Color(0xFF0C3823)),
                  title: 'Our Livestock',
                  subtitle: 'Explore active cattle & herd info',
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
                  subtitle: 'Farm photos & cattle inspection videos',
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
                  subtitle: 'Gir Cow, Holstein Friesian, Murrah',
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
                const Divider(height: 20, color: Color(0xFFF3F4F6)),
                _buildDrawerItem(
                  context,
                  icon: Icons.person_outline,
                  title: 'My Customer Profile',
                  subtitle: 'Delivery address & order history',
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
                _buildDrawerItem(
                  context,
                  icon: Icons.info_outline,
                  title: 'About Krishna Dairy',
                  subtitle: 'Farm story, location & contacts',
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

          // ── Footer — Logout Only ──
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFFF9FAFB),
              border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
            ),
            child: Row(
              children: [
                const Icon(Icons.verified_user_outlined, size: 16, color: Color(0xFF16A34A)),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Krishna Dairy Customer App v2.4.0',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    globalUserSession.setRole(UserRole.user);
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
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
    Widget? customLeading,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFD1FAE5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: customLeading ?? Icon(icon, size: 20, color: const Color(0xFF0C3823)),
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
