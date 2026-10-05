import 'package:flutter/material.dart';
import '../utils/smooth_page_route.dart';
import '../utils/user_session.dart';
import '../screens/admin_panel_screen.dart';
import 'cow_head_icon.dart';

// ──────────────────────────────────────────────────────────────
// AdminDrawer — Dedicated Executive Admin Drawer Navigation
// ──────────────────────────────────────────────────────────────
class AdminDrawer extends StatelessWidget {
  final Function(int tabIndex)? onSelectTab;
  final int currentTabIndex;

  const AdminDrawer({
    super.key,
    this.onSelectTab,
    this.currentTabIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
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
                    Stack(
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
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Color(0xFF0C3823),
                              shape: BoxShape.circle,
                            ),
                            child: const Text('👑', style: TextStyle(fontSize: 10)),
                          ),
                        ),
                      ],
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

          // ── Admin-Only Management Menu Items ──
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              children: [
                _buildAdminDrawerItem(
                  context,
                  icon: Icons.dashboard_outlined,
                  title: 'Executive Dashboard',
                  subtitle: 'KPI metrics, revenue & yield overview',
                  tabIndex: 0,
                ),
                _buildAdminDrawerItem(
                  context,
                  icon: Icons.pets_outlined,
                  title: 'Herd Livestock Control',
                  subtitle: 'Add, edit, delete & filter cattle',
                  tabIndex: 1,
                ),
                _buildAdminDrawerItem(
                  context,
                  icon: Icons.water_drop_outlined,
                  title: 'Milk Yield Collection',
                  subtitle: 'Record morning/evening yields & fat %',
                  tabIndex: 2,
                ),
                _buildAdminDrawerItem(
                  context,
                  icon: Icons.grass_outlined,
                  title: 'Feed & Fodder Inventory',
                  subtitle: 'Stock intake, supply levels & budgets',
                  tabIndex: 3,
                ),
                _buildAdminDrawerItem(
                  context,
                  icon: Icons.sell_outlined,
                  title: 'Storefront Rate Manager',
                  subtitle: 'Configure product pricing & availability',
                  tabIndex: 4,
                ),
                _buildAdminDrawerItem(
                  context,
                  icon: Icons.people_outline,
                  title: 'Staff Roster & Roles',
                  subtitle: 'Register workers, set roles & permissions',
                  tabIndex: 5,
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

  Widget _buildAdminDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required int tabIndex,
  }) {
    final isSelected = currentTabIndex == tabIndex;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF0C3823).withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: isSelected ? Border.all(color: const Color(0xFF0C3823).withValues(alpha: 0.3)) : null,
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0C3823) : const Color(0xFF0C3823).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: tabIndex == 1
              ? CowHeadIcon(
                  size: 20,
                  color: isSelected ? Colors.white : const Color(0xFF0C3823),
                )
              : Icon(
                  icon,
                  size: 20,
                  color: isSelected ? Colors.white : const Color(0xFF0C3823),
                ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
            color: isSelected ? const Color(0xFF0C3823) : const Color(0xFF1F2937),
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF6B7280),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          size: 18,
          color: isSelected ? const Color(0xFF0C3823) : const Color(0xFF9CA3AF),
        ),
        onTap: () {
          Navigator.pop(context);
          if (onSelectTab != null) {
            onSelectTab!(tabIndex);
          } else {
            Navigator.pushReplacement(
              context,
              SmoothPageRoute(
                page: AdminPanelScreen(initialTabIndex: tabIndex),
                settings: const RouteSettings(name: '/admin'),
              ),
            );
          }
        },
      ),
    );
  }
}
