import 'package:flutter/material.dart';
import 'package:shopping/models/grocery_item.dart';
import 'package:shopping/widgets/grocery_list_item.dart';

class GroceryList extends StatelessWidget {
  final List<GroceryItem> groceries;
  final void Function(GroceryItem) onDismissed;

  const GroceryList({
    super.key,
    required this.groceries,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    if (groceries.isEmpty) {
      return const Center(
        child: Text('No groceries added yet!'),
      );
    }

    return ListView.builder(
      itemCount: groceries.length,
      itemBuilder: (context, index) {
        return GroceryListItem(
          grocery: groceries[index],
          onDismissed: onDismissed,
        );
      },
    );
  }
}
