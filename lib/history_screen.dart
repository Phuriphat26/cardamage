import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ประวัติการตรวจสอบ')),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => ListTile(
          leading: const Icon(Icons.car_crash),
          title: Text('รายการที่ ${index + 1}'),
          subtitle: const Text('ตรวจเมื่อ: 26 ก.พ. 2026'),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}