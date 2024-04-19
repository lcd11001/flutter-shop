import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shopping/providers/grocery_item_provider.dart';
import 'package:shopping/screens/new_item_screen.dart';

import 'package:shopping/widgets/grocery_list.dart';

class GroceryScreen extends ConsumerWidget {
  const GroceryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groceryItems = ref.watch(groceryItemProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          Semantics(
            label: 'Add new item',
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _openNewItemScreen(context, ref),
            ),
          ),
        ],
      ),
      body: GroceryList(
        groceries: groceryItems,
      ),
    );
  }

  _openNewItemScreen(BuildContext context, WidgetRef ref) async {
    final newItem = await Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => const NewItemScreen(),
    ));

    if (newItem != null) {
      // Add the new item to the list
      // groceryItems.add(newItem);
      debugPrint('Adding new item: $newItem');
      ref.read(groceryItemProvider.notifier).add(newItem);
    }
  }
}
