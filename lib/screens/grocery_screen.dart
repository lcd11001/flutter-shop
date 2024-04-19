import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping/screens/new_item_screen.dart';

import 'package:shopping/widgets/grocery_list.dart';

import 'package:shopping/data/dummy_items.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          Semantics(
            label: 'Add new item',
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _openNewItemScreen(context),
            ),
          ),
        ],
      ),
      body: GroceryList(
        groceries: groceryItems,
      ),
    );
  }

  _openNewItemScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => const NewItemScreen(),
    ));
  }
}
