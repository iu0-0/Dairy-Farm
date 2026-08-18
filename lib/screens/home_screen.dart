import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/bottom_nav_bar.dart';
import '../utils/smooth_page_route.dart';
import 'animal_listing_screen.dart';
import 'milk_yield_screen.dart';
import 'health_screen.dart';
import 'feed_screen.dart';
import 'admin_panel_screen.dart';


// ─────────────────────────────────────────────
// HomeScreen — Farm Dashboard (Premium)
// ─────────────────────────────────────────────
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // ── Design tokens ─────────────────────────────
  static const Color _primaryGreen = Color(0xFF0C3823);
  static const Color _accent = Color(0xFF22C55E);
  static const Color _bg = Color(0xFFEFF6F1);
  static const Color _textDark = Color(0xFF1F2937);
  static const Color _textGrey = Color(0xFF6B7280);
  static const Color _divider = Color(0xFFE5E7EB);

  // ── Hero carousel ──────────────────────────────
  final PageController _heroController = PageController();
  int _currentHeroPage = 0;
  Timer? _heroTimer;

  final List<_HeroSlide> _heroSlides = const [
    _HeroSlide(
      image: 'assets/images/farm_hero_banner.png',
      tag: '🌿 Welcome to Your Farm',
      title: 'Krishna Dairy Farm',
      subtitle: 'Managing 48 animals across 3 breeds',
    ),
    _HeroSlide(
      image: 'assets/images/farm_animals.png',
      tag: '🐄 Animal Overview',
      title: '46 Healthy Animals',
      subtitle: '2 under veterinary observation',
    ),
    _HeroSlide(
      image: 'assets/images/milk_production.png',
      tag: '🥛 Today\'s Production',
      title: '312 Litres Collected',
      subtitle: '↑ 4.2% above yesterday\'s yield',
    ),
  ];

  // ── Breed showcase ─────────────────────────────
  final List<_BreedCard> _breeds = const [
    _BreedCard(
      name: 'Gir Cow',
      image: 'assets/images/gir_cow.png',
      count: 12,
      avgMilk: '14 L/day',
      color: Color(0xFFFEF3C7),
      accent: Color(0xFFD97706),
    ),
    _BreedCard(
      name: 'Holstein Friesian',
      image: 'assets/images/holstein_friesian.png',
      count: 18,
      avgMilk: '22 L/day',
      color: Color(0xFFE0F2FE),
      accent: Color(0xFF0284C7),
    ),
    _BreedCard(
      name: 'Jersey Cow',
      image: 'assets/images/jersey_cow.png',
      count: 10,
      avgMilk: '17 L/day',
      color: Color(0xFFDCFCE7),
      accent: Color(0xFF16A34A),
    ),
    _BreedCard(
      name: 'Murrah Buffalo',
      image: 'assets/images/murrah_buffalo.png',
      count: 8,
      avgMilk: '11 L/day',
      color: Color(0xFFF3E8FF),
      accent: Color(0xFF7C3AED),
    ),
  ];

  // ── Animation controller ───────────────────────
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _heroTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_heroController.hasClients) {
        final next = (_currentHeroPage + 1) % _heroSlides.length;
        _heroController.animateToPage(next,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut);
      }
    });

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _heroTimer?.cancel();
    _heroController.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      drawer: const AppDrawer(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(child: _buildBody()),
        ],
      ),
      bottomNavigationBar: const DairyBottomNavBar(selectedIndex: 1),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Hero Image Carousel ──
        _buildHeroCarousel(),

        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Stats Row ──
              _buildStatsRow(),
              const SizedBox(height: 20),

              // ── Health Alert ──
              _buildAlertBanner(),
              const SizedBox(height: 24),

              // ── Quick Actions ──
              _buildSectionHeader('Quick Actions'),
              const SizedBox(height: 12),
              _buildQuickActions(),
              const SizedBox(height: 24),
            ],
          ),
        ),

        // ── Breed Showcase ──
        _buildSectionHeaderPadded('Our Breeds'),
        const SizedBox(height: 12),
        _buildBreedCarousel(),
        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Today's Activity ──
              _buildSectionHeader("Today's Activity"),
              const SizedBox(height: 12),
              _buildActivityCard(),
              const SizedBox(height: 24),

              // ── Milk Summary ──
              _buildSectionHeader('Milk Production'),
              const SizedBox(height: 12),
              _buildMilkSummaryCard(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }

  // ── Sliver App Bar ─────────────────────────────
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      pinned: true,
      backgroundColor: _primaryGreen,
      elevation: 0,
      leading: Builder(
        builder: (ctx) => IconButton(
          icon: const Icon(Icons.menu, color: Colors.white, size: 22),
          onPressed: () => Scaffold.of(ctx).openDrawer(),
        ),
      ),
      title: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/dairy_logo.png',
              height: 34,
              width: 34,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.agriculture,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Krishna Dairy',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800)),
              Text('Good Morning, Rahul 🌿',
                  style:
                      TextStyle(color: Colors.white60, fontSize: 10.5)),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          tooltip: 'Admin Control Center',
          icon: const Icon(Icons.admin_panel_settings, color: Color(0xFF86EFAC), size: 22),
          onPressed: () {
            Navigator.push(
              context,
              SmoothPageRoute(
                page: const AdminPanelScreen(),
                settings: const RouteSettings(name: '/admin'),
              ),
            );
          },
        ),
        Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined,
                  color: Colors.white, size: 22),
              onPressed: () {},
            ),
            Positioned(
              top: 10,
              right: 10,
              child: ScaleTransition(
                scale: _pulseAnim,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF6B6B),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  // ── Hero Carousel ──────────────────────────────
  Widget _buildHeroCarousel() {
    return SizedBox(
      height: 220,
      child: Stack(
        children: [
          PageView.builder(
            controller: _heroController,
            onPageChanged: (i) => setState(() => _currentHeroPage = i),
            itemCount: _heroSlides.length,
            itemBuilder: (_, i) => _buildHeroSlide(_heroSlides[i]),
          ),
          // Dots
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _heroSlides.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: _currentHeroPage == i ? 20 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _currentHeroPage == i
                        ? Colors.white
                        : Colors.white54,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSlide(_HeroSlide slide) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          slide.image,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0C3823), Color(0xFF1A5E3A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        // Gradient overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.65),
              ],
              stops: const [0.35, 1.0],
            ),
          ),
        ),
        // Text
        Positioned(
          left: 20,
          right: 20,
          bottom: 28,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _accent.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(slide.tag,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 6),
              Text(slide.title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      height: 1.2)),
              const SizedBox(height: 3),
              Text(slide.subtitle,
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }

  // ── Stats Row ──────────────────────────────────
  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
            child: _buildStatCard(
          icon: Icons.pets,
          iconColor: const Color(0xFF16A34A),
          iconBg: const Color(0xFFDCFCE7),
          value: '48',
          label: 'Total Animals',
        )),
        const SizedBox(width: 12),
        Expanded(
            child: _buildStatCard(
          icon: Icons.water_drop,
          iconColor: const Color(0xFF0284C7),
          iconBg: const Color(0xFFE0F2FE),
          value: '312 L',
          label: "Today's Milk",
        )),
        const SizedBox(width: 12),
        Expanded(
            child: _buildStatCard(
          icon: Icons.favorite,
          iconColor: const Color(0xFF16A34A),
          iconBg: const Color(0xFFDCFCE7),
          value: '46',
          label: 'Healthy',
        )),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20, color: iconColor),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: _textDark,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10, color: _textGrey),
          ),
        ],
      ),
    );
  }

  // ── Alert Banner ───────────────────────────────
  Widget _buildAlertBanner() {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => const HealthScreen())),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFF7ED), Color(0xFFFEF3C7)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFFDE68A), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFD97706).withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.warning_amber_rounded,
                  size: 24, color: Color(0xFFD97706)),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '2 Animals Need Attention',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF92400E),
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Vaccination due for Bessie & Daisy',
                    style: TextStyle(fontSize: 11.5, color: Color(0xFFB45309)),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFD97706).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.chevron_right,
                  color: Color(0xFFD97706), size: 18),
            ),
          ],
        ),
      ),
    );
  }

  // ── Section Headers ────────────────────────────
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: _textDark,
        letterSpacing: -0.3,
      ),
    );
  }

  Widget _buildSectionHeaderPadded(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: _textDark,
                  letterSpacing: -0.3)),
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AnimalListingScreen())),
            child: const Text('See All',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF16A34A))),
          ),
        ],
      ),
    );
  }

  // ── Quick Actions ──────────────────────────────
  Widget _buildQuickActions() {
    final actions = [
      _QuickAction(
        icon: Icons.pets,
        label: 'Animals',
        bg: const Color(0xFFDCFCE7),
        color: const Color(0xFF16A34A),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const AnimalListingScreen())),
      ),
      _QuickAction(
        icon: Icons.water_drop_outlined,
        label: 'Milk',
        bg: const Color(0xFFE0F2FE),
        color: const Color(0xFF0284C7),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const MilkYieldScreen())),
      ),
      _QuickAction(
        icon: Icons.health_and_safety_outlined,
        label: 'Health',
        bg: const Color(0xFFFEE2E2),
        color: const Color(0xFFDC2626),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const HealthScreen())),
      ),
      _QuickAction(
        icon: Icons.grass_outlined,
        label: 'Feed',
        bg: const Color(0xFFFFF7ED),
        color: const Color(0xFFD97706),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const FeedScreen())),
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions
          .map((a) => Expanded(
                child: GestureDetector(
                  onTap: a.onTap,
                  child: Container(
                    margin: EdgeInsets.only(right: actions.last == a ? 0 : 10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: a.bg,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Icon(a.icon, size: 22, color: a.color),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          a.label,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ))
          .toList(),
    );
  }

  // ── Breed Carousel ─────────────────────────────
  Widget _buildBreedCarousel() {
    return SizedBox(
      height: 170,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _breeds.length,
        itemBuilder: (_, i) => _buildBreedCard(_breeds[i]),
      ),
    );
  }

  Widget _buildBreedCard(_BreedCard breed) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => const AnimalListingScreen())),
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(18)),
              child: Image.asset(
                breed.image,
                height: 95,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 95,
                  color: breed.color,
                  child: Icon(Icons.pets, color: breed.accent, size: 36),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(breed.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: _textDark)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: breed.color,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('${breed.count} animals',
                            style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                color: breed.accent)),
                      ),
                      const Spacer(),
                      Text(breed.avgMilk,
                          style: const TextStyle(
                              fontSize: 9.5,
                              color: _textGrey,
                              fontWeight: FontWeight.w600)),
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

  // ── Activity Card ──────────────────────────────
  Widget _buildActivityCard() {
    final items = [
      const _ActivityItem(
          icon: Icons.check_circle_outline,
          color: Color(0xFF16A34A),
          text: 'Morning milking completed — 168 L'),
      const _ActivityItem(
          icon: Icons.vaccines_outlined,
          color: Color(0xFF6366F1),
          text: 'Vaccination: Lola (H-01) ✓'),
      const _ActivityItem(
          icon: Icons.grass_outlined,
          color: Color(0xFFD97706),
          text: 'Feed stock refilled — Hay 200 kg'),
      const _ActivityItem(
          icon: Icons.warning_amber_rounded,
          color: Color(0xFFDC2626),
          text: 'Health alert: Bessie under observation'),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: items.asMap().entries.map((e) {
          final isLast = e.key == items.length - 1;
          return Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: e.value.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(e.value.icon,
                          size: 20, color: e.value.color),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        e.value.text,
                        style: const TextStyle(
                            fontSize: 12.5,
                            color: _textDark,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                const Divider(height: 1, indent: 66, color: _divider),
            ],
          );
        }).toList(),
      ),
    );
  }

  // ── Milk Summary Card ──────────────────────────
  Widget _buildMilkSummaryCard() {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => const MilkYieldScreen())),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _primaryGreen.withValues(alpha: 0.35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  'assets/images/milk_production.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF0C3823), Color(0xFF1A5E3A)],
                      ),
                    ),
                  ),
                ),
              ),
              // Overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Colors.transparent,
                        _primaryGreen.withValues(alpha: 0.9),
                      ],
                      stops: const [0.2, 1.0],
                    ),
                  ),
                ),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Today's Total Milk",
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                        const SizedBox(height: 4),
                        const Text('312 Litres',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w900)),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: _accent.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            '↑ 4.2% from yesterday',
                            style: TextStyle(
                                color: Color(0xFF86EFAC),
                                fontSize: 11,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                            width: 1.5),
                      ),
                      child: const Icon(Icons.water_drop,
                          size: 32, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ── Data models ────────────────────────────────────
class _HeroSlide {
  final String image;
  final String tag;
  final String title;
  final String subtitle;
  const _HeroSlide({
    required this.image,
    required this.tag,
    required this.title,
    required this.subtitle,
  });
}

class _BreedCard {
  final String name;
  final String image;
  final int count;
  final String avgMilk;
  final Color color;
  final Color accent;
  const _BreedCard({
    required this.name,
    required this.image,
    required this.count,
    required this.avgMilk,
    required this.color,
    required this.accent,
  });
}

class _QuickAction {
  final IconData icon;
  final String label;
  final Color bg;
  final Color color;
  final VoidCallback onTap;
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.bg,
    required this.color,
    required this.onTap,
  });
}

class _ActivityItem {
  final IconData icon;
  final Color color;
  final String text;
  const _ActivityItem(
      {required this.icon, required this.color, required this.text});
}
