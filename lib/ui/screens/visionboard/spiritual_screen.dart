import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sxe/ui/theme/sxe_colors.dart';
import 'package:sxe/ui/theme/sxe_typography.dart';

class SpiritualScreen extends StatefulWidget {
  const SpiritualScreen({super.key});

  @override
  State<SpiritualScreen> createState() => _SpiritualScreenState();
}

class _SpiritualScreenState extends State<SpiritualScreen> {
  // Spiritual practices tracking
  final List<Map<String, dynamic>> _dailyPractices = [
    {
      'name': 'Morning Prayer',
      'completed': false,
      'time': '06:00',
      'duration': 15
    },
    {'name': 'Meditation', 'completed': false, 'time': '07:00', 'duration': 20},
    {
      'name': 'Scripture Reading',
      'completed': false,
      'time': '19:00',
      'duration': 30
    },
    {
      'name': 'Evening Prayer',
      'completed': false,
      'time': '20:00',
      'duration': 10
    },
    {
      'name': 'Gratitude Journal',
      'completed': false,
      'time': '21:00',
      'duration': 10
    },
  ];

  final List<Map<String, dynamic>> _weeklyGoals = [
    {
      'goal': 'Attend weekly service',
      'completed': false,
      'progress': 0,
      'target': 1
    },
    {
      'goal': 'Complete spiritual book',
      'completed': false,
      'progress': 3,
      'target': 10
    },
    {
      'goal': 'Practice charity',
      'completed': false,
      'progress': 2,
      'target': 5
    },
    {
      'goal': 'Spiritual discussions',
      'completed': false,
      'progress': 1,
      'target': 3
    },
  ];

  double _monthlyCharityGoal = 200.0;
  double _currentCharity = 75.0;
  int _prayerStreak = 12;
  int _meditationMinutes = 340;

