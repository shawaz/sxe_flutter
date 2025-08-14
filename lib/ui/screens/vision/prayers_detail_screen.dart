import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sxe/ui/theme/sxe_colors.dart';
import 'package:sxe/ui/theme/sxe_typography.dart';

class PrayersDetailScreen extends StatefulWidget {
  const PrayersDetailScreen({super.key});

  @override
  State<PrayersDetailScreen> createState() => _PrayersDetailScreenState();
}

class _PrayersDetailScreenState extends State<PrayersDetailScreen> {
  String _selectedReligion = '';

  final List<Map<String, dynamic>> _religions = [
    {
      'name': 'Islam',
      'icon': LucideIcons.moon,
      'color': SXEColors.kelp,
      'features': [
        'Prayer Tracker',
        'Quran Recitation',
        'Charity Tracker',
      ]
    },
    {
      'name': 'Christianity',
      'icon': LucideIcons.cross,
      'color': SXEColors.aubergine,
      'features': ['Prayer Tracker', 'Bible Reading', 'Service Tracker']
    },
    {
      'name': 'Judaism',
      'icon': LucideIcons.star,
      'color': SXEColors.midnight,
      'features': ['Prayer Tracker', 'Torah Study', 'Mitzvah Tracker']
    },
    {
      'name': 'Hinduism',
      'icon': LucideIcons.sun,
      'color': SXEColors.coral,
      'features': ['Prayer Tracker', 'Mantra Chanting', 'Puja Tracker']
    },
    {
      'name': 'Buddhism',
      'icon': LucideIcons.flower,
      'color': Colors.orange,
      'features': ['Meditation Tracker', 'Dharma Study', 'Mindfulness Practice']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SXEColors.background,
      appBar: AppBar(
        title: Text(
          'Spiritual Practice',
          style: SXETypography.functionalHeadline,
        ),
        backgroundColor: SXEColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Choose Your Faith',
              style: SXETypography.functionalHeadline.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Select your religion to customize your spiritual tracking experience',
              style: SXETypography.bodyMedium.copyWith(
                color: SXEColors.textSecondary,
              ),
            ),
            const SizedBox(height: 32),

            // Religion Selection
            ..._religions.map((religion) => _ReligionCard(
                  name: religion['name'],
                  icon: religion['icon'],
                  color: religion['color'],
                  features: List<String>.from(religion['features']),
                  isSelected: _selectedReligion == religion['name'],
                  onTap: () {
                    setState(() {
                      _selectedReligion = religion['name'];
                    });
                  },
                )),

            const SizedBox(height: 32),

            // Continue Button
            if (_selectedReligion.isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _navigateToReligionDetails(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: SXEColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Continue with $_selectedReligion',
                    style: SXETypography.buttonMedium.copyWith(
                      color: SXEColors.onPrimary,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _navigateToReligionDetails() {
    if (_selectedReligion == 'Islam') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const IslamicPracticeScreen(),
        ),
      );
    } else {
      // Show coming soon for other religions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$_selectedReligion practice tracking coming soon!'),
        ),
      );
    }
  }
}

