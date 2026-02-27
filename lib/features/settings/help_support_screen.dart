import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ช่วยเหลือและสนับสนุน")),
      body: ListView(
        children: [
          _buildHelpItem(Icons.help_outline, "ศูนย์ช่วยเหลือ", "อ่านบทความแนะนำการใช้งาน"),
          _buildHelpItem(Icons.chat_bubble_outline, "แชทกับเจ้าหน้าที่", "ติดต่อเราได้ตลอด 24 ชม."),
          _buildHelpItem(Icons.mail_outline, "ส่งอีเมลหาเรา", "support@cardamage.com"),
          _buildHelpItem(Icons.description_outlined, "ข้อกำหนดและนโยบาย", "ข้อมูลทางกฎหมายต่าง ๆ"),
        ],
      ),
    );
  }

  Widget _buildHelpItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF1B3E6D)),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}