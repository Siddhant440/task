import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/item_model.dart';

final itemProvider = StateNotifierProvider<ItemNotifier, List<Item>>(
  (ref) => ItemNotifier(),
);

class ItemNotifier extends StateNotifier<List<Item>> {
  ItemNotifier() : super([]) {
    preloadItems();
  }

  final _firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  Future<void> preloadItems() async {
    final snapshot = await _firestore.collection('items').get();

    if (snapshot.docs.isEmpty) {
      final items = [
        {'title': 'Item 1'},
        {'title': 'Item 2'},
        {'title': 'Item 3'},
        {'title': 'Item 4'},
        {'title': 'Item 5'},
        {'title': 'Item 6'},
        {'title': 'Item 7'},
        {'title': 'Item 8'},
        {'title': 'Item 9'},
        {'title': 'Item 10'},
      ];

      for (final item in items) {
        await _firestore.collection('items').add({
          ...item,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    }

    await fetchItems();
  }

  Future<void> fetchItems() async {
    isLoading = true;
    state = [];
    final snapshot = await _firestore
        .collection('items')
        .orderBy('timestamp', descending: true)
        .get();

    state = snapshot.docs.map((doc) {
      final data = doc.data();
      return Item(title: data['title']);
    }).toList();
    isLoading = false;
  }

  Future<void> addItem(String title) async {
    final item = {
      'title': title,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await _firestore.collection('items').add(item);

    state = [Item(title: title), ...state];
  }

  Future<void> removeItem(String title) async {
    final snapshot = await _firestore
        .collection('items')
        .where('title', isEqualTo: title)
        .get();

    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }

    fetchItems();
  }
}
