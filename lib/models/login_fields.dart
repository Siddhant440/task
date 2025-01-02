import 'package:flutter/material.dart';

final List<Map<String, dynamic>> fields = [
  {
    'controller': TextEditingController(),
    'label': 'Email',
    'hintText': 'Enter your email',
    'obscureText': false,
    'keyboard': TextInputType.emailAddress,
    'validate': (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your email';
      }
      if (!value.contains('@')) {
        return 'Enter a valid email';
      }
      return null;
    }
  },
  {
    'controller': TextEditingController(),
    'label': 'Password',
    'hintText': 'Enter your password',
    'obscureText': true,
    'keyboard': TextInputType.text,
    'validate': (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your password';
      }
      return null;
    }
  },
];
