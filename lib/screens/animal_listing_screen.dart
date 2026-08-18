import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/bottom_nav_bar.dart';
import 'animal_detail_screen.dart';






// ─────────────────────────────────────────────
// Data Model
// ─────────────────────────────────────────────
class Animal {
  final String tagId;
  final String name;
  final String breed;
  final String age;
  final String imagePath;
  final String status; // 'Healthy' | 'Sick' | 'Alert'
  final String todayYield;
  final String lastCheckup;
  final String location;

  const Animal({
    required this.tagId,
    required this.name,
    required this.breed,
    required this.age,
    required this.imagePath,
    required this.status,
    required this.todayYield,
    required this.lastCheckup,
    required this.location,
  });
}

// ─────────────────────────────────────────────
// Screen
// ─────────────────────────────────────────────
class AnimalListingScreen extends StatefulWidget {
  const AnimalListingScreen({super.key});

  @override
  State<AnimalListingScreen> createState() => _AnimalListingScreenState();
}

class _AnimalListingScreenState extends State<AnimalListingScreen> {
  int _selectedFilter = 0;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = [
    'All Animals',
    'Cow',
    'Buffalo',
    'Jersey B',
  ];

  final List<Animal> _animals = [
    Animal(
      tagId: 'COW-001',
      name: 'Jersey Purebred',
      breed: 'Cow',
      age: 'Age: 4.5 Years',
      imagePath: 'assets/images/jersey_cow.png',
      status: 'Healthy',
      todayYield: '16.5 Liters',
      lastCheckup: '2 Days ago',
      location: 'Pune, Maharashtra',
    ),
    Animal(
      tagId: 'BUF-014',
      name: 'Murrah Buffalo',
      breed: 'Buffalo',
      age: 'Age: 6 Years',
      imagePath: 'assets/images/murrah_buffalo.png',
      status: 'Healthy',
      todayYield: '12.2 Liters',
      lastCheckup: '12.2 Liters',
      location: 'Haryana',
    ),
    Animal(
      tagId: 'COW-009',
      name: 'Holstein Friesian',
      breed: 'Cow',
      age: 'Age: 3 Years',
      imagePath: 'assets/images/holstein_friesian.png',
      status: 'Sick',
      todayYield: '9.0 Liters',
      lastCheckup: 'Mastitis Alert',
      location: 'Gujarat',
    ),
    Animal(
      tagId: 'COW-005',
      name: 'Jersey Purebred',
      breed: 'Cow',
      age: 'Age: 5 Years',
      imagePath: 'assets/images/jersey_cow.png',
      status: 'Healthy',
      todayYield: '21.0 Liters',
      lastCheckup: '5 Days ago',
      location: 'Pune, Maharashtra',
    ),
    Animal(
      tagId: 'GIR-003',
      name: 'Gir Cow',
      breed: 'Cow',
      age: 'Age: 6 Years',
      imagePath: 'assets/images/gir_cow.png',
      status: 'Healthy',
      todayYield: '18.4 Liters',
      lastCheckup: '1 Day ago',
      location: 'Rajkot, Gujarat',
    ),
    Animal(
      tagId: 'BUF-022',
      name: 'Murrah Buffalo',
      breed: 'Buffalo',
      age: 'Age: 4 Years',
      imagePath: 'assets/images/murrah_buffalo.png',
      status: 'Sick',
      todayYield: '8.1 Liters',
      lastCheckup: 'Fever Alert',
      location: 'Haryana',
    ),
  ];

