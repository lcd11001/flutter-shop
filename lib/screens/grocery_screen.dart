import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/models/grocery_item.dart';

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
        onDismissed: (item) {
          _removeItem(ref, item);
          _showSnackBar(context, ref, item);
        },
      ),
    );
  }

  _openNewItemScreen(BuildContext context, WidgetRef ref) async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItemScreen(),
      ),
    );

    if (newItem != null) {
      // Add the new item to the list
      debugPrint('Adding new item: $newItem');
      final success = await ref.read(groceryItemProvider.notifier).add(newItem);

      if (!success) {
        if (context.mounted) {
          _showErrorSnackBar(context, 'Failed to add item to the list');
        }
      }
    }
  }

  void _removeItem(WidgetRef ref, GroceryItem item) {
    debugPrint('Removing item: $item');
    ref.read(groceryItemProvider.notifier).remove(item);
  }

  void _showSnackBar(BuildContext context, WidgetRef ref, GroceryItem item) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} removed from the list'),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () async {
            final success =
                await ref.read(groceryItemProvider.notifier).add(item);
            if (!success) {
              if (context.mounted) {
                _showErrorSnackBar(context, 'Failed to UNDO');
              }
            }
          },
        ),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
