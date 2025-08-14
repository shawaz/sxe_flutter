import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sxe/ui/theme/sxe_colors.dart';
import 'package:sxe/ui/theme/sxe_typography.dart';

class DietDetailScreen extends StatefulWidget {
  const DietDetailScreen({super.key});

  @override
  State<DietDetailScreen> createState() => _DietDetailScreenState();
}

class _DietDetailScreenState extends State<DietDetailScreen> {
  final List<Map<String, dynamic>> _meals = [
    {
      'title': 'Healthy Breakfast',
      'time': '7:00 AM',
      'completed': true,
      'description': 'Oatmeal with fruits and nuts',
      'calories': '350 cal',
    },
    {
      'title': 'Mid-Morning Snack',
      'time': '10:00 AM',
      'completed': true,
      'description': 'Greek yogurt with berries',
      'calories': '150 cal',
    },
    {
      'title': 'Nutritious Lunch',
      'time': '1:00 PM',
      'completed': true,
      'description': 'Grilled chicken with vegetables',
      'calories': '450 cal',
    },
    {
      'title': 'Afternoon Snack',
      'time': '4:00 PM',
      'completed': false,
      'description': 'Mixed nuts and green tea',
      'calories': '200 cal',
    },
    {
      'title': 'Light Dinner',
      'time': '7:00 PM',
      'completed': false,
      'description': 'Fish with quinoa and salad',
      'calories': '400 cal',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SXEColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: SXEColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Diet',
          style: SXETypography.mainHeadline,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header card
              _buildHeaderCard(),
              
              const SizedBox(height: 24),
              
              // Meals list
              Text(
                'Today\'s Meal Plan',
                style: SXETypography.functionalHeadline,
              ),
              
              const SizedBox(height: 16),
              
              Expanded(
                child: ListView.builder(
                  itemCount: _meals.length,
                  itemBuilder: (context, index) {
                    final meal = _meals[index];
                    return _MealCard(
                      title: meal['title'],
                      time: meal['time'],
                      description: meal['description'],
                      calories: meal['calories'],
                      completed: meal['completed'],
                      onToggle: () {
                        setState(() {
                          _meals[index]['completed'] = !_meals[index]['completed'];
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    final completedCount = _meals.where((meal) => meal['completed']).length;
    final totalCount = _meals.length;
    final progress = completedCount / totalCount;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.orange.shade50,
            Colors.orange.shade100,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.orange.shade600,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  LucideIcons.utensils,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nutrition Plan',
                      style: SXETypography.functionalHeadline.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Fuel your body with healthy choices',
                      style: SXETypography.bodyMedium.copyWith(
                        color: SXEColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Progress section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$completedCount of $totalCount meals',
                style: SXETypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: SXETypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.orange.shade600,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withValues(alpha: 0.3),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange.shade600),
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}

class _MealCard extends StatelessWidget {
  final String title;
  final String time;
  final String description;
  final String calories;
  final bool completed;
  final VoidCallback onToggle;

  const _MealCard({
    required this.title,
    required this.time,
    required this.description,
    required this.calories,
    required this.completed,
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
        border: Border.all(
          color: SXEColors.borderLight,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: completed ? Colors.orange.shade600 : Colors.transparent,
                border: Border.all(
                  color: completed ? Colors.orange.shade600 : SXEColors.borderMedium,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
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
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: SXETypography.functionalHeadline.copyWith(
                        decoration: completed ? TextDecoration.lineThrough : null,
                        color: completed ? SXEColors.textSecondary : SXEColors.textPrimary,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          time,
                          style: SXETypography.bodyMedium.copyWith(
                            color: Colors.orange.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          calories,
                          style: SXETypography.bodySmall.copyWith(
                            color: SXEColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
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
