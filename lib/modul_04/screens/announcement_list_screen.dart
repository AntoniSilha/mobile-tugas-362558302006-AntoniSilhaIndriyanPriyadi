
import 'package:flutter/material.dart';
import '../models/announcement.dart';
import '../services/announcement_api.dart';
import 'announcement_detail_screen.dart';

class AnnouncementListScreen extends StatefulWidget {
  const AnnouncementListScreen({super.key, this.api});

  // Dapat disuntikkan dari luar (widget test atau demo offline).
  final AnnouncementApi? api;

  @override
  State<AnnouncementListScreen> createState() =>
      _AnnouncementListScreenState();
}

class _AnnouncementListScreenState extends State<AnnouncementListScreen> {
  static const List<String> _kategori = <String>[
    'Semua',
    'Akademik',
    'Beasiswa',
    'Kegiatan',
    'Prestasi',
  ];

  late final AnnouncementApi _api = widget.api ?? AnnouncementApi();

  late Future<List<Announcement>> _futurePengumuman;

  String _kategoriTerpilih = 'Semua';

  @override
  void initState() {
    super.initState();
    _futurePengumuman = _api.ambilPengumuman();
  }

  @override
  void dispose() {
    _api.tutup();
    super.dispose();
  }

  // Memuat ulang data pengumuman
  Future<void> _muatUlang() async {
    final Future<List<Announcement>> futureBaru =
    _api.ambilPengumuman();

    setState(() {
      _futurePengumuman = futureBaru;
    });

    try {
      await futureBaru;
    } catch (_) {
      // Error ditangani oleh FutureBuilder melalui snapshot.hasError.
      // Catch ini memastikan RefreshIndicator berhenti berputar.
    }
  }

  // Memilih kategori pengumuman
  void _pilihKategori(String kategori) {
    if (kategori == _kategoriTerpilih) return;

    setState(() {
      _kategoriTerpilih = kategori;
    });
  }

  // Membuka halaman detail pengumuman
  void _bukaDetail(Announcement announcement) {
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (_) => AnnouncementDetailScreen(
          announcement: announcement,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portal Pengumuman TRPL'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Segarkan Data',
            onPressed: _muatUlang,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          _buildBarisFilter(),
          const Divider(height: 1),
          Expanded(
            child: FutureBuilder<List<Announcement>>(
              future: _futurePengumuman,
              builder: (context, snapshot) {
                // Keadaan 1: Loading
                if (snapshot.connectionState != ConnectionState.done) {
                  return _buildMemuat();
                }

                // Keadaan 2: Error
                if (snapshot.hasError) {
                  return _buildGagal(snapshot.error!);
                }

                // Keadaan 3 dan 4: Kosong / Berhasil
                final List<Announcement> semua =
                    snapshot.data ?? const <Announcement>[];

                final List<Announcement> tampil =
                _kategoriTerpilih == 'Semua'
                    ? semua
                    : semua
                    .where(
                      (Announcement item) =>
                  item.category.toLowerCase() ==
                      _kategoriTerpilih.toLowerCase(),
                )
                    .toList(growable: false);

                if (tampil.isEmpty) {
                  return _buildKosong();
                }

                return _buildDaftar(tampil);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget filter kategori
  Widget _buildBarisFilter() {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _kategori.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final String kategori = _kategori[index];
          final bool terpilih = kategori == _kategoriTerpilih;

          return ChoiceChip(
            label: Text(kategori),
            selected: terpilih,
            onSelected: (_) => _pilihKategori(kategori),
          );
        },
      ),
    );
  }

  // Tampilan loading
  Widget _buildMemuat() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  // Tampilan ketika gagal memuat data
  Widget _buildGagal(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'Gagal Memuat Data',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _muatUlang,
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
            ),
          ],
        ),
      ),
    );
  }

  // Tampilan ketika tidak ada pengumuman
  Widget _buildKosong() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Tidak Ada Pengumuman',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Belum ada pengumuman untuk kategori ini.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Daftar pengumuman
  Widget _buildDaftar(List<Announcement> announcements) {
    return RefreshIndicator(
      onRefresh: _muatUlang,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: announcements.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final Announcement announcement = announcements[index];

          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                announcement.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(announcement.category),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _bukaDetail(announcement),
            ),
          );
        },
      ),
    );
  }
}
