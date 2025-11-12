import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/food_item.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fatController = TextEditingController();
  final _servingSizeController = TextEditingController(text: '100');

  @override
  void dispose() {
    _nameController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    _servingSizeController.dispose();
    super.dispose();
  }

  void _saveFood() {
    if (_formKey.currentState!.validate()) {
      final food = FoodItem(
        name: _nameController.text,
        calories: double.parse(_caloriesController.text),
        protein: double.tryParse(_proteinController.text) ?? 0,
        carbs: double.tryParse(_carbsController.text) ?? 0,
        fat: double.tryParse(_fatController.text) ?? 0,
        servingSize: double.parse(_servingSizeController.text),
      );
      Navigator.pop(context, food);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة وجبة جديدة'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'معلومات الوجبة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'اسم الوجبة',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.restaurant),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال اسم الوجبة';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _servingSizeController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: const InputDecoration(
                        labelText: 'حجم الحصة',
                        border: OutlineInputBorder(),
                        suffixText: 'جرام',
                        prefixIcon: Icon(Icons.scale),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال حجم الحصة';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'القيم الغذائية',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _caloriesController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                      ],
                      decoration: const InputDecoration(
                        labelText: 'السعرات الحرارية',
                        border: OutlineInputBorder(),
                        suffixText: 'سعرة',
                        prefixIcon: Icon(Icons.local_fire_department),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الرجاء إدخال السعرات الحرارية';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _proteinController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                      ],
                      decoration: const InputDecoration(
                        labelText: 'البروتين',
                        border: OutlineInputBorder(),
                        suffixText: 'جرام',
                        prefixIcon: Icon(Icons.egg),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _carbsController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                      ],
                      decoration: const InputDecoration(
                        labelText: 'الكربوهيدرات',
                        border: OutlineInputBorder(),
                        suffixText: 'جرام',
                        prefixIcon: Icon(Icons.grain),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _fatController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                      ],
                      decoration: const InputDecoration(
                        labelText: 'الدهون',
                        border: OutlineInputBorder(),
                        suffixText: 'جرام',
                        prefixIcon: Icon(Icons.water_drop),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveFood,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              child: const Text(
                'حفظ الوجبة',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}