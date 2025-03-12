import 'package:flutter/material.dart';

class ReminderScreen extends StatelessWidget {
  final String title;
  const ReminderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengingat Minum'),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Text(
          'halaman untuk $title',
        ),
      ),
    );
  }
}