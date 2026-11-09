import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../models/tugas_kuliah.dart';
import '../providers/tugas_provider.dart';

class TambahTugasPage extends StatefulWidget {
  const TambahTugasPage({super.key});

  @override
  State<TambahTugasPage> createState() => _TambahTugasPageState();
}

class _TambahTugasPageState extends State<TambahTugasPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController judulController;
  late TextEditingController mataKuliahController;

  DateTime? tenggat;

  @override
  void initState() {
    super.initState();

    judulController = TextEditingController();
    mataKuliahController = TextEditingController();
  }

  @override
  void dispose() {
    judulController.dispose();
    mataKuliahController.dispose();

    super.dispose();
  }

  Future<void> pilihTanggal() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    );

    if (tanggal != null) {
      setState(() {
        tenggat = tanggal;
      });
    }
  }

  void simpanTugas() {
    if (!_formKey.currentState!.validate()) return;

    if (tenggat == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan pilih tanggal tenggat!'),
        ),
      );
      return;
    }

    final tugas = TugasKuliah(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      judul: judulController.text.trim(),
      mataKuliah: mataKuliahController.text.trim(),
      tenggat: tenggat!,
    );

    context.read<TugasProvider>().tambahTugas(tugas);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tugas berhasil ditambahkan!'),
      ),
    );

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FF),
      appBar: AppBar(
        title: const Text('Tambah Tugas'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Buat Tugas Baru',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),

              const SizedBox(height: 25),

              const Text('Judul Tugas'),

              const SizedBox(height: 8),

              TextFormField(
                controller: judulController,
                decoration: InputDecoration(
                  hintText: 'Masukkan judul tugas',
                  prefixIcon: const Icon(Icons.assignment),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Judul tugas wajib diisi';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              const Text('Mata Kuliah'),

              const SizedBox(height: 8),

              TextFormField(
                controller: mataKuliahController,
                decoration: InputDecoration(
                  hintText: 'Contoh: Pemrograman Mobile',
                  prefixIcon: const Icon(Icons.menu_book),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Mata kuliah wajib diisi';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              const Text('Tanggal Tenggat'),

              const SizedBox(height: 8),

              InkWell(
                onTap: pilihTanggal,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.deepPurple.shade200),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        color: Colors.deepPurple,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        tenggat == null
                            ? 'Pilih tanggal tenggat'
                            : '${tenggat!.day}/${tenggat!.month}/${tenggat!.year}',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: simpanTugas,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Simpan Tugas',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}