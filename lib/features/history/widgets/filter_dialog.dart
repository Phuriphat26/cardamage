import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  String selectedLocation = 'กรุงเทพ';
  final List<String> locations = ['กรุงเทพ', 'เชียงใหม่', 'จันทบุรี', 'ระยอง'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'กรองข้อมูล',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.grey),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 16),
          
          _buildDateField('วันที่เริ่มต้น', 'mm/dd/yyyy'),
          _buildDateField('วันที่สิ้นสุด', 'mm/dd/yyyy'),
          _buildTimeField('เวลาเริ่มต้น', '--:-- --'),
          _buildTimeField('เวลาสิ้นสุด', '--:-- --'),
          
          const SizedBox(height: 16),
          const Text('สถานที่', style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: 'ระบุสถานที่',
              prefixIcon: const Icon(Icons.location_on_outlined),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
          
          const SizedBox(height: 16),
          const Text('ตัวอย่างสถานที่ :', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: locations.map((loc) {
              final isSelected = selectedLocation == loc;
              return ChoiceChip(
                label: Text(loc),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() => selectedLocation = loc);
                },
                selectedColor: Colors.blue.shade100,
                backgroundColor: Colors.grey.shade100,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.blue.shade700 : Colors.black54,
                ),
                side: BorderSide.none,
                shape: StadiumBorder(),
              );
            }).toList(),
          ),
          
          const SizedBox(height: 32),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('ล้างทั้งหมด', style: TextStyle(color: Colors.grey)),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade500,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('ยกเลิก'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.filter_alt_outlined),
                label: const Text('ใช้ตัวกรอง'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A3E6D), // สีน้ำเงินเข้มตามรูป
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [const Icon(Icons.calendar_today, size: 16), const SizedBox(width: 8), Text(label)]),
          const SizedBox(height: 4),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: hint,
              suffixIcon: const Icon(Icons.calendar_month_outlined),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeField(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [const Icon(Icons.access_time, size: 16), const SizedBox(width: 8), Text(label)]),
          const SizedBox(height: 4),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              hintText: hint,
              suffixIcon: const Icon(Icons.access_time),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }
}