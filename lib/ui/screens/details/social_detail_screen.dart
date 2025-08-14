import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sxe/ui/theme/sxe_colors.dart';
import 'package:sxe/ui/theme/sxe_typography.dart';

class SocialDetailScreen extends StatefulWidget {
  const SocialDetailScreen({super.key});

  @override
  State<SocialDetailScreen> createState() => _SocialDetailScreenState();
}

class _SocialDetailScreenState extends State<SocialDetailScreen> {
  final List<Map<String, dynamic>> _socialActivities = [
    {
      'title': 'Coffee with Friends',
      'time': '10:00 AM',
      'completed': true,
      'description': 'Catch up with college friends at the local café',
      'type': 'Friends',
    },
    {
      'title': 'Team Lunch',
      'time': '12:30 PM',
      'completed': true,
      'description': 'Lunch meeting with work colleagues',
      'type': 'Colleagues',
    },
    {
      'title': 'Community Volunteer',
      'time': '3:00 PM',
      'completed': true,
      'description': 'Help at the local community center',
      'type': 'Community',
    },
    {
      'title': 'Networking Event',
      'time': '6:00 PM',
      'completed': false,
      'description': 'Professional networking meetup',
      'type': 'Professional',
    },
    {
      'title': 'Social Media Check',
      'time': '8:00 PM',
      'completed': false,
      'description': 'Connect with friends online',
      'type': 'Digital',
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
          'Social',
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
              
              // Social activities list
              Text(
                'Social Connections Today',
                style: SXETypography.functionalHeadline,
              ),
              
              const SizedBox(height: 16),
              
              Expanded(
                child: ListView.builder(
                  itemCount: _socialActivities.length,
                  itemBuilder: (context, index) {
                    final activity = _socialActivities[index];
                    return _SocialActivityCard(
                      title: activity['title'],
                      time: activity['time'],
                      description: activity['description'],
                      type: activity['type'],
                      completed: activity['completed'],
                      onToggle: () {
                        setState(() {
                          _socialActivities[index]['completed'] = !_socialActivities[index]['completed'];
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
    final completedCount = _socialActivities.where((activity) => activity['completed']).length;
    final totalCount = _socialActivities.length;
    final progress = completedCount / totalCount;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.shade50,
            Colors.purple.shade100,
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
                  color: Colors.purple.shade600,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  LucideIcons.messageCircle,
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
                      'Social Connections',
                      style: SXETypography.functionalHeadline.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Build and maintain meaningful relationships',
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
                '$completedCount of $totalCount connections',
                style: SXETypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: SXETypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.purple.shade600,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withValues(alpha: 0.3),
            valueColor: AlwaysStoppedAnimation<Color>(Colors.purple.shade600),
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}

class _SocialActivityCard extends StatelessWidget {
  final String title;
  final String time;
  final String description;
  final String type;
  final bool completed;
  final VoidCallback onToggle;

  const _SocialActivityCard({
    required this.title,
    required this.time,
    required this.description,
    required this.type,
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
                color: completed ? Colors.purple.shade600 : Colors.transparent,
                border: Border.all(
                  color: completed ? Colors.purple.shade600 : SXEColors.borderMedium,
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
                    Text(
                      time,
                      style: SXETypography.bodyMedium.copyWith(
                        color: Colors.purple.shade600,
                        fontWeight: FontWeight.w600,
                      ),
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
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    type,
                    style: SXETypography.bodySmall.copyWith(
                      color: Colors.purple.shade700,
                      fontWeight: FontWeight.w500,
                    ),
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
