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
  final _formKey = GlobalKey<FormState>();
  String _itemName = '';
  int _itemQuantity = 1;
  Category? _itemCategory;

  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      // Save the item
      _formKey.currentState!.save();
      debugPrint('Name: $_itemName');
      debugPrint('Quantity: $_itemQuantity');
      debugPrint('Category: ${_itemCategory!.name}');
    }
  }

  void _resetItem() {
    // Reset the form
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    /*
    If you want to return to the full-sized QWERTY layout in landscape, 
    drag the floating keyboard to the bottom of the display 
    and like magic it will open up to the full-sized landscape QWERTY 
    that you are familiar with.
    */
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
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
                  onSaved: (newValue) => _itemName = newValue!,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  initialValue: _itemQuantity.toString(),
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    ThousandsFormatter(),
                  ],
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        int.tryParse(value.replaceAll(',', '')) == null ||
                        int.tryParse(value.replaceAll(',', ''))! <= 0) {
                      return 'Please enter a valid quantity';
                    }
                    return null;
                  },
                  onSaved: (newValue) =>
                      _itemQuantity = int.parse(newValue!.replaceAll(',', '')),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField(
                  value: _itemCategory,
                  items: _buildCategoryItems(),
                  onChanged: (selected) {
                    debugPrint('Selected: $selected');
                    // don't need to call onSaved here
                    setState(() {
                      _itemCategory = selected!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Category',
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                IntrinsicWidth(
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.restore),
                          label: const Text('Reset'),
                          onPressed: _resetItem,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('Add Item'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          onPressed: _saveItem,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
