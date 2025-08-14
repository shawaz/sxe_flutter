import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sxe/ui/theme/sxe_colors.dart';
import 'package:sxe/ui/theme/sxe_typography.dart';

class BudgetTrackerScreen extends StatefulWidget {
  const BudgetTrackerScreen({super.key});

  @override
  State<BudgetTrackerScreen> createState() => _BudgetTrackerScreenState();
}

class _BudgetTrackerScreenState extends State<BudgetTrackerScreen> {
  // Mock data for budget tracking
  final double _dailyBudget = 150.0;
  final double _spentToday = 87.50;

  final List<Map<String, dynamic>> _todayTransactions = [
    {
      'title': 'Morning Coffee',
      'amount': -4.50,
      'category': 'Food & Drink',
      'time': '08:30 AM',
      'icon': LucideIcons.coffee,
      'color': SXEColors.coral,
    },
    {
      'title': 'Lunch',
      'amount': -12.00,
      'category': 'Food & Drink',
      'time': '12:45 PM',
      'icon': LucideIcons.utensils,
      'color': SXEColors.coral,
    },
    {
      'title': 'Gas Station',
      'amount': -45.00,
      'category': 'Transportation',
      'time': '02:15 PM',
      'icon': LucideIcons.fuel,
      'color': SXEColors.aubergine,
    },
    {
      'title': 'Grocery Store',
      'amount': -26.00,
      'category': 'Shopping',
      'time': '04:30 PM',
      'icon': LucideIcons.shoppingCart,
      'color': SXEColors.midnight,
    },
  ];

