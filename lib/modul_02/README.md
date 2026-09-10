# Laporan Praktikum Modul 02: Declarative UI & Responsive Layout

- **Nama**: Antoni Silha Indriyan Priyadi
- **NIM**: 362558302006
- **Kelas / Prodi**: 2E / Sarjana Terapan TRPL
- **Mata Kuliah**: Pemrograman Perangkat Bergerak (Semester 3)

---

## 1. Ringkasan Implementasi
Dashboard Akademik TRPL dirancang secara responsif menggunakan `LayoutBuilder` dan konfigurasi tema Material 3 berbasis `ColorScheme.fromSeed` agar antarmuka aplikasi beradaptasi secara otomatis terhadap berbagai ukuran layar. Pada layar smartphone dengan lebar kurang dari 600 dp, seluruh komponen disusun secara vertikal dalam satu kolom yang dapat digulir menggunakan `ListView`. Sementara itu, pada layar tablet atau orientasi lanskap berukuran 600 dp atau lebih, antarmuka beralih secara dinamis menjadi tata letak dua kolom berbasis `Row`, dengan kolom kiri memuat profil `HeaderBanner` dan kolom kanan menampilkan daftar mata kuliah menggunakan `GridView.builder`. Aplikasi ini juga dilengkapi dengan fitur interaktif berupa filter kategori mata kuliah berbasis `ChoiceChip`, modal `showModalBottomSheet` untuk menampilkan rincian silabus, indikator perhitungan akumulasi SKS dengan peringatan kuota maksimal 24 SKS, serta sakelar beralih antara Mode Terang dan Mode Gelap.

## 2. Bukti Tangkapan Layar (Running App)
| Mode Portrait (Light)                           | Mode Dark Theme                    | Mode Landscape / Tablet (2 Kolom)  |
|-------------------------------------------------|------------------------------------|------------------------------------|
| ![Portrait](./screenshots/running_portrait.png) | ![Dark](./screenshots/running_dark.png) | ![Wide](./screenshots/running_wide.png) |

## 3. Kendala Layout yang Dihadapi & Solusinya
- **Kendala 1**: Pengujian unit test gagal karena penambahan properti `category` pada model `Course`.
    - **Solusi**: Mengatur parameter `category` pada konstruktor `Course` menjadi opsional dengan nilai default (`this.category = 'Teori'`).

## 4. Jawaban Pertanyaan Refleksi
1. **Efisiensi Single-pass BoxConstraints**: Aturan "Constraints go down, Sizes go up, Parent sets position" membuat komputasi layout di Flutter berjalan sangat efisien dalam satu kali penelusuran. Parent meneruskan batasan ukuran ke bawah, child menghitung dan mengembalikan ukurannya ke atas, lalu parent menentukan koordinat posisinya. Karena tidak membutuhkan pengukuran berulang, proses rendering tetap cepat dan linier terhadap jumlah widget,
2. **Kriteria Modularisasi Widget**: Sebuah widget sebaiknya dipecah menjadi file terpisah (seperti `CourseCard`) jika bersifat reusable (digunakan di beberapa tempat), memiliki struktur tata letak yang kompleks, atau memerlukan pengujian unit/widget test secara independen . Sebaliknya, widget cukup diletakkan sebagai private widget (seperti `_StatPill`) pada file yang sama jika hanya digunakan secara eksklusif oleh layar tersebut dan berukuran ringkas,
3. **Manfaat M3 ThemeData Terpusat**: Penggunaan `ThemeData` Material 3 terpusat (`ColorScheme.fromSeed`) menggenerasi palet warna harmonis untuk mode terang dan gelap secara otomatis. Hal ini mempermudah pemeliharaan kode aplikasi skala besar karena perubahan warna branding atau skema tema cukup dikonfigurasi pada satu lokasi utama tanpa perlu mengganti warna secara manual (hardcoded) pada setiap komponen widget 