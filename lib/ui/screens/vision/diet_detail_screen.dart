import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sxe/ui/theme/sxe_colors.dart';
import 'package:sxe/ui/theme/sxe_typography.dart';

class DietDetailScreen extends StatefulWidget {
  const DietDetailScreen({super.key});

  @override
  State<DietDetailScreen> createState() => _DietDetailScreenState();
}

class _DietDetailScreenState extends State<DietDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Calorie tracking
  int _dailyCalories = 0;
  int _dailyCalorieGoal = 2000;
  final List<Map<String, dynamic>> _todaysMeals = [];

  // Recipe tracking
  final List<Map<String, dynamic>> _savedRecipes = [
    {
      'name': 'Grilled Chicken Salad',
      'calories': 350,
      'prepTime': 15,
      'difficulty': 'Easy',
      'rating': 4.5,
      'image': '🥗',
    },
    {
      'name': 'Quinoa Buddha Bowl',
      'calories': 420,
      'prepTime': 25,
      'difficulty': 'Medium',
      'rating': 4.8,
      'image': '🍲',
    },
  ];

  // Ingredient tracking
  final List<Map<String, dynamic>> _pantryItems = [
    {
      'name': 'Chicken Breast',
      'quantity': '2 lbs',
      'expiry': '2024-01-15',
      'category': 'Protein'
    },
    {
      'name': 'Brown Rice',
      'quantity': '1 bag',
      'expiry': '2024-06-01',
      'category': 'Grains'
    },
    {
      'name': 'Spinach',
      'quantity': '1 bunch',
      'expiry': '2024-01-10',
      'category': 'Vegetables'
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
          'Nutrition',
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
            Tab(text: 'Calories'),
            Tab(text: 'Recipes'),
            Tab(text: 'Pantry'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCalorieTracker(),
          _buildRecipeTracker(),
          _buildIngredientTracker(),
        ],
      ),
    );
  }

  // Calorie Tracker Tab
  Widget _buildCalorieTracker() {
    final progress = _dailyCalories / _dailyCalorieGoal;
    final remainingCalories = _dailyCalorieGoal - _dailyCalories;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Minimal Progress Overview
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  SXEColors.kelp.withValues(alpha: 0.05),
                  SXEColors.aubergine.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: SXEColors.borderLight),
            ),
            child: Column(
              children: [
                // Main calorie display
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '$_dailyCalories',
                      style: SXETypography.functionalHeadline.copyWith(
                        fontSize: 48,
                        fontWeight: FontWeight.w300,
                        color: SXEColors.textPrimary,
                      ),
                    ),
                    Text(
                      ' / $_dailyCalorieGoal',
                      style: SXETypography.bodyLarge.copyWith(
                        color: SXEColors.textSecondary,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'calories today',
                  style: SXETypography.bodyMedium.copyWith(
                    color: SXEColors.textSecondary,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 24),

                // Progress bar
                Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: SXEColors.borderLight,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: progress > 1.0
                              ? [
                                  SXEColors.coral,
                                  SXEColors.coral.withValues(alpha: 0.7)
                                ]
                              : [SXEColors.kelp, SXEColors.aubergine],
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Remaining calories
                Text(
                  remainingCalories >= 0
                      ? '$remainingCalories calories remaining'
                      : '${remainingCalories.abs()} calories over goal',
                  style: SXETypography.bodySmall.copyWith(
                    color: remainingCalories >= 0
                        ? SXEColors.kelp
                        : SXEColors.coral,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Quick Actions
          Row(
            children: [
              Expanded(
                child: _QuickActionButton(
                  icon: LucideIcons.plus,
                  label: 'Add Meal',
                  color: SXEColors.primary,
                  onTap: () => _showAddMealDialog(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickActionButton(
                  icon: LucideIcons.target,
                  label: 'Set Goal',
                  color: SXEColors.aubergine,
                  onTap: () => _showGoalDialog(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Today's Meals Section
          if (_todaysMeals.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today\'s Meals',
                  style: SXETypography.functionalHeadline.copyWith(
                    fontSize: 20,
                  ),
                ),
                Text(
                  '${_todaysMeals.length} meals',
                  style: SXETypography.bodySmall.copyWith(
                    color: SXEColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ..._todaysMeals.map((meal) => _MinimalMealCard(
                  name: meal['name'],
                  calories: meal['calories'],
                  time: meal['time'],
                  type: meal['type'],
                  onDelete: () {
                    setState(() {
                      _dailyCalories -= meal['calories'] as int;
                      _todaysMeals.remove(meal);
                    });
                  },
                )),
          ] else ...[
            // Empty state
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: SXEColors.kelp.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Icon(
                      LucideIcons.utensils,
                      size: 32,
                      color: SXEColors.kelp,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'No meals yet',
                    style: SXETypography.functionalHeadline.copyWith(
                      fontSize: 18,
                      color: SXEColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start tracking your nutrition by adding your first meal',
                    style: SXETypography.bodyMedium.copyWith(
                      color: SXEColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Recipe Tracker Tab
  Widget _buildRecipeTracker() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Add Recipe Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Saved Recipes',
                style: SXETypography.functionalHeadline,
              ),
              ElevatedButton.icon(
                onPressed: () => _showAddRecipeDialog(),
                icon: const Icon(LucideIcons.plus, size: 16),
                label: const Text('Add Recipe'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: SXEColors.aubergine,
                  foregroundColor: SXEColors.onPrimary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Recipe Cards
          ..._savedRecipes.map((recipe) => _RecipeCard(
                name: recipe['name'],
                calories: recipe['calories'],
                prepTime: recipe['prepTime'],
                difficulty: recipe['difficulty'],
                rating: recipe['rating'],
                image: recipe['image'],
                onTap: () => _showRecipeDetail(recipe),
                onCook: () => _cookRecipe(recipe),
              )),

          const SizedBox(height: 16),

          // Recipe Categories
          Text(
            'Browse by Category',
            style: SXETypography.functionalHeadline,
          ),
          const SizedBox(height: 16),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _CategoryChip(
                label: 'Breakfast',
                icon: LucideIcons.sunrise,
                color: SXEColors.coral,
                onTap: () => _browseCategory('Breakfast'),
              ),
              _CategoryChip(
                label: 'Lunch',
                icon: LucideIcons.sun,
                color: SXEColors.kelp,
                onTap: () => _browseCategory('Lunch'),
              ),
              _CategoryChip(
                label: 'Dinner',
                icon: LucideIcons.moon,
                color: SXEColors.midnight,
                onTap: () => _browseCategory('Dinner'),
              ),
              _CategoryChip(
                label: 'Snacks',
                icon: LucideIcons.cookie,
                color: SXEColors.aubergine,
                onTap: () => _browseCategory('Snacks'),
              ),
              _CategoryChip(
                label: 'Healthy',
                icon: LucideIcons.heart,
                color: SXEColors.kelp,
                onTap: () => _browseCategory('Healthy'),
              ),
              _CategoryChip(
                label: 'Quick',
                icon: LucideIcons.zap,
                color: SXEColors.coral,
                onTap: () => _browseCategory('Quick'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Ingredient/Pantry Tracker Tab
  Widget _buildIngredientTracker() {
    final expiringSoon = _pantryItems.where((item) {
      final expiry = DateTime.parse(item['expiry']);
      final daysUntilExpiry = expiry.difference(DateTime.now()).inDays;
      return daysUntilExpiry <= 3;
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Add Item Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pantry Items',
                style: SXETypography.functionalHeadline,
              ),
              ElevatedButton.icon(
                onPressed: () => _showAddIngredientDialog(),
                icon: const Icon(LucideIcons.plus, size: 16),
                label: const Text('Add Item'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: SXEColors.midnight,
                  foregroundColor: SXEColors.onPrimary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Expiring Soon Alert
          if (expiringSoon.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: SXEColors.coral.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border:
                    Border.all(color: SXEColors.coral.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  Icon(
                    LucideIcons.alertTriangle,
                    color: SXEColors.coral,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Items Expiring Soon',
                          style: SXETypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: SXEColors.coral,
                          ),
                        ),
                        Text(
                          '${expiringSoon.length} items expire within 3 days',
                          style: SXETypography.bodySmall.copyWith(
                            color: SXEColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // Pantry Items by Category
          ..._getPantryCategories().entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    entry.key,
                    style: SXETypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: SXEColors.textPrimary,
                    ),
                  ),
                ),
                ...entry.value.map((item) => _IngredientCard(
                      name: item['name'],
                      quantity: item['quantity'],
                      expiry: item['expiry'],
                      category: item['category'],
                      onEdit: () => _editIngredient(item),
                      onDelete: () => _deleteIngredient(item),
                    )),
                const SizedBox(height: 24),
              ],
            );
          }),
        ],
      ),
    );
  }

  // Helper Methods
  Map<String, List<Map<String, dynamic>>> _getPantryCategories() {
    final categories = <String, List<Map<String, dynamic>>>{};
    for (final item in _pantryItems) {
      final category = item['category'] as String;
      categories.putIfAbsent(category, () => []).add(item);
    }
    return categories;
  }

  // Dialog Methods
  void _showAddMealDialog() {
    final nameController = TextEditingController();
    final caloriesController = TextEditingController();
    String selectedMealType = 'Breakfast';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: SXEColors.surface,
        title: Text(
          'Add Meal',
          style: SXETypography.functionalHeadline,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Meal Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: caloriesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Calories',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedMealType,
              decoration: InputDecoration(
                labelText: 'Meal Type',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: ['Breakfast', 'Lunch', 'Dinner', 'Snack']
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                selectedMealType = value!;
              },
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
              if (nameController.text.isNotEmpty &&
                  caloriesController.text.isNotEmpty) {
                setState(() {
                  final calories = int.tryParse(caloriesController.text) ?? 0;
                  _todaysMeals.add({
                    'name': nameController.text,
                    'calories': calories,
                    'time': TimeOfDay.now().format(context),
                    'type': selectedMealType,
                  });
                  _dailyCalories += calories;
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showGoalDialog() {
    final controller =
        TextEditingController(text: _dailyCalorieGoal.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: SXEColors.surface,
        title: Text(
          'Set Daily Goal',
          style: SXETypography.functionalHeadline,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Daily Calorie Goal',
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
              setState(() {
                _dailyCalorieGoal = int.tryParse(controller.text) ?? 2000;
              });
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAddRecipeDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Add Recipe feature coming soon!')),
    );
  }

  void _showRecipeDetail(Map<String, dynamic> recipe) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: SXEColors.surface,
        title: Text(
          recipe['name'],
          style: SXETypography.functionalHeadline,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${recipe['image']} ${recipe['name']}',
              style: SXETypography.bodyLarge.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(LucideIcons.clock,
                    size: 16, color: SXEColors.textSecondary),
                const SizedBox(width: 8),
                Text('${recipe['prepTime']} min'),
                const SizedBox(width: 16),
                Icon(LucideIcons.zap, size: 16, color: SXEColors.textSecondary),
                const SizedBox(width: 8),
                Text('${recipe['calories']} cal'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(LucideIcons.barChart,
                    size: 16, color: SXEColors.textSecondary),
                const SizedBox(width: 8),
                Text(recipe['difficulty']),
                const SizedBox(width: 16),
                Icon(LucideIcons.star,
                    size: 16, color: SXEColors.textSecondary),
                const SizedBox(width: 8),
                Text('${recipe['rating']}/5'),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _cookRecipe(recipe);
            },
            child: const Text('Cook This'),
          ),
        ],
      ),
    );
  }

  void _cookRecipe(Map<String, dynamic> recipe) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: SXEColors.surface,
        title: const Text('Add to Meals'),
        content: Text('Add "${recipe['name']}" to today\'s meals?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _todaysMeals.add({
                  'name': recipe['name'],
                  'calories': recipe['calories'],
                  'time': TimeOfDay.now().format(context),
                  'type': 'Recipe',
                });
                _dailyCalories += recipe['calories'] as int;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${recipe['name']} added to meals!')),
              );
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _browseCategory(String category) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Browse $category recipes coming soon!')),
    );
  }

  void _showAddIngredientDialog() {
    final nameController = TextEditingController();
    final quantityController = TextEditingController();
    final expiryController = TextEditingController();
    String selectedCategory = 'Vegetables';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: SXEColors.surface,
        title: Text(
          'Add Pantry Item',
          style: SXETypography.functionalHeadline,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Item Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: expiryController,
              decoration: InputDecoration(
                labelText: 'Expiry Date (YYYY-MM-DD)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: [
                'Vegetables',
                'Protein',
                'Grains',
                'Dairy',
                'Fruits',
                'Spices'
              ]
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              onChanged: (value) {
                selectedCategory = value!;
              },
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
              if (nameController.text.isNotEmpty &&
                  quantityController.text.isNotEmpty &&
                  expiryController.text.isNotEmpty) {
                setState(() {
                  _pantryItems.add({
                    'name': nameController.text,
                    'quantity': quantityController.text,
                    'expiry': expiryController.text,
                    'category': selectedCategory,
                  });
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editIngredient(Map<String, dynamic> item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Edit ${item['name']} coming soon!')),
    );
  }

  void _deleteIngredient(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: SXEColors.surface,
        title: const Text('Delete Item'),
        content: Text('Remove "${item['name']}" from pantry?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _pantryItems.remove(item);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: SXEColors.coral),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

// Quick Action Button Widget
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
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: SXETypography.bodyMedium.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Minimal Meal Card Widget
class _MinimalMealCard extends StatelessWidget {
  final String name;
  final int calories;
  final String time;
  final String type;
  final VoidCallback onDelete;

  const _MinimalMealCard({
    required this.name,
    required this.calories,
    required this.time,
    required this.type,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SXEColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: SXEColors.borderLight),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: _getMealTypeColor(type),
              borderRadius: BorderRadius.circular(4),
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
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Text(
                      '$calories cal',
                      style: SXETypography.bodySmall.copyWith(
                        color: SXEColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '•',
                      style: SXETypography.bodySmall.copyWith(
                        color: SXEColors.textTertiary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: SXETypography.bodySmall.copyWith(
                        color: SXEColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onDelete,
            child: Container(
              padding: const EdgeInsets.all(4),
              child: Icon(
                LucideIcons.x,
                color: SXEColors.textTertiary,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getMealTypeColor(String type) {
    switch (type) {
      case 'Breakfast':
        return SXEColors.coral;
      case 'Lunch':
        return SXEColors.kelp;
      case 'Dinner':
        return SXEColors.midnight;
      case 'Snack':
        return SXEColors.aubergine;
      default:
        return SXEColors.textSecondary;
    }
  }
}

// Meal Card Widget
class _MealCard extends StatelessWidget {
  final String name;
  final int calories;
  final String time;
  final String type;
  final VoidCallback onDelete;

  const _MealCard({
    required this.name,
    required this.calories,
    required this.time,
    required this.type,
    required this.onDelete,
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
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: SXEColors.kelp.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              LucideIcons.utensils,
              color: SXEColors.kelp,
              size: 24,
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
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '$calories cal',
                      style: SXETypography.bodySmall.copyWith(
                        color: SXEColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      time,
                      style: SXETypography.bodySmall.copyWith(
                        color: SXEColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: SXEColors.aubergine.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        type,
                        style: SXETypography.bodySmall.copyWith(
                          color: SXEColors.aubergine,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: Icon(
              LucideIcons.trash2,
              color: SXEColors.coral,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

// Recipe Card Widget
class _RecipeCard extends StatelessWidget {
  final String name;
  final int calories;
  final int prepTime;
  final String difficulty;
  final double rating;
  final String image;
  final VoidCallback onTap;
  final VoidCallback onCook;

  const _RecipeCard({
    required this.name,
    required this.calories,
    required this.prepTime,
    required this.difficulty,
    required this.rating,
    required this.image,
    required this.onTap,
    required this.onCook,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: SXEColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: SXEColors.borderLight),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: SXEColors.aubergine.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  image,
                  style: const TextStyle(fontSize: 24),
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
                    style: SXETypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(LucideIcons.clock,
                          size: 14, color: SXEColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        '${prepTime}m',
                        style: SXETypography.bodySmall.copyWith(
                          color: SXEColors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(LucideIcons.zap,
                          size: 14, color: SXEColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        '${calories} cal',
                        style: SXETypography.bodySmall.copyWith(
                          color: SXEColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: SXEColors.midnight.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          difficulty,
                          style: SXETypography.bodySmall.copyWith(
                            color: SXEColors.midnight,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(LucideIcons.star,
                          size: 12, color: SXEColors.textSecondary),
                      const SizedBox(width: 2),
                      Text(
                        rating.toString(),
                        style: SXETypography.bodySmall.copyWith(
                          color: SXEColors.textSecondary,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: onCook,
              style: ElevatedButton.styleFrom(
                backgroundColor: SXEColors.aubergine,
                foregroundColor: SXEColors.onPrimary,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Cook'),
            ),
          ],
        ),
      ),
    );
  }
}

// Category Chip Widget
class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: SXETypography.bodySmall.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Ingredient Card Widget
class _IngredientCard extends StatelessWidget {
  final String name;
  final String quantity;
  final String expiry;
  final String category;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _IngredientCard({
    required this.name,
    required this.quantity,
    required this.expiry,
    required this.category,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final expiryDate = DateTime.parse(expiry);
    final daysUntilExpiry = expiryDate.difference(DateTime.now()).inDays;
    final isExpiringSoon = daysUntilExpiry <= 3;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SXEColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isExpiringSoon
              ? SXEColors.coral.withValues(alpha: 0.3)
              : SXEColors.borderLight,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _getCategoryColor(category).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getCategoryIcon(category),
              color: _getCategoryColor(category),
              size: 24,
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
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      quantity,
                      style: SXETypography.bodySmall.copyWith(
                        color: SXEColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Expires: ${_formatDate(expiryDate)}',
                      style: SXETypography.bodySmall.copyWith(
                        color: isExpiringSoon
                            ? SXEColors.coral
                            : SXEColors.textSecondary,
                        fontWeight: isExpiringSoon
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'edit') {
                onEdit();
              } else if (value == 'delete') {
                onDelete();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(LucideIcons.edit, size: 16),
                    SizedBox(width: 8),
                    Text('Edit'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(LucideIcons.trash2, size: 16),
                    SizedBox(width: 8),
                    Text('Delete'),
                  ],
                ),
              ),
            ],
            child: Icon(
              LucideIcons.moreVertical,
              color: SXEColors.textSecondary,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Vegetables':
        return SXEColors.kelp;
      case 'Protein':
        return SXEColors.coral;
      case 'Grains':
        return SXEColors.aubergine;
      case 'Dairy':
        return SXEColors.midnight;
      case 'Fruits':
        return Colors.orange;
      case 'Spices':
        return Colors.brown;
      default:
        return SXEColors.textSecondary;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Vegetables':
        return LucideIcons.carrot;
      case 'Protein':
        return LucideIcons.beef;
      case 'Grains':
        return LucideIcons.wheat;
      case 'Dairy':
        return LucideIcons.milk;
      case 'Fruits':
        return LucideIcons.apple;
      case 'Spices':
        return LucideIcons.sparkles;
      default:
        return LucideIcons.package;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Tomorrow';
    if (difference < 0) return 'Expired';
    return '${difference}d';
  }
}