  List<Animal> get _filteredAnimals {
    final filter = _filters[_selectedFilter];
    if (filter == 'All Animals') return _animals;
    if (filter == 'Jersey B') {
      return _animals.where((a) => a.name.contains('Jersey')).toList();
    }
    return _animals.where((a) => a.breed == filter).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Color get _primaryGreen => const Color(0xFF2D6A4F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: const Color(0xFFEFF6F1),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearchAndFilter(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              itemCount: _filteredAnimals.length,
              itemBuilder: (context, index) =>
                  _buildAnimalCard(_filteredAnimals[index]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const DairyBottomNavBar(selectedIndex: 0),
    );
  }

  // ── AppBar ──────────────────────────────────
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF0C3823),
      elevation: 0,
      shadowColor: Colors.transparent,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 22),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: const Text(
        'Dairy Farm',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white, size: 22),
          onPressed: () {},
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/dairy_logo.png',
              width: 34,
              height: 34,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => CircleAvatar(
                radius: 16,
                backgroundColor: _primaryGreen,
                child: const Text(
                  'K',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Search + Filter ─────────────────────────
  Widget _buildSearchAndFilter() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      child: Column(
        children: [
          // Search bar
          Container(
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F2F5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(fontSize: 13),
              decoration: const InputDecoration(
                hintText: 'Search Tag ID or Breed...',
                hintStyle: TextStyle(fontSize: 13, color: Color(0xFF9E9E9E)),
                prefixIcon:
                    Icon(Icons.search, color: Color(0xFF9E9E9E), size: 18),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Filter chips
          SizedBox(
            height: 34,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) => _buildChip(i),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(int index) {
    final selected = _selectedFilter == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? _primaryGreen : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? _primaryGreen : const Color(0xFFDDE1E7),
          ),
        ),
        child: Text(
          _filters[index],
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            color: selected ? Colors.white : const Color(0xFF555555),
          ),
        ),
      ),
    );
  }

  // ── Animal Card ─────────────────────────────
  Widget _buildAnimalCard(Animal animal) {
    final isHealthy = animal.status == 'Healthy';
    final isSick = animal.status == 'Sick';
    final statusColor = isHealthy
        ? const Color(0xFF22C55E)
        : isSick
            ? const Color(0xFFEF4444)
            : const Color(0xFFF59E0B);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnimalDetailScreen(animal: animal),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image with overlays ──
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(14),
                  ),
                  child: Image.asset(
                    animal.imagePath,
                    height: 170,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 170,
                      color: const Color(0xFFE8F5E9),
                      child: Center(
                        child: Icon(Icons.pets,
                            size: 48, color: _primaryGreen.withOpacity(0.4)),
                      ),
                    ),
                  ),
                ),
                // Tag ID badge (top-left)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.55),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      animal.tagId,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                // Status badge (top-right)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      animal.status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ── Card body ──
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name + 3-dot menu
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          animal.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showOptions(context, animal),
                        child: const Icon(Icons.more_vert,
                            size: 20, color: Color(0xFF9E9E9E)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    animal.age,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Divider(height: 1, color: Color(0xFFEEEEEE)),
                  const SizedBox(height: 12),

                  // Stats row
                  Row(
                    children: [
                      // Today's Yield
                      Expanded(
                        child: _buildStat(
                          icon: Icons.water_drop_outlined,
                          iconColor: const Color(0xFF3B82F6),
                          label: "TODAY'S YIELD",
                          value: animal.todayYield,
                          valueColor: const Color(0xFF1A1A1A),
                        ),
                      ),
                      // Divider
                      Container(
                        width: 1,
                        height: 36,
                        color: const Color(0xFFEEEEEE),
                      ),
                      // Last Checkup
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: _buildStat(
                            icon: isSick
                                ? Icons.warning_amber_rounded
                                : Icons.calendar_today_outlined,
                            iconColor: isSick
                                ? const Color(0xFFEF4444)
                                : const Color(0xFF9E9E9E),
                            label: 'LAST CHECKUP',
                            value: animal.lastCheckup,
                            valueColor: isSick
                                ? const Color(0xFFEF4444)
                                : const Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 9.5,
                color: Color(0xFF9E9E9E),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              value,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: valueColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showOptions(BuildContext context, Animal animal) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.visibility_outlined, color: _primaryGreen),
              title: const Text('View Details'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.edit_outlined, color: _primaryGreen),
              title: const Text('Edit Animal'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text('Remove', style: TextStyle(color: Colors.red)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

}
