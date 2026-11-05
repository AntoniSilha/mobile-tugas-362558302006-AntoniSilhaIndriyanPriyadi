
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../models/krs_course.dart';

// StateNotifier untuk mengelola daftar KRS mahasiswa
class KrsNotifier extends StateNotifier<List<KrsCourse>> {
  KrsNotifier() : super(KrsCourse.getInitialCourses());

  // Menambahkan mata kuliah ke KRS
  bool tambahMataKuliah(KrsCourse course) {
    // 1. Cek duplikasi kode mata kuliah
    final exists = state.any(
          (c) => c.code.toUpperCase() == course.code.toUpperCase(),
    );

    if (exists) return false;

    // 2. Cek batas maksimal 24 SKS per semester
    if (totalSks + course.sks > 24) return false;

    // 3. Perbarui state secara immutable
    state = [...state, course];

    return true;
  }

  // Menghapus mata kuliah berdasarkan kode
  void hapusMataKuliah(String code) {
    state = state
        .where((c) => c.code.toUpperCase() != code.toUpperCase())
        .toList();
  }

  // Menghitung total SKS
  int get totalSks {
    return state.fold(0, (sum, course) => sum + course.sks);
  }
}

// Provider global untuk daftar KRS
final krsProvider =
StateNotifierProvider<KrsNotifier, List<KrsCourse>>((ref) {
  return KrsNotifier();
});

// Computed Provider untuk menghitung total SKS
final totalSksProvider = Provider<int>((ref) {
  final courses = ref.watch(krsProvider);

  return courses.fold(0, (sum, course) => sum + course.sks);
});
