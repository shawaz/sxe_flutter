import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:sxe/providers/auth_provider.dart';
import 'package:sxe/providers/theme_provider.dart';
import 'package:sxe/ui/theme/sxe_colors.dart';
import 'package:sxe/ui/theme/sxe_typography.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile header
            Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                final user = authProvider.user;
                return Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: SXEColors.primary.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: SXEColors.primary,
                                width: 3,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                user?.name
                                        .split(' ')
                                        .map((n) => n[0])
                                        .take(2)
                                        .join() ??
                                    'U',
                                style: SXETypography.mainHeadline.copyWith(
                                  color: SXEColors.primary,
                                  fontSize: 36,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                color: SXEColors.primary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: SXEColors.background,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: SXEColors.onPrimary,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user?.name ?? 'User',
                        style: SXETypography.largeHeadline,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user?.email ?? '',
                        style: SXETypography.bodyMedium.copyWith(
                          color: SXEColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 32),

            // Personal Development Stats
            Container(
              padding: const EdgeInsets.all(16),
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
                        'Development Progress',
                        style: SXETypography.functionalHeadline,
                      ),
                      Text(
                        '78%',
                        style: SXETypography.functionalHeadline.copyWith(
                          color: SXEColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: 0.78,
                    backgroundColor: SXEColors.borderLight,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      SXEColors.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Keep up the great work on your personal development journey!',
                    style: SXETypography.bodySmall.copyWith(
                      color: SXEColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Stats Overview
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Goals Achieved',
                    value: '12',
                    icon: LucideIcons.target,
                    color: SXEColors.kelp,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    title: 'Days Streak',
                    value: '28',
                    icon: LucideIcons.flame,
                    color: SXEColors.coral,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Budget Saved',
                    value: '\$450',
                    icon: LucideIcons.piggyBank,
                    color: SXEColors.midnight,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    title: 'Skills Learned',
                    value: '5',
                    icon: LucideIcons.brain,
                    color: SXEColors.aubergine,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Development sections
            _ProfileSection(
              title: 'Goals & Vision',
              subtitle: 'Manage your life goals',
              icon: LucideIcons.target,
              onTap: () {},
            ),

            _ProfileSection(
              title: 'Activity Tracking',
              subtitle: 'View your daily activities',
              icon: LucideIcons.activity,
              onTap: () {},
            ),

            _ProfileSection(
              title: 'Budget Management',
              subtitle: 'Track your expenses',
              icon: LucideIcons.dollarSign,
              onTap: () {},
            ),

            _ProfileSection(
              title: 'Learning Progress',
              subtitle: 'Educational achievements',
              icon: LucideIcons.graduationCap,
              onTap: () {},
            ),

            const SizedBox(height: 24),

            // Account section
            Text(
              'Account',
              style: SXETypography.functionalHeadline,
            ),
            const SizedBox(height: 16),

            _ProfileSection(
              title: 'Privacy Settings',
              subtitle: 'Control your data privacy',
              icon: LucideIcons.shield,
              onTap: () {},
            ),

            _ProfileSection(
              title: 'Notifications',
              subtitle: 'Manage notifications',
              icon: LucideIcons.bell,
              onTap: () {},
            ),

            _ProfileSection(
              title: 'Help & Support',
              subtitle: 'Get help',
              icon: LucideIcons.helpCircle,
              onTap: () {},
            ),

            const SizedBox(height: 24),

            // Logout button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _showLogoutDialog(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: SXEColors.coral),
                  foregroundColor: SXEColors.coral,
                ),
                child: const Text('Sign Out'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSettingsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: SXEColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: SXETypography.functionalHeadline,
              ),
              const SizedBox(height: 24),
              Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return ListTile(
                    leading: Icon(themeProvider.currentThemeIcon),
                    title: const Text('Theme'),
                    subtitle:
                        Text('Current: ${themeProvider.currentThemeName}'),
                    trailing: Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        if (value) {
                          themeProvider.setThemeMode(ThemeMode.dark);
                        } else {
                          themeProvider.setThemeMode(ThemeMode.light);
                        }
                      },
                    ),
                    onTap: () => _showThemeDialog(context),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: const Text('Account Settings'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.security),
                title: const Text('Privacy & Security'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('About'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: SXEColors.surface,
          title: Text(
            'Sign Out',
            style: SXETypography.functionalHeadline,
          ),
          content: Text(
            'Are you sure you want to sign out?',
            style: SXETypography.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Provider.of<AuthProvider>(context, listen: false).logout();
              },
              style: TextButton.styleFrom(
                foregroundColor: SXEColors.coral,
              ),
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return AlertDialog(
              backgroundColor: SXEColors.surface,
              title: Text(
                'Choose Theme',
                style: SXETypography.functionalHeadline,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile<ThemeMode>(
                    title: const Text('Light'),
                    subtitle: const Text('Always use light theme'),
                    value: ThemeMode.light,
                    groupValue: themeProvider.themeMode,
                    onChanged: (value) {
                      if (value != null) {
                        themeProvider.setThemeMode(value);
                        Navigator.pop(context);
                      }
                    },
                  ),
                  RadioListTile<ThemeMode>(
                    title: const Text('Dark'),
                    subtitle: const Text('Always use dark theme'),
                    value: ThemeMode.dark,
                    groupValue: themeProvider.themeMode,
                    onChanged: (value) {
                      if (value != null) {
                        themeProvider.setThemeMode(value);
                        Navigator.pop(context);
                      }
                    },
                  ),
                  RadioListTile<ThemeMode>(
                    title: const Text('System'),
                    subtitle: const Text('Follow system setting'),
                    value: ThemeMode.system,
                    groupValue: themeProvider.themeMode,
                    onChanged: (value) {
                      if (value != null) {
                        themeProvider.setThemeMode(value);
                        Navigator.pop(context);
                      }
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
            );
          },
        );
      },
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const _ProfileSection({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: SXEColors.surface,
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: SXEColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: SXEColors.primary,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: SXETypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: SXETypography.bodySmall.copyWith(
            color: SXEColors.textSecondary,
          ),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: SXEColors.textTertiary,
        ),
      ),
    );
  }
}

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
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: color,
                size: 24,
              ),
              Text(
                value,
                style: SXETypography.functionalHeadline.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: SXETypography.bodySmall.copyWith(
              color: SXEColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
