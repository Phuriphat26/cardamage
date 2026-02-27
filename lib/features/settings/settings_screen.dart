import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'change_password_screen.dart';
import 'help_support_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isNotificationOn = false;
  String _currentLanguage = 'ไทย'; // สถานะจำลองสำหรับแสดงชื่อภาษา

  // ฟังก์ชันแสดงรายการเลือกภาษา
  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'เลือกภาษา',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.language, color: Colors.blue),
                title: const Text('ไทย'),
                trailing: _currentLanguage == 'ไทย' ? const Icon(Icons.check, color: Colors.green) : null,
                onTap: () {
                  setState(() => _currentLanguage = 'ไทย');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.language, color: Colors.orange),
                title: const Text('English'),
                trailing: _currentLanguage == 'English' ? const Icon(Icons.check, color: Colors.green) : null,
                onTap: () {
                  setState(() => _currentLanguage = 'English');
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Colors.grey[100];
    const primaryColor = Color(0xFF1B3E6D);

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
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildSectionTitle('ข้อมูลผู้ใช้'),
          _buildSettingsGroup([
            _buildListTile(Icons.person_outline, 'ข้อมูลส่วนตัว', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen()));
            }),
            _buildListTile(Icons.lock_outline, 'เปลี่ยนรหัสผ่าน', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
            }),
          ]),

          _buildSectionTitle('การแจ้งเตือน'),
          _buildSettingsGroup([
            _buildListTile(
              Icons.notifications_none, 
              'การแจ้งเตือน', 
              trailing: Switch(
                value: _isNotificationOn, 
                onChanged: (val) => setState(() => _isNotificationOn = val),
                activeColor: primaryColor,
              ),
            ),
          ]),

          _buildSectionTitle('การตั้งค่าทั่วไป'),
          _buildSettingsGroup([
            // ปรับส่วนนี้ให้เรียกฟังก์ชันเลือกภาษา
            _buildListTile(
              Icons.language, 
              'ภาษา', 
              trailingText: _currentLanguage, 
              onTap: _showLanguagePicker,
            ),
          ]),

          _buildSectionTitle('อื่นๆ'),
          _buildSettingsGroup([
            _buildListTile(Icons.help_outline, 'ช่วยเหลือและสนับสนุน', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpSupportScreen()));
            }),
            _buildListTile(
              Icons.logout, 
              'ออกจากระบบ', 
              textColor: Colors.red, 
              iconColor: Colors.red,
              showChevron: false,
              onTap: () {
                // ตัวอย่าง Dialog เมื่อกดออกจากระบบ
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('ออกจากระบบ'),
                    content: const Text('คุณต้องการออกจากระบบใช่หรือไม่?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('ยกเลิก')),
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('ยืนยัน', style: TextStyle(color: Colors.red))),
                    ],
                  ),
                );
              },
            ),
          ]),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

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