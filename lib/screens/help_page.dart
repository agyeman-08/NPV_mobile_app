import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help and Feedback'),
      ),
      body: const Center(
        child: Text(
          'Help and Feedback Page Content',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
