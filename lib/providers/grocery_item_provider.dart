import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/dummy_items.dart';
import 'package:shopping/models/grocery_item.dart';

class GroceryItemProvider extends StateNotifier<List<GroceryItem>> {
  GroceryItemProvider() : super(groceryItems);

  void add(GroceryItem item) {
    state = [...state, item];
  }

  void remove(GroceryItem item) {
    state = state.where((element) => element.id != item.id).toList();
  }
}

final groceryItemProvider =
    StateNotifierProvider<GroceryItemProvider, List<GroceryItem>>((ref) {
  return GroceryItemProvider();
});
