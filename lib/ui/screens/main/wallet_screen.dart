import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sxe/ui/theme/sxe_colors.dart';
import 'package:sxe/ui/theme/sxe_typography.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Balance Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    SXEColors.primary,
                    SXEColors.secondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Balance',
                    style: SXETypography.bodyMedium.copyWith(
                      color: SXEColors.onPrimary.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$30,000',
                    style: SXETypography.mainHeadline.copyWith(
                      color: SXEColors.onPrimary,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _FinancialColumn(
                        title: 'INCOME',
                        amount: '\$75,000',
                        color: SXEColors.onPrimary,
                        isLight: true,
                      ),
                      _FinancialColumn(
                        title: 'EXPENSES',
                        amount: '\$45,000',
                        color: SXEColors.onPrimary,
                        isLight: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Stats Overview
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Savings',
                    value: '\$12,500',
                    icon: LucideIcons.piggyBank,
                    color: SXEColors.kelp,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    title: 'Investments',
                    value: '\$8,750',
                    icon: LucideIcons.trendingUp,
                    color: SXEColors.aubergine,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: 'Monthly Goal',
                    value: '85%',
                    icon: LucideIcons.target,
                    color: SXEColors.midnight,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    title: 'Transactions',
                    value: '24',
                    icon: LucideIcons.receipt,
                    color: SXEColors.lilac,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // 2025 Section
            // Container(
            //   width: double.infinity,
            //   padding: const EdgeInsets.all(20),
            //   decoration: BoxDecoration(
            //     color: SXEColors.surface,
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         '2025',
            //         style: SXETypography.functionalHeadline.copyWith(
            //           fontSize: 18,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       const SizedBox(height: 16),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           _FinancialColumn(
            //             title: 'INCOME',
            //             amount: '\$5,000',
            //             color: Colors.green,
            //           ),
            //           _FinancialColumn(
            //             title: 'EXPENSES',
            //             amount: '\$4,000',
            //             color: Colors.red,
            //           ),
            //           _FinancialColumn(
            //             title: 'SAVINGS',
            //             amount: '\$1,000',
            //             color: Colors.purple,
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),

            // const SizedBox(height: 24),

            // Financial Management Cards
            // Text(
            //   'Financial Management',
            //   style: SXETypography.functionalHeadline,
            // ),
            // const SizedBox(height: 16),

            // Wallets Section
            _FinancialManagementCard(
              title: 'Wallets',
              subtitle: 'Manage your digital wallets',
              icon: LucideIcons.wallet,
              color: SXEColors.kelp,
              value: '8 Active',
              items: [
                {
                  'name': 'BullX W7',
                  'amount': '\$8,000',
                  'icon': Icons.currency_bitcoin
                },
                {
                  'name': 'Phantom',
                  'amount': '\$8,000',
                  'icon': LucideIcons.ghost
                },
                {'name': 'Binance', 'amount': '\$5,000', 'icon': Icons.diamond},
                {
                  'name': 'Juspay',
                  'amount': '\$2,500',
                  'icon': LucideIcons.circle
                },
                {
                  'name': 'Jupiter Savings',
                  'amount': '\$10,000',
                  'icon': Icons.savings
                },
                {
                  'name': 'Jupiter Credit',
                  'amount': '\$5,000',
                  'icon': Icons.credit_card
                },
                {
                  'name': 'ENBD Savings',
                  'amount': '\$20,000',
                  'icon': Icons.account_balance
                },
                {
                  'name': 'ENBD Credit',
                  'amount': '\$12,000',
                  'icon': Icons.credit_card
                },
              ],
              onTap: () => _showWalletsDetail(),
            ),

            const SizedBox(height: 24),

            // Budget Section
            _FinancialManagementCard(
              title: 'Budget',
              subtitle: 'Track your spending limits',
              icon: LucideIcons.pieChart,
              color: SXEColors.midnight,
              value: '85% Used',
              items: [
                {
                  'name': 'Food & Dining',
                  'amount': '\$450/\$500',
                  'progress': 0.9
                },
                {
                  'name': 'Transportation',
                  'amount': '\$180/\$300',
                  'progress': 0.6
                },
                {
                  'name': 'Entertainment',
                  'amount': '\$120/\$200',
                  'progress': 0.6
                },
                {'name': 'Shopping', 'amount': '\$80/\$150', 'progress': 0.53},
              ],
              onTap: () => _showBudgetDetail(),
            ),

            const SizedBox(height: 16),

            // Subscriptions Section
            _FinancialManagementCard(
              title: 'Subscriptions',
              subtitle: 'Monthly recurring payments',
              icon: LucideIcons.repeat,
              color: SXEColors.coral,
              value: '\$89/month',
              items: [
                {
                  'name': 'Netflix',
                  'amount': '\$15.99',
                  'icon': LucideIcons.play
                },
                {
                  'name': 'Spotify',
                  'amount': '\$9.99',
                  'icon': LucideIcons.music
                },
                {
                  'name': 'Adobe CC',
                  'amount': '\$52.99',
                  'icon': LucideIcons.image
                },
                {
                  'name': 'iCloud',
                  'amount': '\$2.99',
                  'icon': LucideIcons.cloud
                },
              ],
              onTap: () => _showSubscriptionsDetail(),
            ),

            const SizedBox(height: 16),

            // Transactions Section
            _FinancialManagementCard(
              title: 'Recent Transactions',
              subtitle: 'Latest financial activity',
              icon: LucideIcons.receipt,
              color: SXEColors.aubergine,
              value: '24 Today',
              items: [
                {
                  'name': 'Starbucks Coffee',
                  'amount': '-\$5.50',
                  'time': '2 hours ago'
                },
                {
                  'name': 'Salary Deposit',
                  'amount': '+\$3,200',
                  'time': '1 day ago'
                },
                {
                  'name': 'Uber Ride',
                  'amount': '-\$12.30',
                  'time': '1 day ago'
                },
                {
                  'name': 'Amazon Purchase',
                  'amount': '-\$89.99',
                  'time': '2 days ago'
                },
              ],
              onTap: () => _showTransactionsDetail(),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTransactionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: SXEColors.surface,
        title: Text(
          'Add Transaction',
          style: SXETypography.functionalHeadline,
        ),
        content: Text(
          'Add new transaction feature coming soon!',
          style: SXETypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showWalletsDetail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Wallets detail coming soon!')),
    );
  }

  void _showBudgetDetail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Budget detail coming soon!')),
    );
  }

  void _showSubscriptionsDetail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Subscriptions detail coming soon!')),
    );
  }

  void _showTransactionsDetail() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transactions detail coming soon!')),
    );
  }
}

