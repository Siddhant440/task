import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task/views/services/provider/user_provider.dart';
import '../widgets/custom_appbar.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  Future<void> logout(BuildContext context) async {
    try {

      await FirebaseAuth.instance.signOut();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Successfully logged out."),
          backgroundColor: Colors.blueAccent,
        ),
      );

      context.go('/');

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("An error occurred while logging out."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final email = ref.watch(userEmailProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        title2: '',
        showBackButton: true,
        trailing: IconButton(
          onPressed: () {
            logout(context);
          },
          icon: const Icon(Icons.logout, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Logged in as: $email',
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}