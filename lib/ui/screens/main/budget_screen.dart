import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sxe/ui/theme/sxe_colors.dart';
import 'package:sxe/ui/theme/sxe_typography.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("NETWORTH", 
                    style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 1,),
            
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
              ),
              padding: const EdgeInsets.all(16.0),
              margin: EdgeInsets.only(bottom: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("600",
                         style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("TOTAL", 
                        style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text("500",
                         style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green,
                        ),
                      ),
                      Text("INCOME",
                        style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold,
                        ),
                      ),
                     
                    ],
                  ),
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text("100",
                         style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red,
                        ),
                      ),
                      Text("EXPENSE",
                         style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold,
                        ),
                      ),
                     
                    ],
                  ),
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text("100",
                         style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue,
                        ),
                      ),
                      Text("BALANCE",
                         style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold,
                        ),
                      ),
                     
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
              ),
              padding: const EdgeInsets.all(16.0),
              margin: EdgeInsets.only(bottom: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text("500",
                         style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold, 
                        ),
                      ),
                      Text("2025",
                        style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold, 
                        ),
                      ),
                     
                    ],
                  ),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text("500",
                         style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green,
                        ),
                      ),
                      Text("INCOME",
                        style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold,
                        ),
                      ),
                     
                    ],
                  ),
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text("100",
                         style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red,
                        ),
                      ),
                      Text("EXPENSE",
                         style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold,
                        ),
                      ),
                     
                    ],
                  ),
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text("100",
                         style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue,
                        ),
                      ),
                      Text("BALANCE",
                         style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold,
                        ),
                      ),
                     
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24,),

            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
              ),
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("WALLETS", 
                    style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showAddTransactionDialog(context),
                    child: Text(
                      "ADD",
                      style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 1,),

            // Wallets grid (2 columns) based on provided mock
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: _WalletsGrid(
                wallets: [
                  const _WalletItem(title: 'BULLX', amount: '\$8,000', color: Colors.blue, icon: LucideIcons.wallet),
                  const _WalletItem(title: 'PHANTOM', amount: '\$8,000', color: Colors.blue, icon: LucideIcons.ghost),
                  const _WalletItem(title: 'BINANCE', amount: '\$5,000', color: Colors.blue, icon: LucideIcons.bitcoin),
                  const _WalletItem(title: 'JUSPAY', amount: '\$2,500', color: Colors.blue, icon: LucideIcons.banknote),
                  const _WalletItem(title: 'JUPITER SAVINGS', amount: '\$10,000', color: Colors.green, icon: LucideIcons.piggyBank),
                  const _WalletItem(title: 'JUPITER CREDIT', amount: '\$5,000', color: Colors.red, icon: LucideIcons.creditCard),
                  const _WalletItem(title: 'ENBD SAVINGS', amount: '\$20,000', color: Colors.green, icon: LucideIcons.piggyBank),
                  const _WalletItem(title: 'ENBD CREDIT', amount: '\$12,000', color: Colors.red, icon: LucideIcons.creditCard),
                ],
              ),
            ),
            SizedBox(height: 24,),

            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
              ),
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("INCOME", 
                    style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showAddTransactionDialog(context),
                    child: Text(
                        "ADD",
                      style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Single budget row example (Gold)
          Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        'ADVFUT', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'JOB',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        '10000', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'ACTUAL',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        '10000', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'PLANNED',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 
                ],
              ),
            ),
          Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        'ADVFUT', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'JOB',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        '10000', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'ACTUAL',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        '10000', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'PLANNED',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 
                ],
              ),
            ),
          
          Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        'ADVFUT', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'JOB',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        '10000', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'ACTUAL',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        '10000', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'PLANNED',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 
                ],
              ),
            ),
          Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        'ADVFUT', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'JOB',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        '10000', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'ACTUAL',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        '10000', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'PLANNED',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 
                ],
              ),
            ),
          
          SizedBox(height: 24,),

            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
              ),
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("EXPENSES", 
                    style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showAddTransactionDialog(context),
                    child: Text(
                        "ADD",
                      style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Single budget row example (Gold)
          Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        'ADVFUT', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'JOB',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        '10000', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'ACTUAL',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        '10000', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'PLANNED',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 
                ],
              ),
            ),
          Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        'ADVFUT', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'JOB',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        '10000', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'ACTUAL',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        '10000', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'PLANNED',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 
                ],
              ),
            ),
          
          Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        'ADVFUT', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'JOB',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        '10000', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'ACTUAL',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        '10000', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'PLANNED',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 
                ],
              ),
            ),
          Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        'ADVFUT', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'JOB',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        '10000', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'ACTUAL',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        '10000', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'PLANNED',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 
                ],
              ),
            ),
          SizedBox(height: 24,),

            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
              ),
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("TRASNACTIONS", 
                    style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showAddTransactionDialog(context),
                    child: Text(
                        "ADD",
                      style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.orange,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Single budget row example (Gold)
          Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        'ADVFUT', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        '04:00 | 07 JUN 2025',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                     
                      Text(
                        '10000', 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 4),
                  
                       Text(
                        'ENBD CREDIT',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
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

}

class _WalletsGrid extends StatelessWidget {
  final List<_WalletItem> wallets;

  const _WalletsGrid({required this.wallets});

  @override
  Widget build(BuildContext context) {
    final double spacing = 12;
    final double totalHorizontalPadding = 12 * 2; // from parent container
    final double availableWidth = MediaQuery.of(context).size.width - totalHorizontalPadding - spacing;
    final double tileWidth = availableWidth / 2;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: wallets
          .map((w) => SizedBox(width: tileWidth, child: _WalletTile(item: w)))
          .toList(),
    );
  }
}

class _WalletItem {
  final String title;
  final String amount;
  final Color color;
  final IconData icon;

  const _WalletItem({
    required this.title,
    required this.amount,
    required this.color,
    required this.icon,
  });
}

class _WalletTile extends StatelessWidget {
  final _WalletItem item;

  const _WalletTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12), right: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.amount,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: item.color),
                ),
                const SizedBox(height: 4),
                Text(
                  item.title,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
