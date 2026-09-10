// Model data untuk mata kuliah
class Course {
  final String code;
  final String name;
  final String lecturer;
  final int sks;
  final double progress; // progres silabus (0.0 - 1.0)
  final String room;
  final String category;

  const Course({
    required this.code,
    required this.name,
    required this.lecturer,
    required this.sks,
    required this.progress,
    this.category = 'Teori',
    this.room = 'Lab Komputer 3'
  });

  // Data dummy untuk bahan praktikum & testing
  static List<Course> getSampleCourses() {
    return const [
      Course(
        code: 'TRPL501',
        name: 'Pemrograman Perangkat Bergerak',
        lecturer: 'Sepyan Purnama Kristanto',
        sks: 4,
        progress: 0.25,
        room: 'Lab TUK',
        category: 'Praktikum',
      ),
      Course(
        code: 'TRPL502',
        name: 'Pemrograman Web Lanjut',
        lecturer: 'Devit Suwardiyanto,S.Si., M.T.',
        sks: 4,
        progress: 0.30,
        room: 'Ruang Multimedia',
        category: 'Praktikum',
      ),
      Course(
        code: 'TRPL503',
        name: 'Basis Data Lanjut',
        lecturer: 'Eka Mistiko Rini, S.Kom, M.Kom.',
        sks: 4,
        progress: 0.40,
        room: 'LAB.PROGRAM 2',
        category: 'Praktikum',
      ),
      Course(
        code: 'TRPL504',
        name: 'Rekayasa Kebutuhan Perangkat Lunak',
        lecturer: 'Eka Novita Sari, S. Kom., M.Kom.',
        sks: 2,
        progress: 0.20,
        room: 'G7.10',
        category: 'Teori',
      ),
      Course(
        code: 'TRPL505',
        name: 'Interoperabilitas',
        lecturer: 'Ahmad Ripaldi, S.Kom.',
        sks: 4,
        progress: 0.15,
        room: 'Lab Jaringan',
        category: 'Praktikum',
      ),
      Course(
        code: 'TRPL506',
        name: 'DummySKS',
        lecturer: 'LoremIpsum',
        sks: 26,
        progress: 0.15,
        room: 'G1.01',
        category: 'Teori',
      ),
    ];
  }
}
