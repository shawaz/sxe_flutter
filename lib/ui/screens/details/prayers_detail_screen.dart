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
  final List<Map<String, dynamic>> _prayers = [
    {
      'title': 'Fajr Prayer',
      'time': '5:30 AM',
      'completed': true,
      'description': 'Dawn prayer - the first prayer of the day',
    },
    {
      'title': 'Dhuhr Prayer',
      'time': '12:30 PM',
      'completed': false,
      'description': 'Midday prayer when the sun is at its zenith',
    },
    {
      'title': 'Asr Prayer',
      'time': '4:00 PM',
      'completed': false,
      'description': 'Afternoon prayer in the later part of the afternoon',
    },
    {
      'title': 'Maghrib Prayer',
      'time': '6:45 PM',
      'completed': false,
      'description': 'Evening prayer just after sunset',
    },
    {
      'title': 'Isha Prayer',
      'time': '8:30 PM',
      'completed': false,
      'description': 'Night prayer after twilight has disappeared',
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
          'Prayers',
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
              
              // Prayer list
              Text(
                'Today\'s Prayers',
                style: SXETypography.functionalHeadline,
              ),
              
              const SizedBox(height: 16),
              
              Expanded(
                child: ListView.builder(
                  itemCount: _prayers.length,
                  itemBuilder: (context, index) {
                    final prayer = _prayers[index];
                    return _PrayerCard(
                      title: prayer['title'],
                      time: prayer['time'],
                      description: prayer['description'],
                      completed: prayer['completed'],
                      onToggle: () {
                        setState(() {
                          _prayers[index]['completed'] = !_prayers[index]['completed'];
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
    final completedCount = _prayers.where((prayer) => prayer['completed']).length;
    final totalCount = _prayers.length;
    final progress = completedCount / totalCount;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade50,
            Colors.blue.shade100,
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
                  color: SXEColors.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(
                  LucideIcons.sun,
                  color: SXEColors.onPrimary,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Prayers',
                      style: SXETypography.functionalHeadline.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Stay connected with your spiritual practice',
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
                '$completedCount of $totalCount completed',
                style: SXETypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: SXETypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: SXEColors.primary,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withValues(alpha: 0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(SXEColors.primary),
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
}

class _PrayerCard extends StatelessWidget {
  final String title;
  final String time;
  final String description;
  final bool completed;
  final VoidCallback onToggle;

  const _PrayerCard({
    required this.title,
    required this.time,
    required this.description,
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
                color: completed ? SXEColors.primary : Colors.transparent,
                border: Border.all(
                  color: completed ? SXEColors.primary : SXEColors.borderMedium,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: completed
                  ? const Icon(
                      LucideIcons.check,
                      color: SXEColors.onPrimary,
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
                        color: SXEColors.primary,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
