import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sxe/ui/theme/sxe_colors.dart';
import 'package:sxe/ui/theme/sxe_typography.dart';

class ActivityTrackerScreen extends StatefulWidget {
  const ActivityTrackerScreen({super.key});

  @override
  State<ActivityTrackerScreen> createState() => _ActivityTrackerScreenState();
}

class _ActivityTrackerScreenState extends State<ActivityTrackerScreen> {
  DateTime _selectedDate = DateTime.now();
  int _selectedYear = DateTime.now().year;
  int _selectedWeek = _getWeekOfYear(DateTime.now());

  // Sleep tracking
  final List<Map<String, dynamic>> _sleepActivities = [
    {'title': 'WAKEUP', 'icon': LucideIcons.sun, 'completed': true},
    {'title': 'SLEEP', 'icon': LucideIcons.bed, 'completed': false},
  ];

  // Prayer tracking (5 daily prayers)
  final List<Map<String, dynamic>> _prayers = [
    {'name': 'Fajr', 'completed': false, 'time': '05:30'},
    {'name': 'Dhuhr', 'completed': false, 'time': '12:30'},
    {'name': 'Asr', 'completed': false, 'time': '15:45'},
    {'name': 'Maghrib', 'completed': false, 'time': '18:20'},
    {'name': 'Isha', 'completed': false, 'time': '19:45'},
  ];

  // Previous activities checklist
  final List<Map<String, dynamic>> _previousActivities = [
    {'title': 'Exercise', 'icon': LucideIcons.dumbbell, 'completed': true},
    {'title': 'Reading', 'icon': LucideIcons.bookOpen, 'completed': false},
    {'title': 'Meditation', 'icon': LucideIcons.brain, 'completed': true},
    {'title': 'Finances', 'icon': LucideIcons.dollarSign, 'completed': false},
    {'title': 'Learning', 'icon': LucideIcons.graduationCap, 'completed': true},
  ];

  // Activity metrics
  int _totalSteps = 0;
  double _waterLiters = 0.0;
  int _totalCalories = 0;
  int _workStudyMinutes = 0;
  int _screenTimeMinutes = 0;
  int _sleepMinutes = 0;
  int _prayersCompleted = 0;

  // Mood tracking
  String _selectedMood = '';
  final List<Map<String, dynamic>> _moods = [
    {'name': 'Excellent', 'emoji': '😄', 'color': SXEColors.kelp},
    {'name': 'Good', 'emoji': '😊', 'color': SXEColors.aubergine},
    {'name': 'Okay', 'emoji': '😐', 'color': SXEColors.midnight},
    {'name': 'Bad', 'emoji': '😔', 'color': SXEColors.coral},
    {'name': 'Terrible', 'emoji': '😢', 'color': Colors.red},
  ];

  // Journal
  final TextEditingController _journalController = TextEditingController();

  static int _getWeekOfYear(DateTime date) {
    int dayOfYear = int.parse(
            date.difference(DateTime(date.year, 1, 1)).inDays.toString()) +
        1;
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }

