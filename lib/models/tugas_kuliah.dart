class TugasKuliah {
  final String id;
  final String judul;
  final String mataKuliah;
  final DateTime tenggat;
  bool selesai;

  TugasKuliah({
    required this.id,
    required this.judul,
    required this.mataKuliah,
    required this.tenggat,
    this.selesai = false,
  });
}