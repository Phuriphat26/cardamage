import 'package:flutter/material.dart';
import './widgets/history_header.dart';

// ── Mock Data Model ──────────────────────────────────────────────────────────
class DamageItem {
  final String type;
  final String location;
  final double confidence;
  final String severity; // 'major' | 'moderate' | 'minor'

  const DamageItem({
    required this.type,
    required this.location,
    required this.confidence,
    required this.severity,
  });
}

class CarHistoryItem {
  final String carModel;
  final String licensePlate;
  final String date;
  final String location;
  final int damageCount;
  final String? imageUrl;
  final List<DamageItem> damages;

  const CarHistoryItem({
    required this.carModel,
    required this.licensePlate,
    required this.date,
    required this.location,
    required this.damageCount,
    this.imageUrl,
    this.damages = const [],
  });
}

final _mockItems = [
  const CarHistoryItem(
    carModel: 'Toyota Camry 2020',
    licensePlate: 'ABC-1234',
    date: '3/6/2568',
    location: 'Bangkok',
    damageCount: 6,
    damages: [
      DamageItem(type: 'รอยบุบ', location: 'ประตูข้างหน้า', confidence: 0.95, severity: 'major'),
      DamageItem(type: 'รอยบุบ', location: 'ประตูข้างหลัง', confidence: 0.87, severity: 'moderate'),
      DamageItem(type: 'รอยขีดข่วน', location: 'ฝากระโปรงหน้า', confidence: 0.78, severity: 'minor'),
      DamageItem(type: 'กระจกแตก', location: 'กระจกหน้า', confidence: 0.92, severity: 'major'),
      DamageItem(type: 'รอยบุบ', location: 'กันชนหน้า', confidence: 0.85, severity: 'moderate'),
      DamageItem(type: 'รอยขีดข่วน', location: 'ประตูข้างหน้า', confidence: 0.70, severity: 'minor'),
    ],
  ),
  const CarHistoryItem(
    carModel: 'Honda Civic 2019',
    licensePlate: 'XYZ-5678',
    date: '2/6/2568',
    location: 'Rayong',
    damageCount: 2,
    damages: [
      DamageItem(type: 'รอยบุบ', location: 'ประตูข้างหลัง', confidence: 0.88, severity: 'moderate'),
      DamageItem(type: 'รอยขีดข่วน', location: 'กันชนหลัง', confidence: 0.72, severity: 'minor'),
    ],
  ),
  const CarHistoryItem(
    carModel: 'Toyota Camry 2020',
    licensePlate: 'ABC-1234',
    date: '3/6/2568',
    location: 'Bangkok',
    damageCount: 3,
    damages: [
      DamageItem(type: 'รอยบุบ', location: 'กันชนหน้า', confidence: 0.91, severity: 'major'),
      DamageItem(type: 'รอยขีดข่วน', location: 'ประตูข้างหน้า', confidence: 0.80, severity: 'moderate'),
      DamageItem(type: 'รอยบุบ', location: 'ล้อซ้าย', confidence: 0.65, severity: 'minor'),
    ],
  ),
  const CarHistoryItem(
    carModel: 'Toyota Camry 2020',
    licensePlate: 'ABC-1234',
    date: '3/6/2568',
    location: 'Bangkok',
    damageCount: 1,
    damages: [
      DamageItem(type: 'รอยขีดข่วน', location: 'ประตูข้างหลัง', confidence: 0.68, severity: 'minor'),
    ],
  ),
  const CarHistoryItem(
    carModel: 'Honda Jazz 2021',
    licensePlate: 'DEF-9999',
    date: '1/6/2568',
    location: 'Chiang Mai',
    damageCount: 4,
    damages: [
      DamageItem(type: 'รอยบุบ', location: 'ฝากระโปรงหน้า', confidence: 0.93, severity: 'major'),
      DamageItem(type: 'รอยบุบ', location: 'กันชนหน้า', confidence: 0.86, severity: 'major'),
      DamageItem(type: 'รอยขีดข่วน', location: 'กระจกข้างซ้าย', confidence: 0.74, severity: 'moderate'),
      DamageItem(type: 'รอยบุบ', location: 'ประตูข้างหน้า', confidence: 0.69, severity: 'minor'),
    ],
  ),
];

