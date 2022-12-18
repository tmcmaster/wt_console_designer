import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemListJsonProvider =
    StateNotifierProvider<ItemListJsonNotifier, List<Map<String, dynamic>>>(
  (ref) => ItemListJsonNotifier(),
);

class ItemListJsonNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  ItemListJsonNotifier()
      : super([
          {
            "id": "001",
            "type": 1,
            "point": {"x": 89.76171875, "y": 125.1953125},
            "size": {"width": 100.0, "height": 100.0},
            "color": 4294961979,
            "selected": false
          },
          {
            "id": "002",
            "type": 1,
            "point": {"x": 251.2578125, "y": 17.9375},
            "size": {"width": 100.0, "height": 100.0},
            "color": 4294961979,
            "selected": true
          },
        ]);

  void update(List<Map<String, dynamic>> data) {
    state = data;
  }
}
