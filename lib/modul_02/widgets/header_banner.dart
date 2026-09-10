import 'package:flutter/material.dart';

// Banner header profil mahasiswa di bagian atas dashboard
class HeaderBanner extends StatelessWidget {
  final String studentName;
  final String nim;
  final int totalSks;

  const HeaderBanner({
    super.key,
    this.studentName = 'Antoni Silha Indriyan Priyadi',
    this.nim = '362558302006',
    this.totalSks = 0,
  });

  @override
  Widget build(BuildContext context) {
    final bool isExceeded = totalSks > 24;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0284C7), Color(0xFF0369A1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0284C7).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Semester 5 (2026/2027)',
                  style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ),
              const Icon(Icons.notifications_active_outlined, color: Colors.white, size: 20),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Selamat Datang, $studentName ($nim)',
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
          const SizedBox(height: 4),
          const Text(
            'Dashboard Akademik & Proyek',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Wrap mencegah overflow pada layar sempit atau font besar.
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              const _StatPill(icon: Icons.task_alt, label: '4 Matakuliah'),
              _StatPill(icon: Icons.bookmark_add_outlined, label: '$totalSks SKS Diambil'),
              const _StatPill(icon: Icons.grade, label: 'IPK 3.85'),
              const _StatPill(icon: Icons.calendar_month, label: '100% Hadir'),
            ],
          ),
          if (isExceeded) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade700,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.shade300, width: 1),
              ),
              child: const Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.white, size: 22),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Peringatan: Total SKS melebihi batas maksimal 24 SKS per semester!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// Widget kecil untuk menampilkan pill status (ikon + label)
class _StatPill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _StatPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}