# Laporan Praktikum Modul 01: Mobile Ecosystem, Flutter Setup & Profile App

- **Nama**: Antoni Silha Indriyan Priyadi
- **NIM**: 362558302006
- **Kelas / Prodi**: 2E / Sarjana Terapan TRPL
- **Mata Kuliah**: Pemrograman Perangkat Bergerak (Semester 3)

---

## 1. Ringkasan Aktivitas
Pada minggu ini saya belajar bagaimana cara set up project flutter menggunakan android studio dan juga melakukan cloning pada github dosen saya.

## 2. Bukti Tangkapan Layar (Running App)
[Sertakan minimal 2 screenshot bukti aplikasi profil berjalan di emulator atau HP fisik Anda]

screenshoot1= ./Assets/hotRealod&hotRestart.png
screenshoot2= ./Assets/running1.png
screenshoot3= ./Assets/running2.png
screenshoot4= ./Assets/running3.png
screenshoot5= ./Assets/running4.png
screenshoot6= ./Assets/running5.png
screenshoot7= ./Assets/testComplete.png

## 3. Kendala yang Dihadapi & Solusinya
- **Kendala**:
1. android toolchain missing
2. format penamaan penggunaan warna salah
3. pada widget_tester terjadi masalah
4. Expected: exactly one matching candidate
   Actual: _TextWidgetFinder:<Found 0 widgets with text "Jurusan / Kampus": []>
5. derived an Offset (Offset(400.0, 600.0)) that would not hit test on the specified widget.
   Maybe the widget is actually off-screen, or another widget is obscuring it, or the widget cannot receive pointer events.
   Indeed, Offset(400.0, 600.0) is outside the bounds of the root of the render tree, Size(800.0, 600.0).

- **Solusi**: 
1. Harus menginstall terlebih dahulu sdk android toolchain
2. Format seharusnya harus ada 0xFF
3. pada file widget_test.dart myapp harus diganti dengan class yg ada pada main.dart
4. pada file test menginginkan ada label "Jurusan / Kampus" sedangkan pada code yg di copy "Jurusan"
5. cara mengatasi nya yaitu melakukan penyesuaian aturan ukuran sesuai file test


## 4. Jawaban Pertanyaan Refleksi
1. **Pilihan Native vs Flutter**: Flutter
2. **Prinsip UI = f(state)**: Tampilan aplikasi (UI) ditentukan oleh kondisi/data aplikasi (State)
3. **Pentingnya Conventional Commits**: Untuk memudahkan pemahaman antar programmer, karena menggunakan commit yg sesuai dengan seluruh programmer di dunia