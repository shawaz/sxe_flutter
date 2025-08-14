import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sxe/ui/theme/sxe_colors.dart';
import 'package:sxe/ui/theme/sxe_typography.dart';

class ExerciseDetailScreen extends StatefulWidget {
  const ExerciseDetailScreen({super.key});

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Workouts data
  final List<Map<String, dynamic>> _todaysWorkouts = [
    {
      'name': 'Morning Cardio',
      'type': 'Cardio',
      'duration': 30,
      'calories': 250,
      'completed': true,
      'icon': LucideIcons.heart,
      'color': SXEColors.coral,
    },
    {
      'name': 'Strength Training',
      'type': 'Strength',
      'duration': 45,
      'calories': 350,
      'completed': true,
      'icon': LucideIcons.dumbbell,
      'color': SXEColors.kelp,
    },
    {
      'name': 'Yoga Session',
      'type': 'Flexibility',
      'duration': 20,
      'calories': 100,
      'completed': false,
      'icon': LucideIcons.flower,
      'color': SXEColors.aubergine,
    },
    {
      'name': 'Evening Walk',
      'type': 'Cardio',
      'duration': 25,
      'calories': 150,
      'completed': false,
      'icon': LucideIcons.footprints,
      'color': SXEColors.midnight,
    },
  ];

  // Progress data
  final Map<String, dynamic> _weeklyProgress = {
    'totalWorkouts': 12,
    'totalMinutes': 420,
    'totalCalories': 2100,
    'streak': 5,
    'weeklyGoal': 15,
  };

  final List<Map<String, dynamic>> _weeklyStats = [
    {'day': 'Mon', 'workouts': 2, 'minutes': 60},
    {'day': 'Tue', 'workouts': 1, 'minutes': 30},
    {'day': 'Wed', 'workouts': 3, 'minutes': 90},
    {'day': 'Thu', 'workouts': 2, 'minutes': 75},
    {'day': 'Fri', 'workouts': 1, 'minutes': 45},
    {'day': 'Sat', 'workouts': 2, 'minutes': 80},
    {'day': 'Sun', 'workouts': 1, 'minutes': 40},
  ];

