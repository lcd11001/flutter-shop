import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shopping/data/categories.dart';
import 'package:shopping/models/category.dart';

import 'package:shopping/utils/thousands_formatter.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({super.key});

  @override
  State<StatefulWidget> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              keyboardType: TextInputType.text,
              maxLength: 50,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              initialValue: '1',
              decoration: const InputDecoration(
                labelText: 'Quantity',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                ThousandsFormatter(),
              ],
            ),
            DropdownButtonFormField(
              items: _buildCategoryItems(),
              onChanged: (selected) {
                debugPrint('Selected: $selected');
              },
              decoration: const InputDecoration(
                labelText: 'Category',
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Add Item'),
            ),
          ],
        )),
      ),
    );
  }

  List<DropdownMenuItem<Category>> _buildCategoryItems() {
    return categories.entries.map((item) {
      return DropdownMenuItem<Category>(
        value: item.value,
        child: Row(
          children: [
            Container(
              width: 16,
              height: 16,
              color: item.value.color,
            ),
            const SizedBox(width: 8),
            Text(item.value.name),
          ],
        ),
      );
    }).toList();
  }
}
