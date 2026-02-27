import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF1B3E6D);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("ข้อมูลส่วนตัว"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Center(
              child: Stack(
                children: [
                  CircleAvatar(radius: 60, backgroundColor: primaryColor, child: Icon(Icons.person, size: 60, color: Colors.white)),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(radius: 18, backgroundColor: Colors.white, child: Icon(Icons.camera_alt, size: 18, color: primaryColor)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildTextField("ชื่อ-นามสกุล", "กันตพงศ์"),
            const SizedBox(height: 16),
            _buildTextField("อีเมล", "user@example.com"),
            const SizedBox(height: 16),
            _buildTextField("เบอร์โทรศัพท์", "081-234-5678"),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: const Text("บันทึกข้อมูล", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}