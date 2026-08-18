import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/bottom_nav_bar.dart';

// ─────────────────────────────────────────────
// Breed Model
// ─────────────────────────────────────────────
class DairyBreed {
  final String id;
  final String name;
  final String badge;
  final String imagePath;
  final String description;
  final String origin;
  final String avgYield;
  final String fatContent;
  final String diseaseResistance;
  final double resistanceScore;
  final String category;

  const DairyBreed({
    required this.id,
    required this.name,
    required this.badge,
    required this.imagePath,
    required this.description,
    required this.origin,
    required this.avgYield,
    required this.fatContent,
    required this.diseaseResistance,
    required this.resistanceScore,
    required this.category,
  });
}

// ─────────────────────────────────────────────
// Breed Encyclopedia Screen
// ─────────────────────────────────────────────
class BreedCatalogScreen extends StatefulWidget {
  const BreedCatalogScreen({super.key});

  @override
  State<BreedCatalogScreen> createState() => _BreedCatalogScreenState();
}

class _BreedCatalogScreenState extends State<BreedCatalogScreen> {
  int _selectedFilterIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  static const Color _primaryGreen = Color(0xFF0C3823);
  static const Color _bg = Color(0xFFEFF6F1);

  final List<String> _filters = ['All Breeds', 'Cattle Breeds', 'Buffalo Breeds'];

  final List<DairyBreed> _breeds = const [
    DairyBreed(
      id: 'b1',
      name: 'Gir Cow',
      badge: 'Popular Native Indian',
      imagePath: 'assets/images/gir_cow.png',
      description:
          'The Gir is one of the principal Zebu breeds originating in India. Known for its high tolerance to tropical heat and resistance to diseases, it produces A2 nutrient-rich milk.',
      origin: 'Gujarat, India',
      avgYield: '1,500 - 2,500 L / yr',
      fatContent: '4.5% - 5.0%',
      diseaseResistance: 'High',
      resistanceScore: 0.90,
      category: 'Cow',
    ),
    DairyBreed(
      id: 'b2',
      name: 'Holstein Friesian',
      badge: 'Top Yield Producer',
      imagePath: 'assets/images/holstein_friesian.png',
      description:
          'Holstein Friesian cattle are the highest-production dairy animals in the world. Recognizable by their distinctive black-and-white markings, ideal for high yield operations.',
      origin: 'Friesland, Netherlands',
      avgYield: '7,000 - 10,000 L / yr',
      fatContent: '3.5% - 3.8%',
      diseaseResistance: 'Moderate',
      resistanceScore: 0.75,
      category: 'Cow',
    ),
    DairyBreed(
      id: 'b3',
      name: 'Jersey Purebred',
      badge: 'High Butterfat Content',
      imagePath: 'assets/images/jersey_cow.png',
      description:
          'Jerseys are famous for high butterfat content in milk and lower maintenance costs due to smaller body mass and superior feed conversion efficiency.',
      origin: 'Island of Jersey, UK',
      avgYield: '4,500 - 6,000 L / yr',
      fatContent: '5.0% - 5.5%',
      diseaseResistance: 'High',
      resistanceScore: 0.85,
      category: 'Cow',
    ),
    DairyBreed(
      id: 'b4',
      name: 'Murrah Buffalo',
      badge: 'Premier Buffalo',
      imagePath: 'assets/images/murrah_buffalo.png',
      description:
          'The Murrah is the premier water buffalo breed of India, renowned for jet-black color, tightly curved horns, and exceptionally rich milk ideal for ghee and paneer.',
      origin: 'Haryana & Punjab, India',
      avgYield: '2,500 - 3,500 L / yr',
      fatContent: '7.0% - 8.0%',
      diseaseResistance: 'Very High',
      resistanceScore: 0.95,
      category: 'Buffalo',
    ),
  ];

  List<DairyBreed> get _filteredBreeds {
    return _breeds.where((b) {
      if (_selectedFilterIndex == 1 && b.category != 'Cow') return false;
      if (_selectedFilterIndex == 2 && b.category != 'Buffalo') return false;

      final query = _searchController.text.toLowerCase().trim();
      if (query.isNotEmpty) {
        return b.name.toLowerCase().contains(query) ||
            b.origin.toLowerCase().contains(query);
      }
      return true;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      backgroundColor: _bg,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Reference Library Header Section ──
            _buildHeaderSection(),

            // ── Filter Buttons Row ──
            _buildActionButtonsRow(),

            const SizedBox(height: 14),

            // ── Breeds List ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _filteredBreeds.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return _buildBreedCard(_filteredBreeds[index]);
                },
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: const DairyBottomNavBar(selectedIndex: -1),
    );
  }

  // ── AppBar ──────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _primaryGreen,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 22),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: const Text(
        'Breed Encyclopedia',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
    );
  }

  // ── Header Section ──────────────────────────────────────
  Widget _buildHeaderSection() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'REFERENCE CATALOG',
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w800,
              color: _primaryGreen,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Dairy Cattle & Buffalo Breeds',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: _primaryGreen,
              letterSpacing: -0.3,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Explore genetics, average annual yield, fat percentages, and climate adaptability.',
            style: TextStyle(
              fontSize: 12.5,
              color: Color(0xFF4B5563),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // ── Action Buttons Row ──────────────────────────────────
  Widget _buildActionButtonsRow() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 14),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_filters.length, (index) {
            final isSelected = _selectedFilterIndex == index;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(_filters[index]),
                selected: isSelected,
                selectedColor: _primaryGreen,
                checkmarkColor: Colors.white,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF374151),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                backgroundColor: const Color(0xFFF3F4F6),
                onSelected: (val) {
                  setState(() => _selectedFilterIndex = index);
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  // ── Breed Card Widget ────────────────────────────────────
  Widget _buildBreedCard(DairyBreed breed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image Header with Badge ──
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  breed.imagePath,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 180,
                    color: _primaryGreen,
                    child: const Center(
                      child: Icon(Icons.pets, size: 50, color: Colors.white54),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: _primaryGreen.withValues(alpha: 0.90),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    breed.badge,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ── Card Body ──
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  breed.name,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 6),

                Text(
                  breed.description,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF4B5563),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 16, color: _primaryGreen),
                    const SizedBox(width: 4),
                    Text(
                      'Origin: ${breed.origin}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF374151),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Metrics Grid
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Avg. Yield', style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                            const SizedBox(height: 2),
                            Text(breed.avgYield, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, color: _primaryGreen)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Fat Content', style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                            const SizedBox(height: 2),
                            Text(breed.fatContent, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, color: Color(0xFFD97706))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
