import 'package:flutter/material.dart';
import '../utils/smooth_page_route.dart';
import '../screens/admin_panel_screen.dart';
import '../screens/home_screen.dart';

// ──────────────────────────────────────────────────────────────
// AdminDrawer — Dedicated Executive Admin Drawer Navigation
// ──────────────────────────────────────────────────────────────
class AdminDrawer extends StatelessWidget {
  const AdminDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRouteName = ModalRoute.of(context)?.settings.name;

    return Drawer(
      backgroundColor: const Color(0xFFEFF6F1),
      child: Column(
        children: [
          // ── Admin Drawer Header ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0C3823), Color(0xFF14532D)],
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
                      backgroundColor: const Color(0xFF86EFAC).withValues(alpha: 0.3),
                      child: const Text('👑', style: TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Admin Portal',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'admin@krishnadairy.com',
                            style: TextStyle(
                              color: Color(0xFF86EFAC),
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
                    color: const Color(0xFF22C55E).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF22C55E)),
                  ),
                  child: const Text(
                    '🛡️ Executive Command Authority',
                    style: TextStyle(
                      color: Color(0xFF86EFAC),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Admin Management Menu Items ──
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                _buildAdminDrawerItem(
                  context,
                  icon: Icons.dashboard_outlined,
                  title: 'Executive Dashboard',
                  subtitle: 'KPI metrics, revenue & yield overview',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRouteName == '/admin') return;
                    Navigator.pushReplacement(
                      context,
                      SmoothPageRoute(
                        page: const AdminPanelScreen(),
                        settings: const RouteSettings(name: '/admin'),
                      ),
                    );
                  },
                ),
                _buildAdminDrawerItem(
                  context,
                  icon: Icons.pets_outlined,
                  title: 'Herd Livestock Control',
                  subtitle: 'Add, edit, delete & filter cattle',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRouteName == '/admin') return;
                    Navigator.pushReplacement(
                      context,
                      SmoothPageRoute(
                        page: const AdminPanelScreen(),
                        settings: const RouteSettings(name: '/admin'),
                      ),
                    );
                  },
                ),
                _buildAdminDrawerItem(
                  context,
                  icon: Icons.water_drop_outlined,
                  title: 'Milk Yield Collection',
                  subtitle: 'Record morning/evening yields & fat %',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRouteName == '/admin') return;
                    Navigator.pushReplacement(
                      context,
                      SmoothPageRoute(
                        page: const AdminPanelScreen(),
                        settings: const RouteSettings(name: '/admin'),
                      ),
                    );
                  },
                ),
                _buildAdminDrawerItem(
                  context,
                  icon: Icons.grass_outlined,
                  title: 'Feed & Fodder Inventory',
                  subtitle: 'Stock intake, supply levels & budgets',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRouteName == '/admin') return;
                    Navigator.pushReplacement(
                      context,
                      SmoothPageRoute(
                        page: const AdminPanelScreen(),
                        settings: const RouteSettings(name: '/admin'),
                      ),
                    );
                  },
                ),
                _buildAdminDrawerItem(
                  context,
                  icon: Icons.sell_outlined,
                  title: 'Storefront Rate Manager',
                  subtitle: 'Configure product pricing & availability',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRouteName == '/admin') return;
                    Navigator.pushReplacement(
                      context,
                      SmoothPageRoute(
                        page: const AdminPanelScreen(),
                        settings: const RouteSettings(name: '/admin'),
                      ),
                    );
                  },
                ),
                _buildAdminDrawerItem(
                  context,
                  icon: Icons.people_outline,
                  title: 'Staff Roster & Roles',
                  subtitle: 'Register workers, set roles & permissions',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRouteName == '/admin') return;
                    Navigator.pushReplacement(
                      context,
                      SmoothPageRoute(
                        page: const AdminPanelScreen(),
                        settings: const RouteSettings(name: '/admin'),
                      ),
                    );
                  },
                ),
                const Divider(height: 20, color: Color(0xFFF3F4F6)),
                _buildAdminDrawerItem(
                  context,
                  icon: Icons.exit_to_app,
                  title: 'Switch to Customer App',
                  subtitle: 'Open standard customer storefront view',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      SmoothPageRoute(
                        page: const HomeScreen(),
                        settings: const RouteSettings(name: '/home'),
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
            child: Row(
              children: [
                const Icon(Icons.admin_panel_settings, size: 16, color: Color(0xFF0C3823)),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Krishna Dairy Admin Portal v2.4',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text(
                    'Logout Admin',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminDrawerItem(
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
          color: const Color(0xFF0C3823).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 20, color: const Color(0xFF0C3823)),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 13.5,
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
