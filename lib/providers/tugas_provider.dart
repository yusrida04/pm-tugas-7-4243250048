import 'package:flutter/material.dart';
import '../models/tugas_kuliah.dart';

class TugasProvider extends ChangeNotifier {
  final List<TugasKuliah> _daftarTugas = [];

  List<TugasKuliah> get daftarTugas => List.unmodifiable(_daftarTugas);

  int get jumlahTotal => _daftarTugas.length;

  int get jumlahSelesai =>
      _daftarTugas.where((tugas) => tugas.selesai).length;

  int get jumlahAktif => jumlahTotal - jumlahSelesai;

  double get persentase {
    if (jumlahTotal == 0) return 0;
    return jumlahSelesai / jumlahTotal * 100;
  }

  void tambahTugas(TugasKuliah tugas) {
    _daftarTugas.add(tugas);
    notifyListeners();
  }

  void tandaiSelesai(String id) {
    final index = _daftarTugas.indexWhere((tugas) => tugas.id == id);

    if (index != -1) {
      _daftarTugas[index].selesai = !_daftarTugas[index].selesai;
      notifyListeners();
    }
  }

  void hapusTugas(String id) {
    _daftarTugas.removeWhere((tugas) => tugas.id == id);
    notifyListeners();
  }
}