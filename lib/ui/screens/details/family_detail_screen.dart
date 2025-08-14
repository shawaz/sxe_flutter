import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sxe/ui/theme/sxe_colors.dart';
import 'package:sxe/ui/theme/sxe_typography.dart';

class FamilyDetailScreen extends StatefulWidget {
  const FamilyDetailScreen({super.key});

  @override
  State<FamilyDetailScreen> createState() => _FamilyDetailScreenState();
}

class _FamilyDetailScreenState extends State<FamilyDetailScreen> {
  final List<Map<String, dynamic>> _familyMembers = [
    {
      'name': 'Sarah',
      'role': 'Spouse',
      'age': 32,
      'avatar': '👩‍💼',
      'allowance': 0.0, // Adults don't get allowance
      'weeklyAllowance': 0.0,
      'plans': [
        'Date night Friday',
        'Yoga class Tuesday',
        'Book club Thursday'
      ],
      'notes': [
        'Loves Italian food',
        'Prefers morning workouts',
        'Birthday: March 15'
      ],
      'color': SXEColors.coral,
      'relationship': 'spouse',
    },
    {
      'name': 'Emma',
      'role': 'Daughter',
      'age': 12,
      'avatar': '👧',
      'allowance': 45.0,
      'weeklyAllowance': 15.0,
      'plans': [
        'Soccer practice Wed',
        'Piano lesson Sat',
        'Sleepover next weekend'
      ],
      'notes': [
        'Loves art and drawing',
        'Allergic to peanuts',
        'Favorite color: purple'
      ],
      'color': SXEColors.aubergine,
      'relationship': 'child',
    },
    {
      'name': 'Jake',
      'role': 'Son',
      'age': 9,
      'avatar': '👦',
      'allowance': 20.0,
      'weeklyAllowance': 10.0,
      'plans': ['Basketball Mon', 'Math tutor Thu', 'Friend\'s birthday party'],
      'notes': ['Loves video games', 'Good at math', 'Wants a pet hamster'],
      'color': SXEColors.kelp,
      'relationship': 'child',
    },
    {
      'name': 'Mom',
      'role': 'Mother',
      'age': 68,
      'avatar': '👵',
      'allowance': 0.0,
      'weeklyAllowance': 0.0,
      'plans': [
        'Doctor appointment Tue',
        'Garden club Wed',
        'Visit friends Fri'
      ],
      'notes': [
        'Loves gardening',
        'Takes medication at 8am',
        'Enjoys crossword puzzles'
      ],
      'color': SXEColors.midnight,
      'relationship': 'parent',
    },
  ];

  final List<String> _aiRecommendations = [
    'Plan a family game night this weekend to strengthen bonds',
    'Consider increasing Emma\'s allowance as she\'s taking on more responsibilities',
    'Schedule regular one-on-one time with each child',
    'Create a family calendar to track everyone\'s activities',
    'Set up a reward system for completed chores and good behavior',
    'Plan a monthly family outing or adventure',
  ];

  @override
  Widget build(BuildContext context) {
    final totalAllowance = _familyMembers
        .where((member) => member['relationship'] == 'child')
        .fold(0.0, (sum, member) => sum + member['allowance']);

    return Scaffold(
      backgroundColor: SXEColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Family Hub',
          style: SXETypography.functionalHeadline,
        ),
        backgroundColor: SXEColors.background,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showAIRecommendations(),
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
            // Family Overview
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
                        'Family Overview',
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
                          '${_familyMembers.length} members',
                          style: SXETypography.bodySmall.copyWith(
                            color: SXEColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          title: 'Total Allowance',
                          value: '\$${totalAllowance.toStringAsFixed(0)}',
                          icon: LucideIcons.dollarSign,
                          color: SXEColors.kelp,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _StatCard(
                          title: 'Active Plans',
                          value:
                              '${_familyMembers.fold(0, (sum, member) => sum + (member['plans'] as List).length)}',
                          icon: LucideIcons.calendar,
                          color: SXEColors.coral,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Family Members
            Text(
              'Family Members',
              style: SXETypography.functionalHeadline,
            ),
            const SizedBox(height: 16),
            ..._familyMembers.map((member) => _FamilyMemberCard(
                  name: member['name'],
                  role: member['role'],
                  age: member['age'],
                  avatar: member['avatar'],
                  allowance: member['allowance'],
                  weeklyAllowance: member['weeklyAllowance'],
                  plans: List<String>.from(member['plans']),
                  notes: List<String>.from(member['notes']),
                  color: member['color'],
                  relationship: member['relationship'],
                  onAllowanceUpdate: () => _updateAllowance(member),
                  onAddPlan: () => _addPlan(member),
                  onAddNote: () => _addNote(member),
                )),

            const SizedBox(height: 24),

            // Add New Member Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showAddMemberDialog(),
                icon: const Icon(LucideIcons.userPlus),
                label: const Text('Add Family Member'),
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
      ),
    );
  }