// ── Severity helpers ──────────────────────────────────────────────────────────
Color _severityColor(String severity) {
  switch (severity) {
    case 'major':
      return const Color(0xFFE53935);
    case 'moderate':
      return const Color(0xFFFB8C00);
    default:
      return const Color(0xFF43A047);
  }
}

String _severityLabel(String severity) {
  switch (severity) {
    case 'major':
      return 'major';
    case 'moderate':
      return 'moderate';
    default:
      return 'minor';
  }
}

// ── Damage Badge ──────────────────────────────────────────────────────────────
class _DamageBadge extends StatelessWidget {
  final int count;
  const _DamageBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red.shade600,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$count ความเสียหาย',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ── Detail Modal ──────────────────────────────────────────────────────────────
void _showDetailModal(BuildContext context, CarHistoryItem item) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _DetailModal(item: item),
  );
}

class _DetailModal extends StatefulWidget {
  final CarHistoryItem item;
  const _DetailModal({required this.item});

  @override
  State<_DetailModal> createState() => _DetailModalState();
}

class _DetailModalState extends State<_DetailModal> {
  final int _currentImage = 0;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    return DraggableScrollableSheet(
      initialChildSize: 0.82,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Drag handle
            const SizedBox(height: 10),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 4),

            // Title bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  const Text(
                    'รายละเอียดการตรวจจับ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.close, size: 16),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                children: [
                  // Car image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: SizedBox(
                      height: 190,
                      width: double.infinity,
                      child: item.imageUrl != null
                          ? Image.network(item.imageUrl!, fit: BoxFit.cover)
                          : Container(
                              color: const Color(0xFFDDE3F0),
                              child: const Center(
                                child: Icon(Icons.directions_car,
                                    size: 72, color: Color(0xFF8A99BB)),
                              ),
                            ),
                    ),
                  ),

                  // Dot indicators
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (i) {
                      final active = i == _currentImage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: active ? 16 : 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: active
                              ? const Color(0xFF1A3A8F)
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 20),

                  // Car info
                  Row(
                    children: [
                      const Text(
                        'ข้อมูลรถยนต์',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.edit_outlined,
                          size: 16, color: Colors.grey.shade500),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(item.carModel,
                      style: const TextStyle(
                          fontSize: 13, color: Color(0xFF444466))),
                  const SizedBox(height: 3),
                  Text('ทะเบียน : ${item.licensePlate}',
                      style: TextStyle(
                          fontSize: 13, color: Colors.grey.shade600)),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 13, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Text('${item.location}, Thailand',
                          style: TextStyle(
                              fontSize: 13, color: Colors.grey.shade600)),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Damage section
                  Text(
                    'ความเสียหายที่พบ (${item.damageCount} รายการ)',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...item.damages.map((d) => _DamageRow(damage: d)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DamageRow extends StatelessWidget {
  final DamageItem damage;
  const _DamageRow({required this.damage});

  @override
  Widget build(BuildContext context) {
    final color = _severityColor(damage.severity);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(damage.type,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A2E))),
                const SizedBox(height: 3),
                Text('ตำแหน่ง: ${damage.location}',
                    style: TextStyle(
                        fontSize: 12, color: Colors.grey.shade600)),
                Text(
                    'ความแม่นยำ: ${(damage.confidence * 100).toStringAsFixed(0)}%',
                    style: TextStyle(
                        fontSize: 12, color: Colors.grey.shade600)),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              _severityLabel(damage.severity),
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: color),
            ),
          ),
        ],
      ),
    );
  }
}

