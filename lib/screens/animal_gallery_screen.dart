import 'package:flutter/material.dart';
import '../widgets/user_drawer.dart';
import '../widgets/bottom_nav_bar.dart';
import 'animal_listing_screen.dart';

// ─────────────────────────────────────────────
// Data Model for Gallery Items
// ─────────────────────────────────────────────
class GalleryMediaItem {
  final String id;
  final String title;
  final String tag;
  final String imagePath;
  final bool isVideo;
  final String duration;
  final String category; // 'Anatomical', 'Routine', 'Health'

  const GalleryMediaItem({
    required this.id,
    required this.title,
    required this.tag,
    required this.imagePath,
    this.isVideo = false,
    this.duration = '',
    required this.category,
  });
}

// ─────────────────────────────────────────────
// Animal Gallery Screen
// ─────────────────────────────────────────────
class AnimalGalleryScreen extends StatefulWidget {
  final String animalName;
  final String tagId;

  const AnimalGalleryScreen({
    super.key,
    this.animalName = 'Bella - Holstein Elite',
    this.tagId = 'BE-0842',
  });

  @override
  State<AnimalGalleryScreen> createState() => _AnimalGalleryScreenState();
}

class _AnimalGalleryScreenState extends State<AnimalGalleryScreen> {
  int _selectedTypeIndex = 0; // 0: All, 1: Photos, 2: Videos
  int _selectedCategoryIndex = 0; // 0: All, 1: Anatomical, 2: Routine, 3: Health

  final List<String> _typeFilters = ['All Media', '📷 Photos', '🎥 Videos'];
  final List<String> _categoryFilters = [
    'All Views',
    'Anatomical Views',
    'Milking & Feeding',
    'Health Checks'
  ];

  // Gallery items list with anatomical views, routine videos & photos
  final List<GalleryMediaItem> _galleryItems = const [
    GalleryMediaItem(
      id: 'g1',
      title: 'Full Front Profile',
      tag: 'Front View',
      imagePath: 'assets/images/holstein_friesian.png',
      isVideo: false,
      category: 'Anatomical',
    ),
    GalleryMediaItem(
      id: 'g2',
      title: 'Left Side Standing View',
      tag: 'Left Profile',
      imagePath: 'assets/images/jersey_cow.png',
      isVideo: false,
      category: 'Anatomical',
    ),
    GalleryMediaItem(
      id: 'g3',
      title: 'Morning Milking Routine',
      tag: 'Milking Video',
      imagePath: 'assets/images/gir_cow.png',
      isVideo: true,
      duration: '0:45',
      category: 'Routine',
    ),
    GalleryMediaItem(
      id: 'g4',
      title: 'Right Side Udder & Stature',
      tag: 'Right Profile',
      imagePath: 'assets/images/murrah_buffalo.png',
      isVideo: false,
      category: 'Anatomical',
    ),
    GalleryMediaItem(
      id: 'g5',
      title: 'Back Stance & Leg Alignment',
      tag: 'Back View',
      imagePath: 'assets/images/holstein_friesian.png',
      isVideo: false,
      category: 'Anatomical',
    ),
    GalleryMediaItem(
      id: 'g6',
      title: 'Veterinary Health Inspection',
      tag: 'Vet Examination',
      imagePath: 'assets/images/jersey_cow.png',
      isVideo: true,
      duration: '1:20',
      category: 'Health',
    ),
    GalleryMediaItem(
      id: 'g7',
      title: 'Nutrition & Feed Intake',
      tag: 'Feeding Time',
      imagePath: 'assets/images/gir_cow.png',
      isVideo: true,
      duration: '0:30',
      category: 'Routine',
    ),
    GalleryMediaItem(
      id: 'g8',
      title: 'Ultrasound Scan Recording',
      tag: 'Pregnancy Scan',
      imagePath: 'assets/images/murrah_buffalo.png',
      isVideo: true,
      duration: '2:15',
      category: 'Health',
    ),
  ];

