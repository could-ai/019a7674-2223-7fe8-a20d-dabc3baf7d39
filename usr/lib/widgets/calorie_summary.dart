import 'package:flutter/material.dart';
import 'dart:math' as math;

class CalorieSummary extends StatelessWidget {
  final double totalCalories;
  final double dailyGoal;
  final double totalProtein;
  final double totalCarbs;
  final double totalFat;

  const CalorieSummary({
    super.key,
    required this.totalCalories,
    required this.dailyGoal,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFat,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (totalCalories / dailyGoal * 100).clamp(0, 100);
    final remaining = math.max(0, dailyGoal - totalCalories);

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'السعرات المستهلكة',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${totalCalories.toInt()} / ${dailyGoal.toInt()}',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'متبقي: ${remaining.toInt()} سعرة',
                      style: TextStyle(
                        fontSize: 14,
                        color: remaining > 0 ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 120,
                  height: 120,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: percentage / 100,
                        strokeWidth: 12,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          percentage < 90
                              ? Colors.green
                              : percentage < 100
                                  ? Colors.orange
                                  : Colors.red,
                        ),
                      ),
                      Text(
                        '${percentage.toInt()}%',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMacroInfo(
                  'البروتين',
                  totalProtein,
                  Colors.red,
                  Icons.egg,
                ),
                _buildMacroInfo(
                  'الكربوهيدرات',
                  totalCarbs,
                  Colors.orange,
                  Icons.grain,
                ),
                _buildMacroInfo(
                  'الدهون',
                  totalFat,
                  Colors.blue,
                  Icons.water_drop,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroInfo(
    String label,
    double value,
    Color color,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          '${value.toStringAsFixed(1)} جم',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}