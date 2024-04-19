import 'package:flutter/material.dart';

import 'package:shopping/widgets/grocery_list.dart';

import 'package:shopping/data/dummy_items.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
      ),
      body: GroceryList(
        groceries: groceryItems,
      ),
    );
  }
}