// ── List Card (horizontal row) ────────────────────────────────────────────────
class _ListCard extends StatelessWidget {
  final CarHistoryItem item;
  const _ListCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDetailModal(context, item),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Car image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 100,
                height: 80,
                child: item.imageUrl != null
                    ? Image.network(item.imageUrl!, fit: BoxFit.cover)
                    : Container(
                        color: const Color(0xFFDDE3F0),
                        child: const Center(
                          child: Icon(Icons.directions_car,
                              size: 40, color: Color(0xFF8A99BB)),
                        ),
                      ),
              ),
            ),

            const SizedBox(width: 12),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.carModel,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      _DamageBadge(count: item.damageCount),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'ทะเบียน: ${item.licensePlate}',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          size: 12, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Text(item.date,
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600)),
                      const SizedBox(width: 10),
                      Icon(Icons.location_on,
                          size: 12, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(item.location,
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey.shade600)),
                      ),
                      GestureDetector(
                        onTap: () => _showDetailModal(context, item),
                        child: Icon(Icons.remove_red_eye_outlined,
                            size: 18, color: Colors.grey.shade400),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Grid Card ─────────────────────────────────────────────────────────────────
class _GridCard extends StatelessWidget {
  final CarHistoryItem item;
  const _GridCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDetailModal(context, item),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: SizedBox(
                    width: double.infinity,
                    height: 90,
                    child: item.imageUrl != null
                        ? Image.network(item.imageUrl!, fit: BoxFit.cover)
                        : Container(
                            color: const Color(0xFFDDE3F0),
                            child: const Center(
                              child: Icon(Icons.directions_car,
                                  size: 40, color: Color(0xFF8A99BB)),
                            ),
                          ),
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: _DamageBadge(count: item.damageCount),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ชื่อรถ + ไอคอนตา
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          item.carModel,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A2E),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showDetailModal(context, item),
                        child: Icon(Icons.remove_red_eye_outlined,
                            size: 17, color: Colors.grey.shade400),
                      ),
                    ],
                  ),

                  const SizedBox(height: 3),

                  // ทะเบียน
                  Text(
                    item.licensePlate,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),

                  const SizedBox(height: 6),

                  // วันที่
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          size: 12, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Text(item.date,
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600)),
                    ],
                  ),

                  const SizedBox(height: 3),

                  // สถานที่
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 12, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Text(item.location,
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey.shade600)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Main Screen ───────────────────────────────────────────────────────────────
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool isGrid = false;
  String _searchQuery = '';
  String _selectedSeverity = 'ทั้งหมด';

  List<CarHistoryItem> get _filtered {
    return _mockItems.where((item) {
      final matchSearch = _searchQuery.isEmpty ||
          item.carModel.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.licensePlate
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          item.location.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchSeverity = _selectedSeverity == 'ทั้งหมด' ||
          (_selectedSeverity == 'เสียมาก' && item.damageCount >= 5) ||
          (_selectedSeverity == 'เสียบ้านกลาง' &&
              item.damageCount >= 3 &&
              item.damageCount < 5) ||
          (_selectedSeverity == 'เสียน้อย' && item.damageCount < 3);

      return matchSearch && matchSeverity;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),
      body: Column(
        children: [
          HistoryHeader(
            isGrid: isGrid,
            onToggleView: () => setState(() => isGrid = !isGrid),
            onFilterTap: _showFilterModal,
            onSearchChanged: (v) => setState(() => _searchQuery = v),
            onSeverityChanged: (v) => setState(() => _selectedSeverity = v),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: isGrid ? _buildGrid() : _buildList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    final items = _filtered;
    if (items.isEmpty) return _emptyState();
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: items.length,
      itemBuilder: (_, i) => _ListCard(item: items[i]),
    );
  }

  Widget _buildGrid() {
    final items = _filtered;
    if (items.isEmpty) return _emptyState();
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 100),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.82,
      ),
      itemBuilder: (_, i) => _GridCard(item: items[i]),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off, size: 56, color: Colors.grey.shade300),
          const SizedBox(height: 12),
          Text('ไม่พบรายการ',
              style:
                  TextStyle(color: Colors.grey.shade500, fontSize: 15)),
        ],
      ),
    );
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const Padding(
        padding: EdgeInsets.all(24),
        child: Text('Filter Options Here'),
      ),
    );
  }
}