import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ใช้สีพื้นหลังเทาอ่อนเพื่อให้ Card สีขาวดูเด่นขึ้น
    final backgroundColor = Colors.grey[100];
    const primaryColor = Color(0xFF1B3E6D); // สีน้ำเงินเข้มตามธีม

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Setting',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: primaryColor),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildSectionTitle('ข้อมูลผู้ใช้'),
          _buildSettingsGroup([
            _buildListTile(Icons.person_outline, 'ข้อมูลส่วนตัว', onTap: () {}),
            _buildListTile(Icons.lock_outline, 'เปลี่ยนรหัสผ่าน', onTap: () {}),
          ]),

          _buildSectionTitle('การแจ้งเตือน'),
          _buildSettingsGroup([
            _buildListTile(
              Icons.notifications_none, 
              'การแจ้งเตือน', 
              trailing: Switch(
                value: false, 
                onChanged: (val) {},
                activeColor: primaryColor,
              ),
            ),
          ]),

          _buildSectionTitle('การตั้งค่าทั่วไป'),
          _buildSettingsGroup([
            _buildListTile(Icons.language, 'ภาษา', trailingText: 'ไทย', onTap: () {}),
            _buildListTile(
              Icons.wb_sunny_outlined, 
              'โหมดมืด', 
              trailing: Switch(
                value: false, 
                onChanged: (val) {},
                activeColor: primaryColor,
              ),
            ),
          ]),

          _buildSectionTitle('อื่นๆ'),
          _buildSettingsGroup([
            _buildListTile(Icons.help_outline, 'ช่วยเหลือและสนับสนุน', onTap: () {}),
            _buildListTile(
              Icons.logout, 
              'ออกจากระบบ', 
              textColor: Colors.red, 
              iconColor: Colors.red,
              showChevron: false,
              onTap: () {},
            ),
          ]),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // ส่วนหัวข้อกลุ่ม
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 20, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // ส่วนรวมรายการให้อยู่ใน Card สีขาวใบเดียวกัน
  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: List.generate(children.length, (index) {
          if (index == children.length - 1) return children[index];
          return Column(
            children: [
              children[index],
              const Divider(height: 1, indent: 50, endIndent: 10, color: Color(0xFFEEEEEE)),
            ],
          );
        }),
      ),
    );
  }

  // รายการแต่ละบรรทัด
  Widget _buildListTile(
    IconData icon, 
    String title, {
    VoidCallback? onTap,
    Widget? trailing,
    String? trailingText,
    Color textColor = Colors.black87,
    Color iconColor = const Color(0xFF1B3E6D),
    bool showChevron = true,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w500, fontSize: 15),
      ),
      trailing: trailing ?? Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(trailingText, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          if (showChevron)
            const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
      onTap: onTap,
    );
  }
}