class _FinancialColumn extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  final bool isLight;

  const _FinancialColumn({
    required this.title,
    required this.amount,
    required this.color,
    this.isLight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: SXETypography.bodySmall.copyWith(
            color: isLight ? color.withValues(alpha: 0.8) : color,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: SXETypography.functionalHeadline.copyWith(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
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

class _FinancialManagementCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String value;
  final List<Map<String, dynamic>> items;
  final VoidCallback onTap;

  const _FinancialManagementCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.value,
    required this.items,
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
          border: Border.all(color: color.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    const SizedBox(width: 12),
                    Column(
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
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    value,
                    style: SXETypography.bodySmall.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Items List
            ...items.take(4).map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _buildItemRow(item, color),
                )),

            if (items.length > 4) ...[
              const SizedBox(height: 8),
              Text(
                '+${items.length - 4} more items',
                style: SXETypography.bodySmall.copyWith(
                  color: SXEColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildItemRow(Map<String, dynamic> item, Color color) {
    return Row(
      children: [
        if (item['icon'] != null) ...[
          Icon(
            item['icon'],
            size: 16,
            color: SXEColors.textSecondary,
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Text(
            item['name'],
            style: SXETypography.bodySmall.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        if (item['progress'] != null) ...[
          Expanded(
            child: LinearProgressIndicator(
              value: item['progress'],
              backgroundColor: SXEColors.borderLight,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
        ],
        Text(
          item['amount'] ?? item['time'] ?? '',
          style: SXETypography.bodySmall.copyWith(
            color: item['amount']?.startsWith('-') == true
                ? SXEColors.coral
                : item['amount']?.startsWith('+') == true
                    ? SXEColors.kelp
                    : SXEColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
