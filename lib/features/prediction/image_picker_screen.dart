import 'package:flutter/material.dart';

class ImagePickerScreen extends StatelessWidget {
  final String source; // เพิ่มตัวแปรนี้

  const ImagePickerScreen({
    super.key,
    required this.source, // เพิ่ม parameter นี้
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Predict from $source"),
      ),
      body: Center(
        child: Text(
          "เลือกจาก $source",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}