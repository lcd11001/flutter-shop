import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shopping/api/api.dart';
import 'package:shopping/data/dummy_items.dart';
import 'package:shopping/models/grocery_item.dart';

class GroceryItemProvider extends StateNotifier<AsyncValue<List<GroceryItem>>> {
  GroceryItemProvider() : super(const AsyncData([])) {
    _init();
  }

  Future<void> _init() async {
    state = const AsyncLoading();
    final items = await AsyncValue.guard(() => API.fetchGroceryItems());
    if (mounted) {
      state = items;
    }
  }

  Future<bool> add(GroceryItem item) async {
    final items = state.value!;
    state = const AsyncLoading();
    final newItem = await AsyncValue.guard(() => API.addGroceryItem(item));

    if (mounted && newItem.value != null) {
      // update new state
      state = AsyncValue.data([...items, newItem.value!]);
      return true;
    }

    return false;
  }

  void remove(GroceryItem item) {
    // state = state.where((element) => element.id != item.id).toList();
    final items = state.value ?? [];
    final newItems = items.where((element) => element.id != item.id).toList();
    state = AsyncValue.data(newItems);
  }
}

final groceryItemProvider = StateNotifierProvider.autoDispose<
    GroceryItemProvider, AsyncValue<List<GroceryItem>>>(
  (ref) => GroceryItemProvider(),
);