class _ReligionCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final List<String> features;
  final bool isSelected;
  final VoidCallback onTap;

  const _ReligionCard({
    required this.name,
    required this.icon,
    required this.color,
    required this.features,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.1) : SXEColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : SXEColors.borderLight,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    name,
                    style: SXETypography.functionalHeadline.copyWith(
                      color: isSelected ? color : SXEColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      LucideIcons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Features:',
              style: SXETypography.bodySmall.copyWith(
                color: SXEColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ...features.map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.check,
                        size: 16,
                        color: color,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        feature,
                        style: SXETypography.bodySmall.copyWith(
                          color: SXEColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

// Islamic Feature Card Widget
class _IslamicFeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final double progress;
  final VoidCallback onTap;

  const _IslamicFeatureCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: SXEColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: SXEColors.borderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: SXETypography.functionalHeadline.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: SXETypography.bodySmall.copyWith(
                          color: SXEColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${(progress * 100).round()}%',
                    style: SXETypography.bodySmall.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              backgroundColor: SXEColors.borderLight,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      ),
    );
  }
}

// Islamic Practice Screen
class IslamicPracticeScreen extends StatefulWidget {
  const IslamicPracticeScreen({super.key});

  @override
  State<IslamicPracticeScreen> createState() => _IslamicPracticeScreenState();
}

class _IslamicPracticeScreenState extends State<IslamicPracticeScreen> {
  // Prayer tracking
  final List<Map<String, dynamic>> _prayers = [
    {'name': 'Fajr', 'completed': false, 'time': '05:30'},
    {'name': 'Dhuhr', 'completed': false, 'time': '12:30'},
    {'name': 'Asr', 'completed': false, 'time': '15:45'},
    {'name': 'Maghrib', 'completed': false, 'time': '18:20'},
    {'name': 'Isha', 'completed': false, 'time': '19:45'},
  ];

  // Quran recitation
  int _versesRead = 0;
  int _dailyVerseGoal = 10;

  // Charity tracking
  double _charityAmount = 0.0;
  double _monthlyCharityGoal = 100.0;

  @override
  Widget build(BuildContext context) {
    final completedPrayers =
        _prayers.where((p) => p['completed'] == true).length;
    final prayerProgress = completedPrayers / _prayers.length;
    final quranProgress = _versesRead / _dailyVerseGoal;
    final charityProgress = _charityAmount / _monthlyCharityGoal;

    return Scaffold(
      backgroundColor: SXEColors.background,
      appBar: AppBar(
        title: Text(
          'Islamic Practice',
          style: SXETypography.functionalHeadline,
        ),
        backgroundColor: SXEColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Prayer Tracker
            _IslamicFeatureCard(
              title: 'Prayer Tracker',
              subtitle:
                  '$completedPrayers of ${_prayers.length} prayers completed',
              icon: LucideIcons.moon,
              color: SXEColors.kelp,
              progress: prayerProgress,
              onTap: () => _showPrayersModal(),
            ),

            const SizedBox(height: 16),

            // Quran Recitation
            _IslamicFeatureCard(
              title: 'Quran Recitation',
              subtitle: '$_versesRead of $_dailyVerseGoal verses read today',
              icon: LucideIcons.bookOpen,
              color: SXEColors.aubergine,
              progress: quranProgress,
              onTap: () => _showQuranDialog(),
            ),

            const SizedBox(height: 16),

            // Charity Tracker
            _IslamicFeatureCard(
              title: 'Charity Tracker',
              subtitle:
                  '\$${_charityAmount.toStringAsFixed(2)} of \$${_monthlyCharityGoal.toStringAsFixed(2)} this month',
              icon: LucideIcons.heart,
              color: SXEColors.coral,
              progress: charityProgress,
              onTap: () => _showCharityDialog(),
            ),
          ],
        ),
      ),
    );
  }

  void _showPrayersModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: SXEColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daily Prayers',
                  style: SXETypography.functionalHeadline,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(LucideIcons.x),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ..._prayers.map((prayer) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    tileColor: prayer['completed']
                        ? SXEColors.kelp.withValues(alpha: 0.1)
                        : SXEColors.background,
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: prayer['completed']
                            ? SXEColors.kelp
                            : SXEColors.borderLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        prayer['completed']
                            ? LucideIcons.check
                            : LucideIcons.moon,
                        color: prayer['completed']
                            ? SXEColors.onPrimary
                            : SXEColors.textSecondary,
                        size: 20,
                      ),
                    ),
                    title: Text(
                      prayer['name'],
                      style: SXETypography.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: prayer['completed']
                            ? SXEColors.kelp
                            : SXEColors.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      prayer['time'],
                      style: SXETypography.bodySmall.copyWith(
                        color: SXEColors.textSecondary,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        prayer['completed'] = !prayer['completed'];
                      });
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void _showQuranDialog() {
    final controller = TextEditingController(text: _versesRead.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: SXEColors.surface,
        title: Text(
          'Quran Recitation',
          style: SXETypography.functionalHeadline,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Verses read today',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
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
              setState(() {
                _versesRead = int.tryParse(controller.text) ?? 0;
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showCharityDialog() {
    final controller = TextEditingController(text: _charityAmount.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: SXEColors.surface,
        title: Text(
          'Charity Tracker',
          style: SXETypography.functionalHeadline,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount donated this month (\$)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
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
              setState(() {
                _charityAmount = double.tryParse(controller.text) ?? 0.0;
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
