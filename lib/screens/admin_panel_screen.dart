import 'package:flutter/material.dart';
import '../utils/user_session.dart';

// ──────────────────────────────────────────────────────────────
// AdminPanelScreen — Ultra-Premium Executive Control Center
// ──────────────────────────────────────────────────────────────
class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  // ── Design Tokens ─────────────────────────────────────────────
  static const Color _primaryGreen = Color(0xFF0C3823);
  static const Color _accentGreen = Color(0xFF22C55E);
  static const Color _lightBg = Color(0xFFEFF6F1);
  static const Color _cardBg = Colors.white;
  static const Color _textDark = Color(0xFF1F2937);
  static const Color _textMuted = Color(0xFF6B7280);

  // ── State Data (In-Memory Admin Management Database) ──────────
  final List<Map<String, dynamic>> _cattleList = [
    {
      'id': 'COW-101',
      'name': 'Kamdhenu',
      'breed': 'Gir Cow',
      'age': '4 Yrs',
      'milkYield': '16.5 L/day',
      'status': 'Milking',
      'health': 'Healthy',
      'photo': 'assets/images/gir_cow.png'
    },
    {
      'id': 'COW-102',
      'name': 'Gauri',
      'breed': 'Gir Cow',
      'age': '3.5 Yrs',
      'milkYield': '14.0 L/day',
      'status': 'Milking',
      'health': 'Healthy',
      'photo': 'assets/images/gir_cow.png'
    },
    {
      'id': 'HF-201',
      'name': 'Bella',
      'breed': 'Holstein Friesian',
      'age': '5 Yrs',
      'milkYield': '24.0 L/day',
      'status': 'Milking',
      'health': 'Healthy',
      'photo': 'assets/images/holstein_friesian.png'
    },
    {
      'id': 'HF-202',
      'name': 'Daisy',
      'breed': 'Holstein Friesian',
      'age': '3 Yrs',
      'milkYield': '21.5 L/day',
      'status': 'Milking',
      'health': 'Observation',
      'photo': 'assets/images/holstein_friesian.png'
    },
    {
      'id': 'JRS-301',
      'name': 'Lakshmi',
      'breed': 'Jersey Cow',
      'age': '4.5 Yrs',
      'milkYield': '18.0 L/day',
      'status': 'Dry',
      'health': 'Healthy',
      'photo': 'assets/images/jersey_cow.png'
    },
    {
      'id': 'BUF-401',
      'name': 'Kali',
      'breed': 'Murrah Buffalo',
      'age': '6 Yrs',
      'milkYield': '12.5 L/day',
      'status': 'Milking',
      'health': 'Healthy',
      'photo': 'assets/images/murrah_buffalo.png'
    },
  ];

  final List<Map<String, dynamic>> _milkYieldLogs = [
    {'session': 'Morning', 'time': '06:00 AM', 'qty': 184.5, 'cows': 38, 'fat': '4.5%'},
    {'session': 'Evening', 'time': '05:30 PM', 'qty': 127.5, 'cows': 38, 'fat': '4.6%'},
    {'session': 'Yesterday Morning', 'time': '06:00 AM', 'qty': 180.0, 'cows': 37, 'fat': '4.4%'},
    {'session': 'Yesterday Evening', 'time': '05:30 PM', 'qty': 125.0, 'cows': 37, 'fat': '4.5%'},
  ];

  final List<Map<String, dynamic>> _feedStockList = [
    {'name': 'Green Fodder (Napier Grass)', 'qty': '1,200 kg', 'status': 'High Stock', 'color': Colors.green},
    {'name': 'Dry Straw & Hay', 'qty': '850 kg', 'status': 'Good Stock', 'color': Colors.blue},
    {'name': 'Concentrate Feed Mix (Protein)', 'qty': '420 kg', 'status': 'Medium Stock', 'color': Colors.orange},
    {'name': 'Mineral Mixture & Calcium', 'qty': '65 kg', 'status': 'Low Stock Alert', 'color': Colors.red},
  ];

  final List<Map<String, dynamic>> _staffList = [
    {
      'name': 'Rahul Sharma',
      'role': 'Farm Owner & Admin',
      'phone': '+91 98765 43210',
      'shift': 'Full Authority',
      'status': 'Active',
      'avatar': 'RS'
    },
    {
      'name': 'Dr. Suresh Mehta',
      'role': 'Chief Veterinarian',
      'phone': '+91 98123 45678',
      'shift': 'On-Call / Daily Visit',
      'status': 'Active',
      'avatar': 'SM'
    },
    {
      'name': 'Vikram Singh',
      'role': 'Feed & Stock Manager',
      'phone': '+91 97654 32109',
      'shift': 'Morning Shift (6AM - 2PM)',
      'status': 'Active',
      'avatar': 'VS'
    },
    {
      'name': 'Anil Kumar',
      'role': 'Milking Supervisor',
      'phone': '+91 96543 21098',
      'shift': 'Double Shift (5AM & 5PM)',
      'status': 'Active',
      'avatar': 'AK'
    },
    {
      'name': 'Pooja Verma',
      'role': 'Quality Control & Lab',
      'phone': '+91 95432 10987',
      'shift': 'Day Shift (9AM - 5PM)',
      'status': 'Active',
      'avatar': 'PV'
    },
  ];

  final List<Map<String, dynamic>> _productList = [
    {
      'name': 'Raw Organic Whole Milk',
      'price': 65,
      'unit': 'Litre',
      'stock': '340 L available',
      'status': 'In Stock',
      'icon': Icons.water_drop
    },
    {
      'name': 'A2 Gir Cow Milk (Glass Bottle)',
      'price': 90,
      'unit': 'Litre',
      'stock': '120 L available',
      'status': 'In Stock',
      'icon': Icons.local_drink
    },
    {
      'name': 'Pure Desi Bilona Ghee',
      'price': 1450,
      'unit': 'Kg',
      'stock': '45 Kg in store',
      'status': 'In Stock',
      'icon': Icons.soup_kitchen
    },
    {
      'name': 'Fresh Malai Paneer',
      'price': 420,
      'unit': 'Kg',
      'stock': '25 Kg available',
      'status': 'In Stock',
      'icon': Icons.grid_view
    },
    {
      'name': 'Cultured Fresh Dahi (Curd)',
      'price': 80,
      'unit': 'Kg',
      'stock': '60 Kg available',
      'status': 'In Stock',
      'icon': Icons.rice_bowl
    },
  ];

  final List<Map<String, dynamic>> _auditLogs = [
    {
      'time': 'Just now',
      'user': 'Admin (Rahul)',
      'action': 'System check & cloud database backup completed',
      'type': 'system'
    },
    {
      'time': '12 mins ago',
      'user': 'Dr. Suresh Mehta',
      'action': 'Updated health observation for Daisy (Tag HF-202)',
      'type': 'health'
    },
    {
      'time': '45 mins ago',
      'user': 'Anil Kumar',
      'action': 'Recorded Morning Milk Collection: 184.5 Litres',
      'type': 'yield'
    },
    {
      'time': '2 hours ago',
      'user': 'Vikram Singh',
      'action': 'Received 500kg Green Fodder shipment',
      'type': 'feed'
    },
    {
      'time': '5 hours ago',
      'user': 'Admin (Rahul)',
      'action': 'Adjusted retail price for A2 Gir Cow Milk to ₹90/L',
      'type': 'price'
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _lightBg,
      appBar: AppBar(
        backgroundColor: _primaryGreen,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: _accentGreen.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.admin_panel_settings, color: _accentGreen, size: 20),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Admin Control Center',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Full Management Privileges Active',
                  style: TextStyle(
                    color: Color(0xFF86EFAC),
                    fontSize: 10.5,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Farm Emergency Broadcast',
            icon: const Icon(Icons.campaign_outlined, color: Colors.white),
            onPressed: () => _showBroadcastDialog(),
          ),
          IconButton(
            tooltip: 'Cloud Database Backup',
            icon: const Icon(Icons.cloud_upload_outlined, color: Colors.white),
            onPressed: () => _simulateBackup(),
          ),
          const SizedBox(width: 6),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: _accentGreen,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5),
          tabs: const [
            Tab(text: 'Overview', icon: Icon(Icons.dashboard_outlined, size: 17)),
            Tab(text: 'Herd Cattle', icon: Icon(Icons.pets_outlined, size: 17)),
            Tab(text: 'Milk Production', icon: Icon(Icons.water_drop_outlined, size: 17)),
            Tab(text: 'Feed Stock', icon: Icon(Icons.grass_outlined, size: 17)),
            Tab(text: 'Prices & Products', icon: Icon(Icons.sell_outlined, size: 17)),
            Tab(text: 'Staff & Audit', icon: Icon(Icons.people_outline, size: 17)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildHerdTab(),
          _buildMilkTab(),
          _buildFeedTab(),
          _buildPricingTab(),
          _buildStaffAndAuditTab(),
        ],
      ),
      floatingActionButton: _buildContextualFAB(),
    );
  }

  Widget? _buildContextualFAB() {
    switch (_selectedTabIndex) {
      case 1:
        return FloatingActionButton.extended(
          backgroundColor: _primaryGreen,
          onPressed: () => _showAddCattleDialog(),
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text('Add Cattle', style: TextStyle(color: Colors.white)),
        );
      case 2:
        return FloatingActionButton.extended(
          backgroundColor: _primaryGreen,
          onPressed: () => _showAddMilkLogDialog(),
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text('Record Milk Log', style: TextStyle(color: Colors.white)),
        );
      case 3:
        return FloatingActionButton.extended(
          backgroundColor: _primaryGreen,
          onPressed: () => _showAddFeedStockDialog(),
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text('Add Feed Stock', style: TextStyle(color: Colors.white)),
        );
      case 4:
        return FloatingActionButton.extended(
          backgroundColor: _primaryGreen,
          onPressed: () => _showAddProductDialog(),
          icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
          label: const Text('Add Product', style: TextStyle(color: Colors.white)),
        );
      case 5:
        return FloatingActionButton.extended(
          backgroundColor: _primaryGreen,
          onPressed: () => _showAddStaffDialog(),
          icon: const Icon(Icons.person_add, color: Colors.white),
          label: const Text('Add Staff Member', style: TextStyle(color: Colors.white)),
        );
      default:
        return null;
    }
  }

  // ──────────────────────────────────────────────────────────────
  // TAB 1: OVERVIEW & EXECUTIVE DASHBOARD
  // ──────────────────────────────────────────────────────────────
  Widget _buildOverviewTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Admin Hero Banner ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0C3823), Color(0xFF14532D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: _accentGreen.withValues(alpha: 0.2),
                  child: const Text('👑', style: TextStyle(fontSize: 26)),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Executive Command Center',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Full Control Active • ${globalUserSession.roleName}',
                        style: const TextStyle(color: Color(0xFF86EFAC), fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.circle, color: Color(0xFF4ADE80), size: 10),
                      SizedBox(width: 6),
                      Text('Live', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Executive KPI Grid ──
          const Text(
            'FARM KEY PERFORMANCE METRICS',
            style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _textMuted, letterSpacing: 1.1),
          ),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.35,
            children: [
              _buildKPICard(
                title: 'Total Herd Count',
                value: '${_cattleList.length} Animals',
                subtitle: '${_cattleList.where((e) => e['status'] == 'Milking').length} Milking • ${_cattleList.where((e) => e['status'] == 'Dry').length} Dry',
                icon: Icons.pets,
                iconBg: const Color(0xFFDCFCE7),
                iconColor: const Color(0xFF16A34A),
              ),
              _buildKPICard(
                title: 'Daily Milk Production',
                value: '312.0 Litres',
                subtitle: '↑ 4.2% yield increase',
                icon: Icons.water_drop,
                iconBg: const Color(0xFFE0F2FE),
                iconColor: const Color(0xFF0284C7),
              ),
              _buildKPICard(
                title: 'Monthly Revenue',
                value: '₹3,45,800',
                subtitle: 'Milk & Dairy Products',
                icon: Icons.currency_rupee,
                iconBg: const Color(0xFFFEF3C7),
                iconColor: const Color(0xFFD97706),
              ),
              _buildKPICard(
                title: 'Feed Inventory',
                value: '84% Stocked',
                subtitle: '12 Days Fodder Reserve',
                icon: Icons.grass,
                iconBg: const Color(0xFFF3E8FF),
                iconColor: const Color(0xFF7C3AED),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ── Quick Action Bar ──
          const Text(
            'QUICK ADMINISTRATIVE CONTROLS',
            style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _textMuted, letterSpacing: 1.1),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  icon: Icons.add_circle_outline,
                  label: 'Add Cattle',
                  color: const Color(0xFF0C3823),
                  onTap: () {
                    _tabController.animateTo(1);
                    _showAddCattleDialog();
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildQuickActionButton(
                  icon: Icons.post_add,
                  label: 'Log Yield',
                  color: const Color(0xFF0284C7),
                  onTap: () {
                    _tabController.animateTo(2);
                    _showAddMilkLogDialog();
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildQuickActionButton(
                  icon: Icons.price_change,
                  label: 'Adjust Rates',
                  color: const Color(0xFFD97706),
                  onTap: () => _tabController.animateTo(4),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // ── Live Audit Log Snapshot ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'LIVE SYSTEM AUDIT STREAM',
                style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _textMuted, letterSpacing: 1.1),
              ),
              TextButton(
                onPressed: () => _tabController.animateTo(5),
                child: const Text('View All Logs', style: TextStyle(color: _primaryGreen, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _auditLogs.length > 3 ? 3 : _auditLogs.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final log = _auditLogs[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 16,
                    backgroundColor: const Color(0xFFEFF6F1),
                    child: Icon(_getLogIcon(log['type']), size: 16, color: _primaryGreen),
                  ),
                  title: Text(log['action'], style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: _textDark)),
                  subtitle: Text('By ${log['user']} • ${log['time']}', style: const TextStyle(fontSize: 11, color: _textMuted)),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKPICard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _textMuted), overflow: TextOverflow.ellipsis),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, size: 16, color: iconColor),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: _textDark)),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(fontSize: 10.5, color: _accentGreen, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────
  // TAB 2: HERD CATTLE CONTROL
  // ──────────────────────────────────────────────────────────────
  Widget _buildHerdTab() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Tag ID or Name...',
                    prefixIcon: const Icon(Icons.search, size: 20, color: _textMuted),
                    filled: true,
                    fillColor: const Color(0xFFF3F4F6),
                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _cattleList.length,
            itemBuilder: (context, index) {
              final item = _cattleList[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0xFFE5E7EB))),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          item['photo'],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(width: 60, height: 60, color: const Color(0xFFD1FAE5), child: const Icon(Icons.pets, color: _primaryGreen)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(color: const Color(0xFFEFF6F1), borderRadius: BorderRadius.circular(4)),
                                  child: Text(item['id'], style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _primaryGreen)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text('${item['breed']} • ${item['age']} • ${item['milkYield']}', style: const TextStyle(fontSize: 12, color: _textMuted)),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                _buildBadge(item['status'], item['status'] == 'Milking' ? Colors.green : Colors.orange),
                                const SizedBox(width: 6),
                                _buildBadge(item['health'], item['health'] == 'Healthy' ? Colors.blue : Colors.red),
                              ],
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert, color: _textMuted),
                        onSelected: (action) {
                          if (action == 'edit') {
                            _showEditCattleDialog(item);
                          } else if (action == 'delete') {
                            setState(() {
                              _cattleList.removeAt(index);
                              _auditLogs.insert(0, {
                                'time': 'Just now',
                                'user': 'Admin',
                                'action': 'Removed animal ${item['id']} from cattle inventory',
                                'type': 'system'
                              });
                            });
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(value: 'edit', child: Row(children: [Icon(Icons.edit, size: 18, color: Colors.blue), SizedBox(width: 8), Text('Edit Cattle Details')])),
                          const PopupMenuItem(value: 'delete', child: Row(children: [Icon(Icons.delete_outline, size: 18, color: Colors.red), SizedBox(width: 8), Text('Remove Animal')])),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)),
      child: Text(text, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
    );
  }

  // ──────────────────────────────────────────────────────────────
  // TAB 3: MILK PRODUCTION MANAGER
  // ──────────────────────────────────────────────────────────────
  Widget _buildMilkTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF0284C7).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF0284C7).withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.water_drop, color: Color(0xFF0284C7), size: 32),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Today Total Collection', style: TextStyle(fontSize: 12, color: _textMuted, fontWeight: FontWeight.w600)),
                    Text('312.0 Litres', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF0284C7))),
                    Text('38 Cows Milked • Avg Fat 4.5%', style: TextStyle(fontSize: 11, color: Color(0xFF0369A1))),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showAddMilkLogDialog(),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0284C7)),
                icon: const Icon(Icons.add, size: 16, color: Colors.white),
                label: const Text('Add Entry', style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text('COLLECTION SESSIONS LOG', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _textMuted, letterSpacing: 1.1)),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _milkYieldLogs.length,
          itemBuilder: (context, index) {
            final log = _milkYieldLogs[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0xFFE5E7EB))),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFE0F2FE),
                  child: const Icon(Icons.water_drop, color: Color(0xFF0284C7), size: 20),
                ),
                title: Text('${log['session']} (${log['time']})', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: Text('${log['cows']} Animals • Fat Rate ${log['fat']}', style: const TextStyle(fontSize: 12, color: _textMuted)),
                trailing: Text('${log['qty']} L', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: _primaryGreen)),
              ),
            );
          },
        ),
      ],
    );
  }

  // ──────────────────────────────────────────────────────────────
  // TAB 4: FEED & STOCK MANAGEMENT
  // ──────────────────────────────────────────────────────────────
  Widget _buildFeedTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF7C3AED).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFF7C3AED).withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.grass, color: Color(0xFF7C3AED), size: 32),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Feed Stock Index', style: TextStyle(fontSize: 12, color: _textMuted, fontWeight: FontWeight.w600)),
                    Text('2,535 kg Total', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF7C3AED))),
                    Text('Sufficient for 12 days supply', style: TextStyle(fontSize: 11, color: Color(0xFF6D28D9))),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showAddFeedStockDialog(),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7C3AED)),
                icon: const Icon(Icons.add, size: 16, color: Colors.white),
                label: const Text('Add Stock', style: TextStyle(color: Colors.white, fontSize: 12)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text('CURRENT FODDER INVENTORY', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _textMuted, letterSpacing: 1.1)),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _feedStockList.length,
          itemBuilder: (context, index) {
            final feed = _feedStockList[index];
            final Color statusColor = feed['color'] as Color;
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0xFFE5E7EB))),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: statusColor.withValues(alpha: 0.15),
                  child: Icon(Icons.eco, color: statusColor, size: 20),
                ),
                title: Text(feed['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                subtitle: Text('Status: ${feed['status']}', style: TextStyle(fontSize: 11.5, color: statusColor, fontWeight: FontWeight.w600)),
                trailing: Text(feed['qty'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: _textDark)),
              ),
            );
          },
        ),
      ],
    );
  }

  // ──────────────────────────────────────────────────────────────
  // TAB 5: PRICING & PRODUCTS MANAGER
  // ──────────────────────────────────────────────────────────────
  Widget _buildPricingTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFCD34D)),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Color(0xFFD97706)),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Prices set here apply immediately across the entire customer catalog and billing system.',
                    style: TextStyle(fontSize: 12, color: Color(0xFF92400E), fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _productList.length,
            itemBuilder: (context, index) {
              final prod = _productList[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0xFFE5E7EB))),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: const Color(0xFFEFF6F1), borderRadius: BorderRadius.circular(10)),
                        child: Icon(prod['icon'], color: _primaryGreen, size: 24),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(prod['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            const SizedBox(height: 2),
                            Text(prod['stock'], style: const TextStyle(fontSize: 11, color: _textMuted)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('₹${prod['price']} / ${prod['unit']}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: _primaryGreen)),
                          const SizedBox(height: 4),
                          InkWell(
                            onTap: () => _showEditPriceDialog(prod),
                            child: const Text('Edit Rate', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────────────────
  // TAB 6: STAFF & AUDIT STREAM
  // ──────────────────────────────────────────────────────────────
  Widget _buildStaffAndAuditTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('STAFF ROSTER & PERMISSIONS', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _textMuted, letterSpacing: 1.1)),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _staffList.length,
          itemBuilder: (context, index) {
            final staff = _staffList[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0xFFE5E7EB))),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: _primaryGreen,
                      child: Text(staff['avatar'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(staff['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          Text('${staff['role']} • ${staff['shift']}', style: const TextStyle(fontSize: 11.5, color: _primaryGreen, fontWeight: FontWeight.w600)),
                          Text(staff['phone'], style: const TextStyle(fontSize: 11, color: _textMuted)),
                        ],
                      ),
                    ),
                    Switch(
                      value: staff['status'] == 'Active',
                      activeThumbColor: _accentGreen,
                      onChanged: (val) {
                        setState(() {
                          staff['status'] = val ? 'Active' : 'Inactive';
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        const Text('SYSTEM AUDIT STREAM', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _textMuted, letterSpacing: 1.1)),
        const SizedBox(height: 10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _auditLogs.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final log = _auditLogs[index];
            return Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: Color(0xFFE5E7EB))),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFEFF6F1),
                  child: Icon(_getLogIcon(log['type']), color: _primaryGreen, size: 18),
                ),
                title: Text(log['action'], style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold)),
                subtitle: Text('User: ${log['user']} • ${log['time']}', style: const TextStyle(fontSize: 11, color: _textMuted)),
              ),
            );
          },
        ),
      ],
    );
  }

  IconData _getLogIcon(String type) {
    switch (type) {
      case 'health':
        return Icons.medical_services_outlined;
      case 'yield':
        return Icons.water_drop_outlined;
      case 'feed':
        return Icons.grass_outlined;
      case 'price':
        return Icons.attach_money;
      case 'system':
      default:
        return Icons.security_outlined;
    }
  }

  // ──────────────────────────────────────────────────────────────
  // INTERACTIVE MANAGEMENT DIALOGS
  // ──────────────────────────────────────────────────────────────
  void _showAddCattleDialog() {
    final nameCtrl = TextEditingController();
    final breedCtrl = TextEditingController(text: 'Gir Cow');
    final yieldCtrl = TextEditingController(text: '16.0 L/day');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(children: [Icon(Icons.pets, color: _primaryGreen), SizedBox(width: 8), Text('Register New Livestock')]),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Cattle Name / Identifier')),
            const SizedBox(height: 8),
            TextField(controller: breedCtrl, decoration: const InputDecoration(labelText: 'Breed (Gir, HF, Jersey, Murrah)')),
            const SizedBox(height: 8),
            TextField(controller: yieldCtrl, decoration: const InputDecoration(labelText: 'Expected Daily Yield (e.g., 16 L/day)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: _primaryGreen),
            onPressed: () {
              if (nameCtrl.text.isNotEmpty) {
                final newId = 'COW-${100 + _cattleList.length + 1}';
                setState(() {
                  _cattleList.insert(0, {
                    'id': newId,
                    'name': nameCtrl.text,
                    'breed': breedCtrl.text,
                    'age': '2 Yrs',
                    'milkYield': yieldCtrl.text,
                    'status': 'Milking',
                    'health': 'Healthy',
                    'photo': 'assets/images/gir_cow.png'
                  });
                  _auditLogs.insert(0, {'time': 'Just now', 'user': 'Admin', 'action': 'Registered new animal ${nameCtrl.text} ($newId)', 'type': 'system'});
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('Save Cattle', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showEditCattleDialog(Map<String, dynamic> item) {
    final nameCtrl = TextEditingController(text: item['name']);
    final yieldCtrl = TextEditingController(text: item['milkYield']);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Edit ${item['id']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Name')),
            const SizedBox(height: 8),
            TextField(controller: yieldCtrl, decoration: const InputDecoration(labelText: 'Daily Yield')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: _primaryGreen),
            onPressed: () {
              setState(() {
                item['name'] = nameCtrl.text;
                item['milkYield'] = yieldCtrl.text;
              });
              Navigator.pop(ctx);
            },
            child: const Text('Update', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showAddMilkLogDialog() {
    final qtyCtrl = TextEditingController(text: '150.0');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(children: [Icon(Icons.water_drop, color: Color(0xFF0284C7)), SizedBox(width: 8), Text('Record Milk Collection')]),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: qtyCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Milk Quantity Collected (Litres)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0284C7)),
            onPressed: () {
              final qty = double.tryParse(qtyCtrl.text) ?? 100.0;
              setState(() {
                _milkYieldLogs.insert(0, {
                  'session': 'Manual Collection Log',
                  'time': 'Just now',
                  'qty': qty,
                  'cows': 38,
                  'fat': '4.5%',
                });
                _auditLogs.insert(0, {'time': 'Just now', 'user': 'Admin', 'action': 'Logged milk collection of $qty Litres', 'type': 'yield'});
              });
              Navigator.pop(ctx);
            },
            child: const Text('Save Entry', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showAddFeedStockDialog() {
    final nameCtrl = TextEditingController();
    final qtyCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(children: [Icon(Icons.grass, color: Color(0xFF7C3AED)), SizedBox(width: 8), Text('Add Feed Stock')]),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Fodder / Feed Name')),
            const SizedBox(height: 8),
            TextField(controller: qtyCtrl, decoration: const InputDecoration(labelText: 'Quantity (e.g. 500 kg)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7C3AED)),
            onPressed: () {
              if (nameCtrl.text.isNotEmpty) {
                setState(() {
                  _feedStockList.insert(0, {
                    'name': nameCtrl.text,
                    'qty': qtyCtrl.text.isEmpty ? '300 kg' : qtyCtrl.text,
                    'status': 'Good Stock',
                    'color': Colors.green,
                  });
                  _auditLogs.insert(0, {'time': 'Just now', 'user': 'Admin', 'action': 'Added ${qtyCtrl.text} of ${nameCtrl.text} feed stock', 'type': 'feed'});
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('Save Feed', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showAddProductDialog() {
    final nameCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    final unitCtrl = TextEditingController(text: 'Kg');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(children: [Icon(Icons.add_shopping_cart, color: _primaryGreen), SizedBox(width: 8), Text('Add Farm Product')]),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Product Name')),
            const SizedBox(height: 8),
            TextField(controller: priceCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Price (₹)')),
            const SizedBox(height: 8),
            TextField(controller: unitCtrl, decoration: const InputDecoration(labelText: 'Unit (Litre / Kg / Packet)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: _primaryGreen),
            onPressed: () {
              final p = int.tryParse(priceCtrl.text) ?? 100;
              if (nameCtrl.text.isNotEmpty) {
                setState(() {
                  _productList.add({
                    'name': nameCtrl.text,
                    'price': p,
                    'unit': unitCtrl.text,
                    'stock': '50 Units in store',
                    'status': 'In Stock',
                    'icon': Icons.inventory_2
                  });
                  _auditLogs.insert(0, {'time': 'Just now', 'user': 'Admin', 'action': 'Added new product ${nameCtrl.text} at ₹$p/${unitCtrl.text}', 'type': 'price'});
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('Add Product', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showEditPriceDialog(Map<String, dynamic> prod) {
    final priceCtrl = TextEditingController(text: prod['price'].toString());

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Adjust Rate: ${prod['name']}'),
        content: TextField(
          controller: priceCtrl,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'New Price per ${prod['unit']} (₹)', prefixText: '₹ '),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: _primaryGreen),
            onPressed: () {
              final newPrice = int.tryParse(priceCtrl.text);
              if (newPrice != null) {
                setState(() {
                  prod['price'] = newPrice;
                  _auditLogs.insert(0, {'time': 'Just now', 'user': 'Admin', 'action': 'Changed rate of ${prod['name']} to ₹$newPrice/${prod['unit']}', 'type': 'price'});
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('Save Rate', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showAddStaffDialog() {
    final nameCtrl = TextEditingController();
    final roleCtrl = TextEditingController(text: 'Farm Worker');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(children: [Icon(Icons.person_add, color: _primaryGreen), SizedBox(width: 8), Text('Add Staff Member')]),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Full Name')),
            const SizedBox(height: 8),
            TextField(controller: roleCtrl, decoration: const InputDecoration(labelText: 'Role (Vet, Supervisor, Worker)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: _primaryGreen),
            onPressed: () {
              if (nameCtrl.text.isNotEmpty) {
                final initials = nameCtrl.text.trim().split(' ').map((e) => e[0]).take(2).join();
                setState(() {
                  _staffList.add({
                    'name': nameCtrl.text,
                    'role': roleCtrl.text,
                    'phone': '+91 99000 00000',
                    'shift': 'General Shift',
                    'status': 'Active',
                    'avatar': initials.toUpperCase()
                  });
                  _auditLogs.insert(0, {'time': 'Just now', 'user': 'Admin', 'action': 'Registered staff ${nameCtrl.text} (${roleCtrl.text})', 'type': 'system'});
                });
                Navigator.pop(ctx);
              }
            },
            child: const Text('Add Member', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showBroadcastDialog() {
    final msgCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(children: [Icon(Icons.campaign, color: Colors.orange), SizedBox(width: 8), Text('Emergency Announcement')]),
        content: TextField(
          controller: msgCtrl,
          maxLines: 3,
          decoration: const InputDecoration(hintText: 'Enter announcement for all staff members & app users...', border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Broadcast alert sent to all staff devices!')));
            },
            child: const Text('Broadcast Now', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _simulateBackup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(ctx);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cloud backup completed successfully!')));
        });
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(color: _primaryGreen),
              SizedBox(width: 20),
              Text('Syncing & backing up database...'),
            ],
          ),
        );
      },
    );
  }
}
