import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sxe/ui/theme/sxe_colors.dart';
import 'package:sxe/ui/theme/sxe_typography.dart';
import 'package:sxe/ui/screens/vision/notion_vision_detail_screen.dart';
import 'package:sxe/ui/screens/visionboard/spiritual_screen.dart';
import 'package:sxe/ui/screens/vision/diet_detail_screen.dart';

class VisionBoardScreen extends StatefulWidget {
  const VisionBoardScreen({super.key});

  @override
  State<VisionBoardScreen> createState() => _VisionBoardScreenState();
}

class _VisionBoardScreenState extends State<VisionBoardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final Map<String, List<Map<String, dynamic>>> _visionCategories = {
    'SOUL': [
      {
        'title': 'Spiritual',
        'icon': LucideIcons.handMetal,
        'progress': 0.8,
        'color': SXEColors.kelp,
        'aiSummary':
            'Excellent consistency in spiritual practices bringing peace to your life.',
        'status': 'Excellent'
      },
      {
        'title': 'Diet',
        'icon': LucideIcons.utensils,
        'progress': 0.6,
        'color': SXEColors.kelp,
        'aiSummary':
            'Good progress on healthy eating. Consider meal prepping for consistency.',
        'status': 'Good Progress'
      },
      {
        'title': 'Exercise',
        'icon': LucideIcons.dumbbell,
        'progress': 0.7,
        'color': SXEColors.coral,
        'aiSummary':
            'Strong workout routine with visible improvements in strength.',
        'status': 'Good Progress'
      },
      {
        'title': 'Family',
        'icon': LucideIcons.users,
        'progress': 0.9,
        'color': SXEColors.aubergine,
        'aiSummary':
            'Outstanding family relationships with strong bonds and quality time.',
        'status': 'Excellent'
      },
      {
        'title': 'Social',
        'icon': LucideIcons.users2,
        'progress': 0.5,
        'color': SXEColors.coral,
        'aiSummary':
            'Room for improvement. Schedule regular meetups with friends.',
        'status': 'Needs Attention'
      },
    ],
    'LIFE': [
      {
        'title': 'Memories',
        'icon': LucideIcons.camera,
        'progress': 0.9,
        'color': SXEColors.kelp,
        'aiSummary': 'Amazing job capturing life moments consistently!',
        'status': 'Excellent'
      },
      {
        'title': 'Events',
        'icon': LucideIcons.calendar,
        'progress': 0.4,
        'color': SXEColors.lilac,
        'aiSummary': 'Consider planning more social events and fun activities.',
        'status': 'Fair'
      },
      {
        'title': 'Travels',
        'icon': LucideIcons.plane,
        'progress': 0.3,
        'color': SXEColors.aubergine,
        'aiSummary':
            'Travel goals need attention. Start planning your next adventure.',
        'status': 'Needs Attention'
      },
      {
        'title': 'Shopping',
        'icon': LucideIcons.shoppingBag,
        'progress': 0.6,
        'color': SXEColors.lilac,
        'aiSummary':
            'Balanced approach with thoughtful purchases within budget.',
        'status': 'Good Progress'
      },
      {
        'title': 'Documents',
        'icon': LucideIcons.fileText,
        'progress': 0.4,
        'color': SXEColors.lilac,
        'aiSummary':
            'Document organization needs improvement. Consider digitizing papers.',
        'status': 'Fair'
      },
    ],
    'WEALTH': [
      {
        'title': 'Networth',
        'icon': LucideIcons.piggyBank,
        'progress': 0.6,
        'color': SXEColors.midnight,
        'aiSummary':
            'Steady growth in net worth. Consider diversifying investments.',
        'status': 'Good Progress'
      },
      {
        'title': 'Loans & Credits',
        'icon': LucideIcons.creditCard,
        'progress': 0.8,
        'color': SXEColors.kelp,
        'aiSummary': 'Excellent debt management with consistent payments.',
        'status': 'Excellent'
      },
      {
        'title': 'Assets',
        'icon': LucideIcons.gem,
        'progress': 0.4,
        'color': SXEColors.coral,
        'aiSummary':
            'Asset portfolio needs attention. Consider real estate or stocks.',
        'status': 'Fair'
      },
      {
        'title': 'Investments',
        'icon': LucideIcons.barChart3,
        'progress': 0.5,
        'color': SXEColors.aubergine
      },
      {
        'title': 'Charity',
        'icon': LucideIcons.heart,
        'progress': 0.7,
        'color': SXEColors.lilac
      },
    ],
    'LEARN': [
      {
        'title': 'School',
        'icon': LucideIcons.graduationCap,
        'progress': 1.0,
        'color': SXEColors.midnight
      },
      {
        'title': 'Degree',
        'icon': LucideIcons.bookOpen,
        'progress': 0.8,
        'color': SXEColors.kelp
      },
      {
        'title': 'Masters',
        'icon': LucideIcons.award,
        'progress': 0.3,
        'color': SXEColors.coral
      },
      {
        'title': 'Certificates',
        'icon': LucideIcons.award,
        'progress': 0.6,
        'color': SXEColors.aubergine
      },
      {
        'title': 'Skills',
        'icon': LucideIcons.brain,
        'progress': 0.7,
        'color': SXEColors.lilac
      },
    ],
    'EARN': [
      {
        'title': 'Job',
        'icon': LucideIcons.briefcase,
        'progress': 0.9,
        'color': SXEColors.midnight
      },
      {
        'title': 'Franchise',
        'icon': LucideIcons.store,
        'progress': 0.2,
        'color': SXEColors.kelp
      },
      {
        'title': 'Stock',
        'icon': LucideIcons.trendingUp,
        'progress': 0.5,
        'color': SXEColors.coral
      },
      {
        'title': 'Crypto',
        'icon': LucideIcons.bitcoin,
        'progress': 0.3,
        'color': SXEColors.aubergine
      },
      {
        'title': 'Properties',
        'icon': LucideIcons.home,
        'progress': 0.1,
        'color': SXEColors.lilac
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check if running on web
    if (kIsWeb) {
      return _buildWebView();
    } else {
      return _buildMobileView();
    }
  }

  Widget _buildMobileView() {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              controller: _tabController,
              labelColor: Colors.deepOrangeAccent,
              unselectedLabelColor: Colors.black,
              labelStyle: SXETypography.bodySmall.copyWith(
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: SXETypography.bodySmall.copyWith(
                fontWeight: FontWeight.w700,
              ),
              indicatorColor: Colors.deepOrangeAccent,
              indicatorWeight: 3,
              tabs: _visionCategories.keys.map((category) {
                return Tab(text: category);
              }).toList(),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _visionCategories.entries.map((entry) {
                  return _buildCategoryView(entry.key, entry.value);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWebView() {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Vision Board',
              style: SXETypography.functionalHeadline.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Track your life goals and progress across different areas',
              style: SXETypography.bodyMedium.copyWith(
                color: SXEColors.textSecondary,
              ),
            ),
            const SizedBox(height: 32),

            // All categories in a single scrollable view
            ..._visionCategories.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Header
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      entry.key,
                      style: SXETypography.functionalHeadline.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Category Cards
                  ...entry.value.map((card) {
                    return _VisionCard(
                      title: card['title'],
                      icon: card['icon'],
                      progress: card['progress'],
                      color: card['color'],
                      onTap: () => _navigateToDetail(card, entry.key),
                      aiSummary: card['aiSummary'],
                      progressStatus: card['progressStatus'],
                      status: card['status'],
                    );
                  }),

                  const SizedBox(height: 32),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryView(String category, List<Map<String, dynamic>> cards) {
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return _VisionCard(
          title: card['title'],
          icon: card['icon'],
          progress: card['progress'],
          color: card['color'],
          onTap: () => _navigateToDetail(card, category),
          // aiSummary: card['aiSummary'],
          progressStatus: card['progressStatus'],
          status: card['status'],
        );
      },
    );
  }

  void _navigateToDetail(Map<String, dynamic> card, String category) {
    final title = card['title'] as String;

    // Navigate to specific screens for certain cards
    if (title == 'Spiritual') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SpiritualScreen(),
        ),
      );
    } else if (title == 'Diet') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const DietDetailScreen(),
        ),
      );
    } else {
      // Default navigation for other cards
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotionVisionDetailScreen(
            title: card['title'],
            category: category,
            icon: card['icon'],
            progress: card['progress'],
            color: card['color'],
          ),
        ),
      );
    }
  }
}