  @override
  Widget build(BuildContext context) {
    final completedPrayers =
        _prayers.where((p) => p['completed'] == true).length;
    final totalPrayers = _prayers.length;
    final sleepCompleted =
        _sleepActivities.where((s) => s['completed'] == true).length;

    return Scaffold(
      backgroundColor: SXEColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Year and Week Selector
            _buildYearWeekSelector(),

            const SizedBox(height: 16),

            // Date Selector (Tab-like design)
            _buildDateSelector(),

            const SizedBox(height: 24),

            // Progress Overview
            _buildProgressOverview(
                completedPrayers, totalPrayers, sleepCompleted),

            const SizedBox(height: 24),

            // Previous Activities Checklist
            _buildPreviousActivitiesSection(),

            const SizedBox(height: 24),

            // Sleep Section
            _buildSleepSection(),

            const SizedBox(height: 24),

            // Separator
            _buildSeparator(),

            const SizedBox(height: 24),

            // Prayers Section
            _buildPrayersSection(),

            const SizedBox(height: 24),

            // Activity Metrics Section
            _buildActivityMetricsSection(),

            const SizedBox(height: 24),

            // Separator
            _buildSeparator(),

            const SizedBox(height: 24),

            // Mood Section
            _buildMoodSection(),

            const SizedBox(height: 24),

            // Journal Section
            _buildJournalSection(),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  // Year and Week Selector
  Widget _buildYearWeekSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SXEColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: SXEColors.borderLight),
      ),
      child: Row(
        children: [
          // Year Selector
          Expanded(
            child: GestureDetector(
              onTap: () => _showYearPicker(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: SXEColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: SXEColors.primary.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.calendar,
                        size: 16, color: SXEColors.primary),
                    const SizedBox(width: 8),
                    Text(
                      'Year: $_selectedYear',
                      style: SXETypography.bodyMedium.copyWith(
                        color: SXEColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Week Selector
          Expanded(
            child: GestureDetector(
              onTap: () => _showWeekPicker(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: SXEColors.aubergine.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: SXEColors.aubergine.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.clock,
                        size: 16, color: SXEColors.aubergine),
                    const SizedBox(width: 8),
                    Text(
                      'Week: $_selectedWeek',
                      style: SXETypography.bodyMedium.copyWith(
                        color: SXEColors.aubergine,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Previous Activities Section
  Widget _buildPreviousActivitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Previous Activities',
          style: SXETypography.functionalHeadline,
        ),
        const SizedBox(height: 16),
        ..._previousActivities.map((activity) => _ActivityCard(
              title: activity['title'],
              icon: activity['icon'],
              completed: activity['completed'],
              onTap: () {
                setState(() {
                  activity['completed'] = !activity['completed'];
                });
              },
            )),
      ],
    );
  }

  // Date Selector with tab-like design
  Widget _buildDateSelector() {
    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          final date = DateTime.now().subtract(Duration(days: 3 - index));
          final isSelected = date.day == _selectedDate.day &&
              date.month == _selectedDate.month &&
              date.year == _selectedDate.year;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = date;
              });
            },
            child: Container(
              width: 80,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: isSelected ? SXEColors.primary : SXEColors.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? SXEColors.primary : SXEColors.borderLight,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getDayName(date.weekday),
                    style: SXETypography.bodySmall.copyWith(
                      color: isSelected
                          ? SXEColors.onPrimary
                          : SXEColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${date.day}',
                    style: SXETypography.bodyMedium.copyWith(
                      color: isSelected
                          ? SXEColors.onPrimary
                          : SXEColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  // Progress Overview
  Widget _buildProgressOverview(
      int completedPrayers, int totalPrayers, int sleepCompleted) {
    final totalCompleted = completedPrayers + sleepCompleted;
    final totalActivities = totalPrayers + 2; // prayers + sleep activities
    final progressPercentage = totalActivities > 0
        ? (totalCompleted / totalActivities * 100).round()
        : 0;

    return Container(
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
                'Today\'s Progress',
                style: SXETypography.functionalHeadline,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: SXEColors.kelp.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$progressPercentage%',
                  style: SXETypography.bodySmall.copyWith(
                    color: SXEColors.kelp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progressPercentage / 100,
            backgroundColor: SXEColors.borderLight,
            valueColor: AlwaysStoppedAnimation<Color>(SXEColors.kelp),
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 12),
          Text(
            '$totalCompleted of $totalActivities activities completed',
            style: SXETypography.bodySmall.copyWith(
              color: SXEColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // Sleep Section
  Widget _buildSleepSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sleep',
          style: SXETypography.functionalHeadline,
        ),
        const SizedBox(height: 16),
        ..._sleepActivities.map((activity) => _ActivityCard(
              title: activity['title'],
              icon: activity['icon'],
              completed: activity['completed'],
              onTap: () {
                setState(() {
                  activity['completed'] = !activity['completed'];
                });
              },
            )),
      ],
    );
  }

  // Separator
  Widget _buildSeparator() {
    return Container(
      height: 1,
      color: SXEColors.borderLight,
    );
  }

  // Prayers Section
  Widget _buildPrayersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Prayers',
          style: SXETypography.functionalHeadline,
        ),
        const SizedBox(height: 16),
        ..._prayers.map((prayer) => _PrayerCard(
              name: prayer['name'],
              time: prayer['time'],
              completed: prayer['completed'],
              onTap: () {
                setState(() {
                  prayer['completed'] = !prayer['completed'];
                });
              },
            )),
      ],
    );
  }

  // Activity Metrics Section
  Widget _buildActivityMetricsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Metrics',
          style: SXETypography.functionalHeadline,
        ),
        const SizedBox(height: 16),
        _MetricCard(
          title: 'Prayers',
          value: '$_prayersCompleted',
          unit: 'completed',
          icon: LucideIcons.moon,
          color: SXEColors.midnight,
          onTap: () => _showPrayersModal(),
        ),
        const SizedBox(height: 12),
        _MetricCard(
          title: 'Steps',
          value: '$_totalSteps',
          unit: 'steps',
          icon: LucideIcons.footprints,
          color: SXEColors.kelp,
          onTap: () => _showStepsDialog(),
        ),
        const SizedBox(height: 12),
        _MetricCard(
          title: 'Water',
          value: '${_waterLiters.toStringAsFixed(1)}',
          unit: 'liters',
          icon: LucideIcons.droplet,
          color: SXEColors.midnight,
          onTap: () => _showWaterDialog(),
        ),
        const SizedBox(height: 12),
        _MetricCard(
          title: 'Diet',
          value: '$_totalCalories',
          unit: 'calories',
          icon: LucideIcons.utensils,
          color: SXEColors.aubergine,
          onTap: () => _showCaloriesDialog(),
        ),
        const SizedBox(height: 12),
        _MetricCard(
          title: 'Work/Study',
          value: '${(_workStudyMinutes / 60).toStringAsFixed(1)}',
          unit: 'hours',
          icon: LucideIcons.laptop,
          color: SXEColors.coral,
          onTap: () => _showWorkStudyDialog(),
        ),
        const SizedBox(height: 12),
        _MetricCard(
          title: 'Screen Time',
          value: '${(_screenTimeMinutes / 60).toStringAsFixed(1)}',
          unit: 'hours',
          icon: LucideIcons.smartphone,
          color: Colors.orange,
          onTap: () => _showScreenTimeDialog(),
        ),
        const SizedBox(height: 12),
        _MetricCard(
          title: 'Sleep',
          value: '${(_sleepMinutes / 60).toStringAsFixed(1)}',
          unit: 'hours',
          icon: LucideIcons.moon,
          color: SXEColors.midnight,
          onTap: () => _showSleepDialog(),
        ),
      ],
    );
  }

  // Mood Section
  Widget _buildMoodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mood',
          style: SXETypography.functionalHeadline,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _moods.map((mood) {
            final isSelected = _selectedMood == mood['name'];
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedMood = isSelected ? '' : mood['name'];
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? mood['color'].withValues(alpha: 0.1)
                      : SXEColors.surface,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected ? mood['color'] : SXEColors.borderLight,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      mood['emoji'],
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      mood['name'],
                      style: SXETypography.bodyMedium.copyWith(
                        color:
                            isSelected ? mood['color'] : SXEColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Journal Section
  Widget _buildJournalSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Journal',
          style: SXETypography.functionalHeadline,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: SXEColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: SXEColors.borderLight),
          ),
          child: TextField(
            controller: _journalController,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'How was your day? Write your thoughts here...',
              hintStyle: SXETypography.bodyMedium.copyWith(
                color: SXEColors.textSecondary,
              ),
              border: InputBorder.none,
            ),
            style: SXETypography.bodyMedium,
          ),
        ),
      ],
    );
  }

  // Dialog methods for metrics
  void _showStepsDialog() {
    _showMetricDialog(
      title: 'Steps',
      currentValue: _totalSteps.toString(),
      unit: 'steps',
      onSave: (value) {
        setState(() {
          _totalSteps = int.tryParse(value) ?? 0;
        });
      },
    );
  }

  void _showWaterDialog() {
    _showMetricDialog(
      title: 'Water',
      currentValue: _waterLiters.toString(),
      unit: 'liters',
      onSave: (value) {
        setState(() {
          _waterLiters = double.tryParse(value) ?? 0.0;
        });
      },
    );
  }

  void _showCaloriesDialog() {
    _showMetricDialog(
      title: 'Calories',
      currentValue: _totalCalories.toString(),
      unit: 'calories',
      onSave: (value) {
        setState(() {
          _totalCalories = int.tryParse(value) ?? 0;
        });
      },
    );
  }

  void _showWorkStudyDialog() {
    _showMetricDialog(
      title: 'Work/Study Time',
      currentValue: _workStudyMinutes.toString(),
      unit: 'minutes',
      onSave: (value) {
        setState(() {
          _workStudyMinutes = int.tryParse(value) ?? 0;
        });
      },
    );
  }

  void _showScreenTimeDialog() {
    _showMetricDialog(
      title: 'Screen Time',
      currentValue: _screenTimeMinutes.toString(),
      unit: 'minutes',
      onSave: (value) {
        setState(() {
          _screenTimeMinutes = int.tryParse(value) ?? 0;
        });
      },
    );
  }

  void _showSleepDialog() {
    _showMetricDialog(
      title: 'Sleep Time',
      currentValue: _sleepMinutes.toString(),
      unit: 'minutes',
      onSave: (value) {
        setState(() {
          _sleepMinutes = int.tryParse(value) ?? 0;
        });
      },
    );
  }

  // Year Picker Dialog
  void _showYearPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: SXEColors.surface,
        title: Text(
          'Select Year',
          style: SXETypography.functionalHeadline,
        ),
        content: SizedBox(
          height: 200,
          width: 200,
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              final year = DateTime.now().year - 5 + index;
              final isSelected = year == _selectedYear;
              return ListTile(
                title: Text(
                  '$year',
                  style: SXETypography.bodyMedium.copyWith(
                    color:
                        isSelected ? SXEColors.primary : SXEColors.textPrimary,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                selected: isSelected,
                onTap: () {
                  setState(() {
                    _selectedYear = year;
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
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

  // Week Picker Dialog
  void _showWeekPicker() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: SXEColors.surface,
        title: Text(
          'Select Week',
          style: SXETypography.functionalHeadline,
        ),
        content: SizedBox(
          height: 300,
          width: 200,
          child: ListView.builder(
            itemCount: 52,
            itemBuilder: (context, index) {
              final week = index + 1;
              final isSelected = week == _selectedWeek;
              return ListTile(
                title: Text(
                  'Week $week',
                  style: SXETypography.bodyMedium.copyWith(
                    color: isSelected
                        ? SXEColors.aubergine
                        : SXEColors.textPrimary,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                selected: isSelected,
                onTap: () {
                  setState(() {
                    _selectedWeek = week;
                  });
                  Navigator.pop(context);
                },
              );
            },
          ),
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

  // Prayers Modal
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
                    trailing: prayer['completed']
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: SXEColors.kelp,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'DONE',
                              style: SXETypography.bodySmall.copyWith(
                                color: SXEColors.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        : null,
                    onTap: () {
                      setState(() {
                        prayer['completed'] = !prayer['completed'];
                        _prayersCompleted = _prayers
                            .where((p) => p['completed'] == true)
                            .length;
                      });
                    },
                  ),
                )),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showMetricDialog({
    required String title,
    required String currentValue,
    required String unit,
    required Function(String) onSave,
  }) {
    final controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: SXEColors.surface,
        title: Text(
          'Update $title',
          style: SXETypography.functionalHeadline,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '$title ($unit)',
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
              onSave(controller.text);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

// Activity Card Widget
class _ActivityCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool completed;
  final VoidCallback onTap;

  const _ActivityCard({
    required this.title,
    required this.icon,
    required this.completed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: completed
              ? SXEColors.kelp.withValues(alpha: 0.1)
              : SXEColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: completed ? SXEColors.kelp : SXEColors.borderLight,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: completed ? SXEColors.kelp : SXEColors.borderLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                completed ? LucideIcons.check : icon,
                color:
                    completed ? SXEColors.onPrimary : SXEColors.textSecondary,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: SXETypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: completed ? SXEColors.kelp : SXEColors.textPrimary,
                ),
              ),
            ),
            if (completed)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: SXEColors.kelp,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'DONE',
                  style: SXETypography.bodySmall.copyWith(
                    color: SXEColors.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Prayer Card Widget
class _PrayerCard extends StatelessWidget {
  final String name;
  final String time;
  final bool completed;
  final VoidCallback onTap;

  const _PrayerCard({
    required this.name,
    required this.time,
    required this.completed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: completed
              ? SXEColors.kelp.withValues(alpha: 0.1)
              : SXEColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: completed ? SXEColors.kelp : SXEColors.borderLight,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: completed ? SXEColors.kelp : SXEColors.borderLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                completed ? LucideIcons.check : LucideIcons.moon,
                color:
                    completed ? SXEColors.onPrimary : SXEColors.textSecondary,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: SXETypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: completed ? SXEColors.kelp : SXEColors.textPrimary,
                    ),
                  ),
                  Text(
                    time,
                    style: SXETypography.bodySmall.copyWith(
                      color: SXEColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (completed)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: SXEColors.kelp,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'DONE',
                  style: SXETypography.bodySmall.copyWith(
                    color: SXEColors.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Metric Card Widget
class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: SXEColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: SXEColors.borderLight),
        ),
        child: Row(
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
                    style: SXETypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '$value $unit',
                    style: SXETypography.bodySmall.copyWith(
                      color: SXEColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              LucideIcons.edit,
              color: SXEColors.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
