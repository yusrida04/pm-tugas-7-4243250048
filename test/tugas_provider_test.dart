
import 'package:flutter_test/flutter_test.dart';

import 'package:pm_pertemuan_07/models/tugas_kuliah.dart';
import 'package:pm_pertemuan_07/providers/tugas_provider.dart';

void main() {
  group('TugasProvider Test', () {
    late TugasProvider provider;

    setUp(() {
      provider = TugasProvider();
    });

    test('Berhasil menambahkan tugas', () {
      final tugas = TugasKuliah(
        id: '1',
        judul: 'Membuat Aplikasi Flutter',
        mataKuliah: 'Pemrograman Mobile',
        tenggat: DateTime(2026, 11, 15),
      );

      provider.tambahTugas(tugas);

      expect(provider.jumlahTotal, 1);
      expect(provider.jumlahAktif, 1);
      expect(provider.jumlahSelesai, 0);
    });

    test('Berhasil menandai tugas selesai', () {
      final tugas = TugasKuliah(
        id: '2',
        judul: 'Membuat Laporan',
        mataKuliah: 'Pemrograman Mobile',
        tenggat: DateTime(2026, 11, 15),
      );

      provider.tambahTugas(tugas);
      provider.tandaiSelesai('2');

      expect(provider.jumlahTotal, 1);
      expect(provider.jumlahSelesai, 1);
      expect(provider.jumlahAktif, 0);
      expect(provider.persentase, 100);
    });

    test('Berhasil menghapus tugas', () {
      final tugas = TugasKuliah(
        id: '3',
        judul: 'Mengerjakan Praktikum',
        mataKuliah: 'Algoritma',
        tenggat: DateTime(2026, 11, 20),
      );

      provider.tambahTugas(tugas);
      provider.hapusTugas('3');

      expect(provider.jumlahTotal, 0);
      expect(provider.jumlahAktif, 0);
      expect(provider.jumlahSelesai, 0);
      expect(provider.persentase, 0);
    });
  });
}
