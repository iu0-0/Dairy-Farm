import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/bottom_nav_bar.dart';

// ─────────────────────────────────────────────
// Dairy Product Model
// ─────────────────────────────────────────────
class DairyProduct {
  final String id;
  final String title;
  final String priceText;
  final String imagePath;
  final String badgeText;
  final Color badgeBg;
  final String category;
  final String description;

  const DairyProduct({
    required this.id,
    required this.title,
    required this.priceText,
    required this.imagePath,
    this.badgeText = '',
    this.badgeBg = const Color(0xFF0C3823),
    required this.category,
    required this.description,
  });
}

// ─────────────────────────────────────────────
// Products Screen
// ─────────────────────────────────────────────
class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int _selectedCategoryIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  static const Color _primaryGreen = Color(0xFF0C3823);
  static const Color _bg = Color(0xFFEFF6F1);

  final List<String> _categories = [
    'All Products',
    'Milk & Curd',
    'Ghee & Butter',
    'Paneer & Cheese',
  ];

  final List<DairyProduct> _products = [
    const DairyProduct(
      id: 'p1',
      title: 'Fresh Organic Whole Milk',
      priceText: '₹80 / Litre',
      imagePath: 'assets/images/holstein_friesian.png',
      badgeText: '100% PURE A2',
      badgeBg: Color(0xFF0C3823),
      category: 'Milk & Curd',
      description: 'Farm-fresh 100% pure whole milk pasteurized and packaged daily from grass-fed cows.',
    ),
    const DairyProduct(
      id: 'p2',
      title: 'Traditional Salted Butter',
      priceText: '₹190 / 250g',
      imagePath: 'assets/images/jersey_cow.png',
      badgeText: 'FRESH CHURNED',
      badgeBg: Color(0xFFD97706),
      category: 'Ghee & Butter',
      description: 'Rich artisanal butter churned from high-fat cream with a touch of sea salt.',
    ),
    const DairyProduct(
      id: 'p3',
      title: 'Pure Desi Cow Ghee',
      priceText: '₹460 / 500g',
      imagePath: 'assets/images/gir_cow.png',
      badgeText: 'BILOANA METHOD',
      badgeBg: Color(0xFFB45309),
      category: 'Ghee & Butter',
      description: 'Traditional Bilona method ghee prepared from A2 Gir cow milk with authentic granular texture.',
    ),
    const DairyProduct(
      id: 'p4',
      title: 'Fresh Soft Cottage Paneer',
      priceText: '₹140 / 250g',
      imagePath: 'assets/images/jersey_cow.png',
      badgeText: 'HIGH PROTEIN',
      badgeBg: Color(0xFF0284C7),
      category: 'Paneer & Cheese',
      description: 'Handcrafted fresh Malai Paneer made from pure whole milk.',
    ),
    const DairyProduct(
      id: 'p5',
      title: 'Probiotic Thick Curd (Dahi)',
      priceText: '₹120 / 500g',
      imagePath: 'assets/images/murrah_buffalo.png',
      badgeText: 'PROBIOTIC',
      badgeBg: Color(0xFF0D9488),
      category: 'Milk & Curd',
      description: 'Thick, creamy dahi set naturally with live probiotic cultures for optimum digestive health.',
    ),
  ];

  List<DairyProduct> get _filteredProducts {
    return _products.where((p) {
      if (_selectedCategoryIndex == 1 && p.category != 'Milk & Curd') return false;
      if (_selectedCategoryIndex == 2 && p.category != 'Ghee & Butter') return false;
      if (_selectedCategoryIndex == 3 && p.category != 'Paneer & Cheese') return false;

      final query = _searchController.text.toLowerCase().trim();
      if (query.isNotEmpty) {
        return p.title.toLowerCase().contains(query) ||
            p.category.toLowerCase().contains(query);
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddProductDialog,
        backgroundColor: _primaryGreen,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Add Product',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Search & Header ──
            _buildSearchAndHeader(),

            // ── Category Filter Chips ──
            _buildCategoryFilterChips(),

            const SizedBox(height: 14),

            // ── Product Cards Vertical List ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _filteredProducts.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return _buildProductCard(_filteredProducts[index]);
                },
              ),
            ),

            const SizedBox(height: 80),
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
        'Farm Fresh Products',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
    );
  }

  // ── Search & Header Widget ───────────────────────────────
  Widget _buildSearchAndHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      child: Column(
        children: [
          Container(
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(fontSize: 13),
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'Search milk, butter, ghee, paneer...',
                hintStyle: TextStyle(fontSize: 12.5, color: Color(0xFF9CA3AF)),
                prefixIcon: Icon(Icons.search, color: Color(0xFF9CA3AF), size: 18),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Category Filter Chips Widget ─────────────────────────
  Widget _buildCategoryFilterChips() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_categories.length, (index) {
            final isSelected = _selectedCategoryIndex == index;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(_categories[index]),
                selected: isSelected,
                selectedColor: _primaryGreen,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : const Color(0xFF4B5563),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
                backgroundColor: const Color(0xFFF3F4F6),
                onSelected: (val) {
                  setState(() => _selectedCategoryIndex = index);
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  // ── Product Card Widget ──────────────────────────────────
  Widget _buildProductCard(DairyProduct product) {
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
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  product.imagePath,
                  height: 170,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 170,
                    color: _primaryGreen,
                    child: const Center(
                      child: Icon(Icons.shopping_bag, size: 50, color: Colors.white54),
                    ),
                  ),
                ),
              ),

              if (product.badgeText.isNotEmpty)
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: product.badgeBg.withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      product.badgeText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111827),
                        ),
                      ),
                    ),
                    Text(
                      product.priceText,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: _primaryGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                Text(
                  product.description,
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF6B7280),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),

                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: _primaryGreen,
                        content: Text('Added ${product.title} to order list!'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_shopping_cart, color: Colors.white, size: 18),
                  label: const Text('Add to Order List', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryGreen,
                    minimumSize: const Size(double.infinity, 42),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Add Product Dialog ───────────────────────────────────
  void _showAddProductDialog() {
    final titleCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    String category = 'Milk & Curd';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: const Text('Add New Farm Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleCtrl,
                decoration: const InputDecoration(labelText: 'Product Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: priceCtrl,
                decoration: const InputDecoration(labelText: 'Price (e.g. ₹90 / L)'),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                initialValue: category,
                items: const [
                  DropdownMenuItem(value: 'Milk & Curd', child: Text('Milk & Curd')),
                  DropdownMenuItem(value: 'Ghee & Butter', child: Text('Ghee & Butter')),
                  DropdownMenuItem(value: 'Paneer & Cheese', child: Text('Paneer & Cheese')),
                ],
                onChanged: (val) {
                  if (val != null) setDialogState(() => category = val);
                },
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descCtrl,
                decoration: const InputDecoration(labelText: 'Product Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleCtrl.text.isNotEmpty) {
                  setState(() {
                    _products.add(
                      DairyProduct(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: titleCtrl.text,
                        priceText: priceCtrl.text.isEmpty ? '₹100' : priceCtrl.text,
                        imagePath: 'assets/images/dairy_logo.png',
                        badgeText: 'NEW',
                        badgeBg: _primaryGreen,
                        category: category,
                        description: descCtrl.text.isEmpty ? 'Farm fresh product' : descCtrl.text,
                      ),
                    );
                  });
                }
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: _primaryGreen,
                    content: Text('New product added to catalog!'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryGreen,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Save Product', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