class _VisionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final double progress;
  final Color color;
  final VoidCallback onTap;
  final String? aiSummary;
  final String? progressStatus;
  final String? status;

  const _VisionCard({
    required this.title,
    required this.icon,
    required this.progress,
    required this.color,
    required this.onTap,
    this.aiSummary,
    this.progressStatus,
    this.status,
  });

  Color get _getStatusColor {
    if (progress >= 0.8) return SXEColors.kelp; // Excellent
    if (progress >= 0.6) return SXEColors.aubergine; // Good
    if (progress >= 0.4) return SXEColors.midnight; // Fair
    return SXEColors.coral; // Needs attention
  }

  String get _getStatusText {
    if (progress >= 0.8) return 'Excellent';
    if (progress >= 0.6) return 'Good Progress';
    if (progress >= 0.4) return 'Fair';
    return 'Needs Attention';
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor;
    final statusText = status ?? _getStatusText;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: SXEColors.surface,
          border: Border(bottom: BorderSide(color: SXEColors.borderLight, width: 1)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Icon(
                        icon,
                        color: statusColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: SXETypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            statusText,
                            style: SXETypography.bodySmall.copyWith(
                              color: statusColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: SXETypography.bodyMedium.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: SXEColors.borderLight,
              valueColor: AlwaysStoppedAnimation<Color>(statusColor),
              borderRadius: BorderRadius.circular(4),
            ),
            if (aiSummary != null) ...[
              const SizedBox(height: 12),
              Text(
                aiSummary!,
                style: SXETypography.bodySmall.copyWith(
                  color: SXEColors.textSecondary,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