  List<GalleryMediaItem> get _filteredItems {
    return _galleryItems.where((item) {
      // Type Filter
      if (_selectedTypeIndex == 1 && item.isVideo) return false;
      if (_selectedTypeIndex == 2 && !item.isVideo) return false;

      // Category Filter
      if (_selectedCategoryIndex == 1 && item.category != 'Anatomical') return false;
      if (_selectedCategoryIndex == 2 && item.category != 'Routine') return false;
      if (_selectedCategoryIndex == 3 && item.category != 'Health') return false;

      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final photosCount = _galleryItems.where((e) => !e.isVideo).length;
    final videosCount = _galleryItems.where((e) => e.isVideo).length;

    return Scaffold(
      drawer: const UserDrawer(),
      backgroundColor: const Color(0xFFEFF6F1),
      appBar: _buildAppBar(photosCount, videosCount),
      body: CustomScrollView(
        slivers: [
          // 1. Featured Media Hero Banner
          SliverToBoxAdapter(
            child: _buildFeaturedShowcase(),
          ),

          // 2. Type Segmented Toggle
          SliverToBoxAdapter(
            child: _buildTypeSegmentedControl(),
          ),

          // 3. Category Filter Chips
          SliverToBoxAdapter(
            child: _buildCategoryFilterChips(),
          ),

          // 4. Section Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Media Library (${_filteredItems.length})',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const Text(
                    'Tap item to view',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 5. Grid of Media Items
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            sliver: _filteredItems.isEmpty
                ? const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: Center(
                        child: Text(
                          'No media found for selected filter.',
                          style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                        ),
                      ),
                    ),
                  )
                : SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.85,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildMediaCard(_filteredItems[index]),
                      childCount: _filteredItems.length,
                    ),
                  ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 32),
          ),
        ],
      ),
      bottomNavigationBar: const DairyBottomNavBar(selectedIndex: -1),
    );
  }

  // ── AppBar ──────────────────────────────────────────────
  PreferredSizeWidget _buildAppBar(int photosCount, int videosCount) {
    return AppBar(
      backgroundColor: const Color(0xFF0C3823),
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 22),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Column(
        children: [
          const Text(
            'Animal Gallery',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          Text(
            '$photosCount Photos • $videosCount Videos',
            style: const TextStyle(
              fontSize: 11,
              color: Colors.white60,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }

  // ── Featured Media Showcase ──────────────────────────────
  Widget _buildFeaturedShowcase() {
    final featured = _galleryItems.first;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Image
            Positioned.fill(
              child: Image.asset(
                featured.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFF0C3823),
                  child: const Icon(Icons.pets, size: 60, color: Colors.white38),
                ),
              ),
            ),
            // Gradient Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.1),
                      Colors.black.withValues(alpha: 0.75),
                    ],
                    stops: const [0.4, 1.0],
                  ),
                ),
              ),
            ),

            // Top Badge
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF0C3823).withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 0.5),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.auto_awesome, color: Colors.white, size: 12),
                    SizedBox(width: 4),
                    Text(
                      'Featured Angle • HD',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Center Action / Tap
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _showMediaViewer(context, featured),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      child: const Icon(
                        Icons.fullscreen_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Bottom Text Info
            Positioned(
              left: 14,
              right: 14,
              bottom: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        featured.tag,
                        style: TextStyle(
                          color: const Color(0xFF86EFAC),
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        featured.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'View Full HD',
                      style: TextStyle(
                        color: Color(0xFF0C3823),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Type Segmented Control Toggle ─────────────────────────
  Widget _buildTypeSegmentedControl() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      height: 42,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: List.generate(_typeFilters.length, (index) {
          final isSelected = _selectedTypeIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTypeIndex = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    _typeFilters[index],
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? const Color(0xFF0C3823) : const Color(0xFF4B5563),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ── Category Filter Chips ─────────────────────────────────
  Widget _buildCategoryFilterChips() {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categoryFilters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = _selectedCategoryIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategoryIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF0C3823) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? const Color(0xFF0C3823) : const Color(0xFFD1D5DB),
                ),
              ),
              child: Text(
                _categoryFilters[index],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF4B5563),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Media Card Item ───────────────────────────────────────
  Widget _buildMediaCard(GalleryMediaItem item) {
    return GestureDetector(
      onTap: () => _showMediaViewer(context, item),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            children: [
              // Cover Image
              Positioned.fill(
                child: Image.asset(
                  item.imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFFE5E7EB),
                    child: const Icon(Icons.image, size: 40, color: Colors.black26),
                  ),
                ),
              ),

              // Subtle Gradient Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.25),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.75),
                      ],
                      stops: const [0.0, 0.4, 1.0],
                    ),
                  ),
                ),
              ),

              // Top Tag Pill
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    item.tag,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // Video Duration or Photo Badge (Top Right)
              if (item.isVideo)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.videocam, color: Colors.white, size: 10),
                        const SizedBox(width: 3),
                        Text(
                          item.duration,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Play Button Overlay in Center if Video
              if (item.isVideo)
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),

              // Bottom Title Text
              Positioned(
                left: 10,
                right: 10,
                bottom: 8,
                child: Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Interactive Lightbox Modal ─────────────────────────────
  void _showMediaViewer(BuildContext context, GalleryMediaItem item) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.92),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            bool isPlaying = false;

            return Dialog.fullscreen(
              backgroundColor: Colors.black,
              child: SafeArea(
                child: Stack(
                  children: [
                    // Media Content
                    Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          InteractiveViewer(
                            minScale: 0.8,
                            maxScale: 3.0,
                            child: Image.asset(
                              item.imagePath,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => Container(
                                color: const Color(0xFF111827),
                                child: const Center(
                                  child: Icon(Icons.pets, size: 80, color: Colors.white30),
                                ),
                              ),
                            ),
                          ),

                          // Video Overlay Simulation
                          if (item.isVideo)
                            GestureDetector(
                              onTap: () {
                                setModalState(() => isPlaying = !isPlaying);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.6),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                                child: Icon(
                                  isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                  color: Colors.white,
                                  size: 44,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // Top Bar Info
                    Positioned(
                      top: 10,
                      left: 16,
                      right: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0C3823),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Text(
                                  item.tag,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.white, size: 28),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),

                    // Bottom Toolbar
                    Positioned(
                      bottom: 20,
                      left: 16,
                      right: 16,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (item.isVideo)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Column(
                                children: [
                                  Slider(
                                    value: isPlaying ? 0.45 : 0.0,
                                    onChanged: (val) {},
                                    activeColor: const Color(0xFF22C55E),
                                    inactiveColor: Colors.white30,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        isPlaying ? '0:20' : '0:00',
                                        style: const TextStyle(color: Colors.white70, fontSize: 11),
                                      ),
                                      Text(
                                        item.duration,
                                        style: const TextStyle(color: Colors.white70, fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.share_outlined, color: Colors.white, size: 22),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.download_outlined, color: Colors.white, size: 22),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.info_outline, color: Colors.white, size: 22),
                                onPressed: () {},
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
          },
        );
      },
    );
  }

}
