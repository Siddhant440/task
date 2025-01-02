import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/views/services/provider/item_provider.dart';
import 'package:task/widgets/custom_appbar.dart';
import 'package:task/widgets/custom_button.dart';
import 'package:task/widgets/item_card.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _titleController = TextEditingController();
  bool _isContainerVisible = false;
  String? _deletingItem;

  @override
  Widget build(BuildContext context) {
    final items = ref.watch(itemProvider);
    final isLoading = ref.watch(itemProvider.notifier).isLoading;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Home',
        title2: '',
        showBackButton: false,
        trailing: IconButton(
          icon: const Icon(Icons.person, color: Colors.white),
          onPressed: () {
            context.push('/profile');
          },
        ),
      ),
      body: Stack(
        children: [
          if (items.isNotEmpty)
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];

                        return ItemCard(
                          title: item.title,
                          onDelete: () async {
                            setState(() {
                              _deletingItem = item.title;
                            });

                            await ref
                                .read(itemProvider.notifier)
                                .removeItem(item.title);

                            setState(() {
                              _deletingItem = null;
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          if (items.isEmpty && !isLoading)
            const Center(
              child: Text(
                "No items available",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          if (_isContainerVisible)
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isContainerVisible = false;
                    });
                  },
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: _titleController,
                          maxLength: 20,
                          decoration: const InputDecoration(
                            labelText: "Item Title",
                            labelStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomButton(
                          onPressed: () {
                            if (_titleController.text.trim().isNotEmpty) {
                              ref.read(itemProvider.notifier).addItem(
                                    _titleController.text.trim(),
                                  );
                              setState(() {
                                _isContainerVisible = false;
                              });
                              _titleController.clear();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please enter an item title."),
                                ),
                              );
                            }
                          },
                          title: 'Add Item',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          if (!_isContainerVisible)
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 40.0, bottom: 60),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _isContainerVisible = !_isContainerVisible;
                    });
                  },
                  child: Container(
                    height: 56,
                    width: 56,
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ),
            ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
