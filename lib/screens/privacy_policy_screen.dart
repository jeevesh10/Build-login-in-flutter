// screens/privacy_policy_screen.dart
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Privacy Policy')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'This is the privacy policy page. Your data is safe with us.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
