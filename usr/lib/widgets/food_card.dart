import 'package:flutter/material.dart';
import '../models/food_item.dart';

class FoodCard extends StatelessWidget {
  final FoodItem food;
  final VoidCallback onDelete;

  const FoodCard({
    super.key,
    required this.food,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${food.servingSize.toInt()} جرام',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${food.calories.toInt()} سعرة',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: onDelete,
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNutrientInfo(
                  'بروتين',
                  food.protein,
                  Icons.egg_outlined,
                  Colors.red,
                ),
                _buildNutrientInfo(
                  'كربوهيدرات',
                  food.carbs,
                  Icons.grain,
                  Colors.orange,
                ),
                _buildNutrientInfo(
                  'دهون',
                  food.fat,
                  Icons.water_drop_outlined,
                  Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientInfo(
    String label,
    double value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          '${value.toStringAsFixed(1)} جم',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}