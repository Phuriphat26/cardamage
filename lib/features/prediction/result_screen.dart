import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ผลการตรวจสอบ')),
      body: const Center(
        child: Text('โชว์รายการความเสียหายที่นี่ (เช่น กันชนบุบ 80%)'),
      ),
    );
  }
}