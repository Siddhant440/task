import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task/views/home_screen.dart';
import 'package:task/views/item_detail_screen.dart';
import 'package:task/views/login_screen.dart';
import 'package:task/views/profile_screen.dart';
import 'package:task/views/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    runApp(ProviderScope(child: MyApp()));
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: "/signup",
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: "/home",
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/itemDetail/:itemTitle',
        builder: (context, state) {
          final itemTitle = state.pathParameters['itemTitle'] ?? '';
          return ItemDetailScreen(itemTitle: itemTitle);
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}