import 'package:flutter/material.dart';
import 'models/course.dart';
import 'widgets/course_card.dart';
import 'widgets/header_banner.dart';

class AcademicDashboardScreen extends StatefulWidget {
  const AcademicDashboardScreen({super.key});

  @override
  State<AcademicDashboardScreen> createState() => _AcademicDashboardScreenState();
}

class _AcademicDashboardScreenState extends State<AcademicDashboardScreen> {
  int get _totalSKS => _courses.fold(0, (sum, course) => sum + course.sks);
  final List<Course> _courses = Course.getSampleCourses();
  bool _isDarkMode = false;

  String _selectedCategory = 'Semua';

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  List<Course> get _filteredCourses {
    if (_selectedCategory == 'Semua') {
      return _courses;
    }
    return _courses.where((course) => course.category == _selectedCategory).toList();
  }

  Widget _buildFilterChips() {
    final categories = ['Semua', 'Teori', 'Praktikum'];
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: categories.map((category) {
        return ChoiceChip(
          label: Text(category),
          selected: _selectedCategory == category,
          onSelected: (selected) {
            if (selected) {
              setState(() {
                _selectedCategory = category;
              });
            }
          },
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _filteredCourses;

    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0284C7),
          brightness: _isDarkMode ? Brightness.dark : Brightness.light,
        ),
        useMaterial3: true,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dashboard Akademik TRPL',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF0284C7),
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
              tooltip: _isDarkMode ? 'Mode Terang' : 'Mode Gelap',
              onPressed: _toggleDarkMode,
            ),
          ],
        ),
        // LayoutBuilder membaca ukuran layar untuk menentukan tata letak responsif
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Breakpoint 600dp: Tablet / Landscape (2 Kolom)
            if (constraints.maxWidth >= 600) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Kolom Kiri: Banner profil
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        child: HeaderBanner(totalSks: _totalSKS,),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Kolom Kanan: Filter + Grid Mata Kuliah
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFilterChips(),
                          const SizedBox(height: 12),
                          Text(
                            'Mata Kuliah Semester 5 (${filteredList.length} Terdaftar)',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 340,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                mainAxisExtent: 240,
                              ),
                              itemCount: filteredList.length,
                              itemBuilder: (context, index) {
                                return CourseCard(course: filteredList[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            // Layout Default: Smartphone (1 Kolom Vertikal)
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                HeaderBanner(totalSks: _totalSKS,),
                const SizedBox(height: 16),
                _buildFilterChips(), // Menampilkan baris ChoiceChip filter
                const SizedBox(height: 12),
                Text(
                  'Mata Kuliah Semester 5 (${filteredList.length} Terdaftar)',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...filteredList.map((course) => CourseCard(course: course)),
              ],
            );
          },
        ),
      ),
    );
  }
}