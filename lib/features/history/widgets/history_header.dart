import 'package:flutter/material.dart';
import 'filter_dialog.dart';
class HistoryHeader extends StatefulWidget {
  final bool isGrid;
  final VoidCallback onToggleView;
  final VoidCallback onFilterTap;
  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<String>? onSeverityChanged;

  const HistoryHeader({
    super.key,
    required this.isGrid,
    required this.onToggleView,
    required this.onFilterTap,
    this.onSearchChanged,
    this.onSeverityChanged,
  });

  @override
  State<HistoryHeader> createState() => _HistoryHeaderState();
}

class _HistoryHeaderState extends State<HistoryHeader> {
  String _selectedSeverity = 'ทั้งหมด';

  final List<String> _severityOptions = [
    'ทั้งหมด',
    'เสียมาก',
    'เสียบ้านกลาง',
    'เสียน้อย',
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 แถวบน: โปรไฟล์ + ปุ่มควบคุม
          Row(
            children: [
              /// โปรไฟล์
              CircleAvatar(
                radius: 22,
                backgroundColor: colorScheme.onPrimary.withOpacity(0.2),
                child: Icon(
                  Icons.person,
                  color: colorScheme.onPrimary,
                ),
              ),

              const SizedBox(width: 12),

              /// ชื่อผู้ใช้
              Expanded(
                child: Text(
                  "กันตพงศ์",
                  style: TextStyle(
                    color: colorScheme.onPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              /// Toggle View (list/grid)
              IconButton(
                onPressed: widget.onToggleView,
                icon: Icon(
                  widget.isGrid ? Icons.view_list : Icons.grid_view,
                  color: colorScheme.onPrimary,
                ),
              ),

              /// Filter Button (styled like the screenshot)
              /// Filter Button (ปุ่มตัวกรอง)
              GestureDetector(
                onTap: () {
                  // เรียกหน้ากรองข้อมูลขึ้นมา
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true, // เพื่อให้เลื่อนขึ้นมาได้สูงตามเนื้อหา
                    backgroundColor: Colors.transparent, // เพื่อให้เห็นขอบโค้งของ FilterDialog
                    builder: (context) => Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom, // ดันขึ้นหนีคีย์บอร์ด
                      ),
                      child: const FilterDialog(), // เรียกไฟล์ที่คุณพึ่งสร้าง
                    ),
                  );
                  
                  // เรียก Callback เดิมที่ส่งมาจากข้างนอกด้วย (ถ้ามี)
                  widget.onFilterTap();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: colorScheme.onPrimary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: colorScheme.onPrimary.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.tune,
                        color: colorScheme.onPrimary,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "ตัวกรอง",
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// 🔹 Search Bar
          Container(
            height: 44,
            decoration: BoxDecoration(
              color: colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(22),
            ),
            child: TextField(
              onChanged: widget.onSearchChanged,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: "ค้นหาตัวรถยี่ห้อ, รุ่น, ทะเบียน หรือสถานที่...",
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 13,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade400,
                  size: 20,
                ),
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// 🔹 Severity Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _severityOptions.map((option) {
                final isSelected = _selectedSeverity == option;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _selectedSeverity = option);
                      widget.onSeverityChanged?.call(option);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colorScheme.onPrimary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? colorScheme.onPrimary
                              : colorScheme.onPrimary.withOpacity(0.4),
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        option,
                        style: TextStyle(
                          color: isSelected
                              ? colorScheme.primary
                              : colorScheme.onPrimary,
                          fontSize: 13,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}