  final List<Map<String, dynamic>> _budgetCategories = [
    {
      'name': 'Food & Drink',
      'budgeted': 50.0,
      'spent': 16.50,
      'icon': LucideIcons.utensils,
      'color': SXEColors.coral,
    },
    {
      'name': 'Transportation',
      'budgeted': 40.0,
      'spent': 45.00,
      'icon': LucideIcons.car,
      'color': SXEColors.aubergine,
    },
    {
      'name': 'Shopping',
      'budgeted': 30.0,
      'spent': 26.00,
      'icon': LucideIcons.shoppingBag,
      'color': SXEColors.midnight,
    },
    {
      'name': 'Entertainment',
      'budgeted': 20.0,
      'spent': 0.00,
      'icon': LucideIcons.gamepad2,
      'color': SXEColors.kelp,
    },
    {
      'name': 'Health',
      'budgeted': 10.0,
      'spent': 0.00,
      'icon': LucideIcons.heart,
      'color': SXEColors.lilac,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final remainingBudget = _dailyBudget - _spentToday;
    final budgetProgress = _spentToday / _dailyBudget;

    return Scaffold(
      backgroundColor: SXEColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Daily Budget',
          style: SXETypography.functionalHeadline,
        ),
        backgroundColor: SXEColors.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.plus),
            onPressed: () => _showAddTransactionDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Budget Overview Card
            Container(
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
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: SXEColors.primary.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Today\'s Budget',
                        style: SXETypography.functionalHeadline.copyWith(
                          color: SXEColors.onPrimary,
                        ),
                      ),
                      Icon(
                        LucideIcons.dollarSign,
                        color: SXEColors.onPrimary,
                        size: 28,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Remaining',
                            style: SXETypography.bodySmall.copyWith(
                              color: SXEColors.onPrimary.withValues(alpha: 0.8),
                            ),
                          ),
                          Text(
                            '\$${remainingBudget.toStringAsFixed(2)}',
                            style: SXETypography.largeHeadline.copyWith(
                              color: SXEColors.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Spent',
                            style: SXETypography.bodySmall.copyWith(
                              color: SXEColors.onPrimary.withValues(alpha: 0.8),
                            ),
                          ),
                          Text(
                            '\$${_spentToday.toStringAsFixed(2)}',
                            style: SXETypography.functionalHeadline.copyWith(
                              color: SXEColors.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  LinearProgressIndicator(
                    value: budgetProgress,
                    backgroundColor: SXEColors.onPrimary.withValues(alpha: 0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      budgetProgress > 0.8 ? SXEColors.coral : SXEColors.kelp,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${(budgetProgress * 100).toInt()}% of daily budget used',
                    style: SXETypography.bodySmall.copyWith(
                      color: SXEColors.onPrimary.withValues(alpha: 0.8),
                    ),
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
                    title: 'Remaining',
                    value: '\$${remainingBudget.toStringAsFixed(0)}',
                    icon: LucideIcons.wallet,
                    color:
                        remainingBudget > 0 ? SXEColors.kelp : SXEColors.coral,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    title: 'Spent Today',
                    value: '\$${_spentToday.toStringAsFixed(0)}',
                    icon: LucideIcons.creditCard,
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
                    title: 'Categories',
                    value: '${_budgetCategories.length}',
                    icon: LucideIcons.pieChart,
                    color: SXEColors.midnight,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    title: 'Transactions',
                    value: '${_todayTransactions.length}',
                    icon: LucideIcons.receipt,
                    color: SXEColors.lilac,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Budget Management Cards
            Text(
              'Budget Management',
              style: SXETypography.functionalHeadline,
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _BudgetManagementCard(
                    title: 'Wallet',
                    subtitle: 'Manage your cash flow',
                    icon: LucideIcons.wallet,
                    color: SXEColors.kelp,
                    value: '\$2,450',
                    onTap: () => _navigateToWallet(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _BudgetManagementCard(
                    title: 'Budget',
                    subtitle: 'Track spending limits',
                    icon: LucideIcons.pieChart,
                    color: SXEColors.midnight,
                    value: '85%',
                    onTap: () => _navigateToBudget(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: _BudgetManagementCard(
                    title: 'Subscriptions',
                    subtitle: 'Monthly recurring costs',
                    icon: LucideIcons.repeat,
                    color: SXEColors.coral,
                    value: '\$89/mo',
                    onTap: () => _navigateToSubscriptions(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _BudgetManagementCard(
                    title: 'Transactions',
                    subtitle: 'Recent activity',
                    icon: LucideIcons.receipt,
                    color: SXEColors.aubergine,
                    value: '24',
                    onTap: () => _navigateToTransactions(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Category Breakdown
            Text(
              'Category Breakdown',
              style: SXETypography.functionalHeadline,
            ),
            const SizedBox(height: 16),

            ..._budgetCategories.map((category) {
              return _CategoryCard(
                name: category['name'],
                budgeted: category['budgeted'],
                spent: category['spent'],
                icon: category['icon'],
                color: category['color'],
              );
            }),

            const SizedBox(height: 32),

            // Today's Transactions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today\'s Transactions',
                  style: SXETypography.functionalHeadline,
                ),
                Text(
                  '${_todayTransactions.length} items',
                  style: SXETypography.bodySmall.copyWith(
                    color: SXEColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            ..._todayTransactions.map((transaction) {
              return _TransactionCard(
                title: transaction['title'],
                amount: transaction['amount'],
                category: transaction['category'],
                time: transaction['time'],
                icon: transaction['icon'],
                color: transaction['color'],
              );
            }),

            const SizedBox(height: 32),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: _QuickActionButton(
                    icon: LucideIcons.plus,
                    label: 'Add Expense',
                    color: SXEColors.coral,
                    onTap: () => _showAddTransactionDialog(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _QuickActionButton(
                    icon: LucideIcons.pieChart,
                    label: 'View Report',
                    color: SXEColors.kelp,
                    onTap: () => _showReportDialog(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTransactionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: SXEColors.surface,
        title: Text(
          'Add Transaction',
          style: SXETypography.functionalHeadline,
        ),
        content: Text(
          'Transaction entry feature coming soon!',
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

  void _showReportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: SXEColors.surface,
        title: Text(
          'Budget Report',
          style: SXETypography.functionalHeadline,
        ),
        content: Text(
          'Detailed budget reports coming soon!',
          style: SXETypography.bodyMedium,
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

  void _navigateToWallet() {
    // Navigate to wallet screen or show wallet details
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Wallet feature coming soon!')),
    );
  }

  void _navigateToBudget() {
    // Navigate to budget details or settings
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Budget settings coming soon!')),
    );
  }

  void _navigateToSubscriptions() {
    // Navigate to subscriptions management
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Subscriptions management coming soon!')),
    );
  }

  void _navigateToTransactions() {
    // Navigate to transactions history
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transaction history coming soon!')),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String name;
  final double budgeted;
  final double spent;
  final IconData icon;
  final Color color;

  const _CategoryCard({
    required this.name,
    required this.budgeted,
    required this.spent,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final progress = spent / budgeted;
    final isOverBudget = spent > budgeted;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: SXEColors.surface,
        leading: Container(
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
        title: Text(
          name,
          style: SXETypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${spent.toStringAsFixed(2)} spent',
                  style: SXETypography.bodySmall.copyWith(
                    color: isOverBudget
                        ? SXEColors.coral
                        : SXEColors.textSecondary,
                  ),
                ),
                Text(
                  'of \$${budgeted.toStringAsFixed(2)}',
                  style: SXETypography.bodySmall.copyWith(
                    color: SXEColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress > 1.0 ? 1.0 : progress,
              backgroundColor: SXEColors.borderLight,
              valueColor: AlwaysStoppedAnimation<Color>(
                isOverBudget ? SXEColors.coral : color,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isOverBudget
                ? SXEColors.coral.withValues(alpha: 0.1)
                : color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            '${(progress * 100).toInt()}%',
            style: SXETypography.bodySmall.copyWith(
              color: isOverBudget ? SXEColors.coral : color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final String title;
  final double amount;
  final String category;
  final String time;
  final IconData icon;
  final Color color;

  const _TransactionCard({
    required this.title,
    required this.amount,
    required this.category,
    required this.time,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: SXEColors.surface,
        leading: Container(
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
        title: Text(
          title,
          style: SXETypography.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '$category • $time',
          style: SXETypography.bodySmall.copyWith(
            color: SXEColors.textSecondary,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: amount < 0
                ? SXEColors.coral.withValues(alpha: 0.1)
                : SXEColors.kelp.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            amount < 0
                ? '-\$${(-amount).toStringAsFixed(2)}'
                : '+\$${amount.toStringAsFixed(2)}',
            style: SXETypography.bodyMedium.copyWith(
              color: amount < 0 ? SXEColors.coral : SXEColors.kelp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: SXEColors.onPrimary,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: SXETypography.bodyMedium.copyWith(
                color: SXEColors.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
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

class _BudgetManagementCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final String value;
  final VoidCallback onTap;

  const _BudgetManagementCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.value,
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
          boxShadow: [
            BoxShadow(
              color: SXEColors.sxeBlack.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 20,
                  ),
                ),
                Text(
                  value,
                  style: SXETypography.functionalHeadline.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: SXETypography.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: SXETypography.bodySmall.copyWith(
                color: SXEColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
