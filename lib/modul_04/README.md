# Praktikum Flutter Modul 4

## Biodata

**Nama** : Antoni Silha Indriyan Priyadi
**NIM** : 362558302006
**Kelas** : 2E
**Program Studi** : D4-TRPL
**Angkatan** : 2025

## Alur Aplikasi

```text
AnnouncementListScreen
↓
Riverpod Provider
↓
AnnouncementRepository
↓
Dio
↓
REST API
```

## Screenshot Bukti Praktikum

1. Loading
   [![State Loading](Screenshots/modul4/loading.png)](Screenshots/modul4/loading.png)

2. ERROR
   [![State Error](Screenshots/modul4/error.png)](Screenshots/modul4/loading.png)

3. KOSONG
   [![State Kosong](Screenshots/modul4/kosong.png)](Screenshots/modul4/kosong.png)

3. BERHASIL
   [![State Berhasil](Screenshots/modul4/berhasil.png)](Screenshots/modul4/berhasil.png)

## Pertanyaan Refleksi

### 1. Mengapa penggunaan Repository Pattern lebih baik dibandingkan melakukan request API langsung dari halaman?

Penggunaan Repository Pattern membuat kode aplikasi menjadi lebih terstruktur karena tanggung jawab antara tampilan dan pengambilan data dipisahkan. `AnnouncementListScreen` hanya bertugas menampilkan data dan mengatur interaksi pengguna, sedangkan `AnnouncementRepository` bertugas mengambil dan mengolah data dari REST API. Dengan pemisahan ini, kode menjadi lebih mudah diuji, dipelihara, dan dikembangkan. Kekurangannya adalah struktur kode menjadi lebih banyak karena membutuhkan provider dan repository sebagai lapisan tambahan.

### 2. Apa keuntungan menggunakan Dio untuk komunikasi dengan REST API?

Dio mempermudah proses komunikasi antara aplikasi Flutter dengan server karena menyediakan API untuk melakukan request HTTP dan mengelola response dengan lebih terstruktur. Dio juga mendukung fitur seperti interceptor, timeout, pengaturan header, serta penanganan error sehingga lebih mudah digunakan ketika aplikasi mulai memiliki kebutuhan networking yang lebih kompleks. Dengan demikian, kode networking dapat dibuat lebih terorganisasi dibandingkan menangani seluruh proses HTTP secara langsung di dalam halaman.

### 3. Mengapa error dari REST API sebaiknya tidak langsung diubah menjadi data kosong?

Mengubah error menjadi data kosong dapat membuat aplikasi sulit membedakan antara kondisi server benar-benar tidak memiliki data dan kondisi request mengalami kegagalan. Akibatnya, pengguna dapat melihat halaman kosong tanpa mengetahui bahwa sebenarnya terjadi masalah koneksi atau server. Error sebaiknya tetap diteruskan ke layer yang menangani state agar aplikasi dapat menampilkan **Error State**, memberikan pesan yang sesuai kepada pengguna, dan menyediakan tombol **Coba Lagi** untuk melakukan request kembali.

### 4. Apa keuntungan menggunakan Riverpod untuk menghubungkan Repository dengan UI?

Riverpod membantu memisahkan dependency dan state dari widget UI. Repository dapat disediakan melalui provider sehingga `AnnouncementListScreen` tidak perlu membuat object repository secara langsung. Salah satu keuntungan pentingnya adalah repository dapat diganti menggunakan **Fake Repository** ketika melakukan widget testing. Dengan demikian, pengujian dapat dilakukan tanpa bergantung pada server atau koneksi internet secara langsung.

### 5. Mengapa aplikasi perlu menangani Loading, Success, Error, dan Empty State secara berbeda?

Keempat kondisi tersebut menunjukkan keadaan aplikasi yang berbeda sehingga pengguna membutuhkan informasi yang berbeda pula. **Loading State** menunjukkan bahwa data sedang dimuat, **Success State** menunjukkan bahwa data berhasil diperoleh, **Error State** menunjukkan bahwa terjadi kegagalan saat mengambil data, sedangkan **Empty State** menunjukkan bahwa request berhasil tetapi tidak ada data yang dapat ditampilkan. Dengan membedakan keempat kondisi tersebut, pengguna dapat memahami keadaan aplikasi dengan lebih jelas dan aplikasi tidak memberikan informasi yang menyesatkan.