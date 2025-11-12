import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/food_item.dart';
import '../models/daily_intake.dart';
import '../widgets/food_card.dart';
import '../widgets/calorie_summary.dart';
import 'add_food_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DailyIntake _dailyIntake = DailyIntake();
  double _dailyGoal = 2000;

  void _addFood(FoodItem food) {
    setState(() {
      _dailyIntake.addFood(food);
    });
  }

  void _removeFood(int index) {
    setState(() {
      _dailyIntake.removeFood(index);
    });
  }

  void _showGoalDialog() {
    final TextEditingController controller = TextEditingController(
      text: _dailyGoal.toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تعيين الهدف اليومي'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            labelText: 'السعرات الحرارية اليومية',
            suffixText: 'سعرة حرارية',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _dailyGoal = double.tryParse(controller.text) ?? 2000;
              });
              Navigator.pop(context);
            },
            child: const Text('حفظ'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حاسبة السعرات الحرارية'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showGoalDialog,
            tooltip: 'تعيين الهدف اليومي',
          ),
        ],
      ),
      body: Column(
        children: [
          CalorieSummary(
            totalCalories: _dailyIntake.totalCalories,
            dailyGoal: _dailyGoal,
            totalProtein: _dailyIntake.totalProtein,
            totalCarbs: _dailyIntake.totalCarbs,
            totalFat: _dailyIntake.totalFat,
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'الوجبات اليوم',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: _dailyIntake.foods.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.restaurant_menu,
                          size: 80,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'لم تضف أي وجبات بعد',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'اضغط على الزر أدناه لإضافة وجبة',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _dailyIntake.foods.length,
                    itemBuilder: (context, index) {
                      return FoodCard(
                        food: _dailyIntake.foods[index],
                        onDelete: () => _removeFood(index),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final food = await Navigator.push<FoodItem>(
            context,
            MaterialPageRoute(
              builder: (context) => const AddFoodScreen(),
            ),
          );
          if (food != null) {
            _addFood(food);
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('إضافة وجبة'),
      ),
    );
  }
}