  @override
  Widget build(BuildContext context) {
    final completedPractices =
        _dailyPractices.where((p) => p['completed'] == true).length;
    final practiceProgress = completedPractices / _dailyPractices.length;
    final charityProgress = _currentCharity / _monthlyCharityGoal;

    return Scaffold(
      backgroundColor: SXEColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Spiritual Journey',
          style: SXETypography.functionalHeadline,
        ),
        backgroundColor: SXEColors.background,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showInsightsDialog(),
            icon: Icon(
              LucideIcons.lightbulb,
              color: SXEColors.textPrimary,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Overview Cards
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Prayer Streak',
                    value: '$_prayerStreak days',
                    icon: LucideIcons.flame,
                    color: SXEColors.coral,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    title: 'Meditation',
                    value: '${_meditationMinutes}min',
                    icon: LucideIcons.brain,
                    color: SXEColors.kelp,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Daily Practices Progress
            Container(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Today\'s Practices',
                        style: SXETypography.functionalHeadline,
                      ),
                      Text(
                        '$completedPractices/${_dailyPractices.length}',
                        style: SXETypography.bodyMedium.copyWith(
                          color: SXEColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: practiceProgress,
                    backgroundColor: SXEColors.borderLight,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(SXEColors.primary),
                  ),
                  const SizedBox(height: 20),
                  ..._dailyPractices.map((practice) => _PracticeItem(
                        name: practice['name'],
                        time: practice['time'],
                        duration: practice['duration'],
                        completed: practice['completed'],
                        onToggle: () => _togglePractice(practice),
                      )),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Weekly Goals
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: SXEColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: SXEColors.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Weekly Goals',
                    style: SXETypography.functionalHeadline,
                  ),
                  const SizedBox(height: 16),
                  ..._weeklyGoals.map((goal) => _GoalItem(
                        goal: goal['goal'],
                        progress: goal['progress'],
                        target: goal['target'],
                        completed: goal['completed'],
                        onTap: () => _updateGoalProgress(goal),
                      )),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Charity Tracker
            Container(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Charity This Month',
                        style: SXETypography.functionalHeadline,
                      ),
                      IconButton(
                        onPressed: () => _showCharityDialog(),
                        icon: const Icon(LucideIcons.plus, size: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: charityProgress,
                    backgroundColor: SXEColors.borderLight,
                    valueColor: AlwaysStoppedAnimation<Color>(SXEColors.coral),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${_currentCharity.toStringAsFixed(0)}',
                        style: SXETypography.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Goal: \$${_monthlyCharityGoal.toStringAsFixed(0)}',
                        style: SXETypography.bodyMedium.copyWith(
                          color: SXEColors.textSecondary,
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

  void _togglePractice(Map<String, dynamic> practice) {
    setState(() {
      practice['completed'] = !practice['completed'];
      if (practice['completed']) {
        _meditationMinutes += practice['duration'] as int;
      }
    });
  }

  void _updateGoalProgress(Map<String, dynamic> goal) {
    setState(() {
      if (goal['progress'] < goal['target']) {
        goal['progress']++;
        if (goal['progress'] >= goal['target']) {
          goal['completed'] = true;
        }
      }
    });
  }

  void _showCharityDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Charity'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount (\$)',
                prefixIcon: Icon(LucideIcons.dollarSign),
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                final amount = double.tryParse(value) ?? 0;
                setState(() {
                  _currentCharity += amount;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showInsightsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Spiritual Insights'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🔥 You\'re on a $_prayerStreak day prayer streak!'),
            const SizedBox(height: 8),
            Text('🧘 Total meditation: ${_meditationMinutes} minutes'),
            const SizedBox(height: 8),
            Text(
                '💝 Charity progress: ${(_currentCharity / _monthlyCharityGoal * 100).toStringAsFixed(0)}%'),
            const SizedBox(height: 16),
            const Text(
                'Keep up the great spiritual work! Consistency is key to growth.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

// Stat Card Widget
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: SXETypography.functionalHeadline.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: SXETypography.bodySmall.copyWith(
              color: SXEColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// Practice Item Widget
class _PracticeItem extends StatelessWidget {
  final String name;
  final String time;
  final int duration;
  final bool completed;
  final VoidCallback onToggle;

  const _PracticeItem({
    required this.name,
    required this.time,
    required this.duration,
    required this.completed,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: completed ? SXEColors.primary : Colors.transparent,
                border: Border.all(
                  color: completed ? SXEColors.primary : SXEColors.borderLight,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: completed
                  ? const Icon(
                      LucideIcons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: SXETypography.bodyMedium.copyWith(
                    decoration: completed ? TextDecoration.lineThrough : null,
                    color: completed
                        ? SXEColors.textSecondary
                        : SXEColors.textPrimary,
                  ),
                ),
                Text(
                  '$time • ${duration}min',
                  style: SXETypography.bodySmall.copyWith(
                    color: SXEColors.textSecondary,
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

// Goal Item Widget
class _GoalItem extends StatelessWidget {
  final String goal;
  final int progress;
  final int target;
  final bool completed;
  final VoidCallback onTap;

  const _GoalItem({
    required this.goal,
    required this.progress,
    required this.target,
    required this.completed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final progressPercent = progress / target;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          goal,
                          style: SXETypography.bodyMedium.copyWith(
                            decoration:
                                completed ? TextDecoration.lineThrough : null,
                            color: completed
                                ? SXEColors.textSecondary
                                : SXEColors.textPrimary,
                          ),
                        ),
                      ),
                      Text(
                        '$progress/$target',
                        style: SXETypography.bodySmall.copyWith(
                          color: SXEColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: progressPercent,
                    backgroundColor: SXEColors.borderLight,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      completed ? SXEColors.primary : SXEColors.kelp,
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
}

// Islamic Practice Screen (from previous implementation)
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
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
    // Implementation from previous code
  }

  void _showQuranDialog() {
    // Implementation from previous code
  }

  void _showCharityDialog() {
    // Implementation from previous code
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
