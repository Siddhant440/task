import 'package:flutter/material.dart';
import '../widgets/custom_appbar.dart';

class ItemDetailScreen extends StatelessWidget {
  final String itemTitle;

  const ItemDetailScreen({super.key, required this.itemTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: itemTitle, title2: '', showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              itemTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text('Details about $itemTitle go here.'),
          ],
        ),
      ),
    );
  }
}
