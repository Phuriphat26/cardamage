import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("เปลี่ยนรหัสผ่าน"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildPasswordField("รหัสผ่านเดิม"),
            const SizedBox(height: 16),
            _buildPasswordField("รหัสผ่านใหม่"),
            const SizedBox(height: 16),
            _buildPasswordField("ยืนยันรหัสผ่านใหม่"),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1B3E6D), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text("ยืนยันการเปลี่ยน", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label) {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: const Icon(Icons.visibility_off),
      ),
    );
  }
}