  // Goals data
  final List<Map<String, dynamic>> _fitnessGoals = [
    {
      'title': 'Lose 10 lbs',
      'current': 7,
      'target': 10,
      'unit': 'lbs',
      'category': 'Weight Loss',
      'deadline': '2024-03-01',
      'icon': LucideIcons.target,
      'color': SXEColors.coral,
    },
    {
      'title': 'Run 5K',
      'current': 3.2,
      'target': 5.0,
      'unit': 'km',
      'category': 'Endurance',
      'deadline': '2024-02-15',
      'icon': LucideIcons.zap,
      'color': SXEColors.kelp,
    },
    {
      'title': 'Workout Streak',
      'current': 5,
      'target': 30,
      'unit': 'days',
      'category': 'Consistency',
      'deadline': '2024-02-28',
      'icon': LucideIcons.flame,
      'color': SXEColors.aubergine,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SXEColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Exercise Tracker',
          style: SXETypography.functionalHeadline,
        ),
        backgroundColor: SXEColors.background,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: SXEColors.primary,
          unselectedLabelColor: SXEColors.textSecondary,
          labelStyle: SXETypography.bodySmall.copyWith(
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: SXETypography.bodySmall.copyWith(
            fontWeight: FontWeight.w700,
          ),
          indicatorColor: SXEColors.primary,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'Workouts'),
            Tab(text: 'Progress'),
            Tab(text: 'Goals'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildWorkoutsTab(),
          _buildProgressTab(),
          _buildGoalsTab(),
        ],
      ),
    );
  }

  // Workouts Tab
  Widget _buildWorkoutsTab() {
    final completedWorkouts =
        _todaysWorkouts.where((w) => w['completed'] == true).length;
    final totalCalories = _todaysWorkouts
        .where((w) => w['completed'] == true)
        .fold(0, (sum, w) => sum + (w['calories'] as int));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Today's Summary
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
                  'Today\'s Summary',
                  style: SXETypography.functionalHeadline,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        title: 'Workouts',
                        value: '$completedWorkouts/${_todaysWorkouts.length}',
                        icon: LucideIcons.dumbbell,
                        color: SXEColors.kelp,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _StatCard(
                        title: 'Calories',
                        value: '$totalCalories',
                        icon: LucideIcons.flame,
                        color: SXEColors.coral,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Today's Workouts
          Text(
            'Today\'s Workouts',
            style: SXETypography.functionalHeadline,
          ),
          const SizedBox(height: 16),
          ..._todaysWorkouts.map((workout) => _WorkoutCard(
                name: workout['name'],
                type: workout['type'],
                duration: workout['duration'],
                calories: workout['calories'],
                completed: workout['completed'],
                icon: workout['icon'],
                color: workout['color'],
                onToggle: () => _toggleWorkout(workout),
              )),
        ],
      ),
    );
  }

  // Progress Tab
  Widget _buildProgressTab() {
    final progress =
        _weeklyProgress['totalWorkouts'] / _weeklyProgress['weeklyGoal'];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Weekly Overview
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
                      'This Week',
                      style: SXETypography.functionalHeadline,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: SXEColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${(_weeklyProgress['streak'])} day streak',
                        style: SXETypography.bodySmall.copyWith(
                          color: SXEColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: SXEColors.borderLight,
                  valueColor: AlwaysStoppedAnimation<Color>(SXEColors.primary),
                ),
                const SizedBox(height: 12),
                Text(
                  '${_weeklyProgress['totalWorkouts']} of ${_weeklyProgress['weeklyGoal']} workouts completed',
                  style: SXETypography.bodyMedium.copyWith(
                    color: SXEColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Stats Grid
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  title: 'Total Minutes',
                  value: '${_weeklyProgress['totalMinutes']}',
                  icon: LucideIcons.clock,
                  color: SXEColors.kelp,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _StatCard(
                  title: 'Calories Burned',
                  value: '${_weeklyProgress['totalCalories']}',
                  icon: LucideIcons.flame,
                  color: SXEColors.coral,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Weekly Chart
          Text(
            'Weekly Activity',
            style: SXETypography.functionalHeadline,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: SXEColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: SXEColors.borderLight),
            ),
            child: Column(
              children: _weeklyStats
                  .map((stat) => _WeeklyStatItem(
                        day: stat['day'],
                        workouts: stat['workouts'],
                        minutes: stat['minutes'],
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Goals Tab
  Widget _buildGoalsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fitness Goals',
            style: SXETypography.functionalHeadline,
          ),
          const SizedBox(height: 16),
          ..._fitnessGoals.map((goal) => _GoalCard(
                title: goal['title'],
                current: goal['current'],
                target: goal['target'],
                unit: goal['unit'],
                category: goal['category'],
                deadline: goal['deadline'],
                icon: goal['icon'],
                color: goal['color'],
                onUpdate: () => _updateGoal(goal),
              )),

          const SizedBox(height: 24),

          // Add New Goal Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _showAddGoalDialog(),
              icon: const Icon(LucideIcons.plus),
              label: const Text('Add New Goal'),
              style: ElevatedButton.styleFrom(
                backgroundColor: SXEColors.primary,
                foregroundColor: SXEColors.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleWorkout(Map<String, dynamic> workout) {
    setState(() {
      workout['completed'] = !workout['completed'];
    });
  }

  void _updateGoal(Map<String, dynamic> goal) {
    setState(() {
      if (goal['current'] < goal['target']) {
        goal['current'] += 0.1; // Small increment for demo
      }
    });
  }

  void _showAddGoalDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Goal'),
        content: const Text('Goal creation feature coming soon!'),
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

// Workout Card Widget
class _WorkoutCard extends StatelessWidget {
  final String name;
  final String type;
  final int duration;
  final int calories;
  final bool completed;
  final IconData icon;
  final Color color;
  final VoidCallback onToggle;

  const _WorkoutCard({
    required this.name,
    required this.type,
    required this.duration,
    required this.calories,
    required this.completed,
    required this.icon,
    required this.color,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SXEColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: SXEColors.borderLight),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: completed ? color : Colors.transparent,
                border: Border.all(
                  color: completed ? color : SXEColors.borderLight,
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
          const SizedBox(width: 16),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
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
                  '$type • ${duration}min • ${calories}cal',
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

// Weekly Stat Item Widget
class _WeeklyStatItem extends StatelessWidget {
  final String day;
  final int workouts;
  final int minutes;

  const _WeeklyStatItem({
    required this.day,
    required this.workouts,
    required this.minutes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: SXETypography.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            children: [
              Text(
                '$workouts workouts',
                style: SXETypography.bodySmall.copyWith(
                  color: SXEColors.textSecondary,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '${minutes}min',
                style: SXETypography.bodySmall.copyWith(
                  color: SXEColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Goal Card Widget
class _GoalCard extends StatelessWidget {
  final String title;
  final double current;
  final double target;
  final String unit;
  final String category;
  final String deadline;
  final IconData icon;
  final Color color;
  final VoidCallback onUpdate;

  const _GoalCard({
    required this.title,
    required this.current,
    required this.target,
    required this.unit,
    required this.category,
    required this.deadline,
    required this.icon,
    required this.color,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final progress = current / target;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
                child: Icon(icon, color: color, size: 24),
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
                      ),
                    ),
                    Text(
                      category,
                      style: SXETypography.bodySmall.copyWith(
                        color: SXEColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onUpdate,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Update',
                    style: SXETypography.bodySmall.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
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
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${current.toStringAsFixed(1)} / ${target.toStringAsFixed(0)} $unit',
                style: SXETypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Due: $deadline',
                style: SXETypography.bodySmall.copyWith(
                  color: SXEColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