  void _updateAllowance(Map<String, dynamic> member) {
    if (member['relationship'] == 'child') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Update ${member['name']}\'s Allowance'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Weekly Allowance (\$)',
                  prefixIcon: Icon(LucideIcons.dollarSign),
                ),
                keyboardType: TextInputType.number,
                onSubmitted: (value) {
                  final amount = double.tryParse(value) ?? 0;
                  setState(() {
                    member['weeklyAllowance'] = amount;
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
  }

  void _addPlan(Map<String, dynamic> member) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Plan for ${member['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Plan Description',
                prefixIcon: Icon(LucideIcons.calendar),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    (member['plans'] as List<String>).add(value);
                  });
                }
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

  void _addNote(Map<String, dynamic> member) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Note for ${member['name']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Note',
                prefixIcon: Icon(LucideIcons.stickyNote),
              ),
              maxLines: 3,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    (member['notes'] as List<String>).add(value);
                  });
                }
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

  void _showAddMemberDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Family Member'),
        content: const Text('Add family member feature coming soon!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showAIRecommendations() {
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
                  'AI Recommendations',
                  style: SXETypography.functionalHeadline,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(LucideIcons.x),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ..._aiRecommendations.map((recommendation) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: SXEColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: SXEColors.primary.withValues(alpha: 0.2)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.lightbulb,
                        color: SXEColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          recommendation,
                          style: SXETypography.bodyMedium,
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

// Family Member Card Widget
class _FamilyMemberCard extends StatelessWidget {
  final String name;
  final String role;
  final int age;
  final String avatar;
  final double allowance;
  final double weeklyAllowance;
  final List<String> plans;
  final List<String> notes;
  final Color color;
  final String relationship;
  final VoidCallback onAllowanceUpdate;
  final VoidCallback onAddPlan;
  final VoidCallback onAddNote;

  const _FamilyMemberCard({
    required this.name,
    required this.role,
    required this.age,
    required this.avatar,
    required this.allowance,
    required this.weeklyAllowance,
    required this.plans,
    required this.notes,
    required this.color,
    required this.relationship,
    required this.onAllowanceUpdate,
    required this.onAddPlan,
    required this.onAddNote,
  });

  @override
  Widget build(BuildContext context) {
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
          // Header
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    avatar,
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: SXETypography.functionalHeadline.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$role • $age years old',
                      style: SXETypography.bodyMedium.copyWith(
                        color: SXEColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (relationship == 'child')
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '\$${allowance.toStringAsFixed(0)}',
                    style: SXETypography.bodySmall.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          // Allowance Section (for children)
          if (relationship == 'child') ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Weekly Allowance',
                  style: SXETypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: onAllowanceUpdate,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '\$${weeklyAllowance.toStringAsFixed(0)}/week',
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
          ],

          // Plans Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Plans (${plans.length})',
                style: SXETypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: onAddPlan,
                child: Icon(
                  LucideIcons.plus,
                  color: color,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (plans.isNotEmpty)
            ...plans.take(2).map((plan) => Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.calendar,
                        color: SXEColors.textSecondary,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          plan,
                          style: SXETypography.bodySmall.copyWith(
                            color: SXEColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          else
            Text(
              'No plans yet',
              style: SXETypography.bodySmall.copyWith(
                color: SXEColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),

          const SizedBox(height: 16),

          // Notes Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notes (${notes.length})',
                style: SXETypography.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: onAddNote,
                child: Icon(
                  LucideIcons.plus,
                  color: color,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (notes.isNotEmpty)
            ...notes.take(2).map((note) => Container(
                  margin: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.stickyNote,
                        color: SXEColors.textSecondary,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          note,
                          style: SXETypography.bodySmall.copyWith(
                            color: SXEColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ))
          else
            Text(
              'No notes yet',
              style: SXETypography.bodySmall.copyWith(
                color: SXEColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
        ],
      ),
    );
  }
}
