import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemListJsonProvider =
    StateNotifierProvider<ItemListJsonNotifier, List<Map<String, dynamic>>>(
  (ref) => ItemListJsonNotifier(),
);

class ItemListJsonNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  ItemListJsonNotifier() : super([]);

  void update(List<Map<String, dynamic>> data) {
    state = data;
  }
}
