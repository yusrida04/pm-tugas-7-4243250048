
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../providers/tugas_provider.dart';

class DaftarTugasPage extends StatefulWidget {
  const DaftarTugasPage({super.key});

  @override
  State<DaftarTugasPage> createState() => _DaftarTugasPageState();
}

class _DaftarTugasPageState extends State<DaftarTugasPage> {
  // State lokal untuk filter tugas
  String filter = 'Semua';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TugasProvider>();

    // Menyaring daftar tugas berdasarkan filter
    final daftarTugas = provider.daftarTugas.where((tugas) {
      if (filter == 'Aktif') {
        return !tugas.selesai;
      }

      if (filter == 'Selesai') {
        return tugas.selesai;
      }

      return true;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FF),

      // APP BAR
      appBar: AppBar(
        title: const Text(
          'StudyTask',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,

        // Badge jumlah tugas aktif menggunakan Selector
        actions: [
          Center(
            child: Selector<TugasProvider, int>(
              selector: (context, provider) => provider.jumlahAktif,
              builder: (context, jumlahAktif, child) {
                return Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$jumlahAktif Aktif',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // BODY
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // JUDUL
            const Text(
              'Daftar Tugas Kuliah',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Atur dan pantau semua tugas kuliahmu.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            // FILTER CHIP
            Wrap(
              spacing: 8,
              children: ['Semua', 'Aktif', 'Selesai'].map((item) {
                return FilterChip(
                  label: Text(item),
                  selected: filter == item,
                  selectedColor: Colors.deepPurple.shade100,
                  checkmarkColor: Colors.deepPurple,

                  onSelected: (value) {
                    setState(() {
                      filter = item;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 15),

            // DAFTAR TUGAS
            Expanded(
              child: daftarTugas.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.assignment_outlined,
                            size: 65,
                            color: Colors.deepPurple,
                          ),

                          const SizedBox(height: 12),

                          Text(
                            filter == 'Semua'
                                ? 'Belum ada tugas.'
                                : 'Tidak ada tugas $filter.',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 5),

                          const Text(
                            'Tambahkan tugas kuliahmu sekarang!',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: daftarTugas.length,
                      itemBuilder: (context, index) {
                        final tugas = daftarTugas[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          color: Colors.white,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),

                          child: ListTile(
                            // CHECKBOX SELESAI
                            leading: Checkbox(
                              activeColor: Colors.deepPurple,
                              value: tugas.selesai,

                              onChanged: (value) {
                                context
                                    .read<TugasProvider>()
                                    .tandaiSelesai(tugas.id);
                              },
                            ),

                            // JUDUL TUGAS
                            title: Text(
                              tugas.judul,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: tugas.selesai
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: tugas.selesai
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),

                            // MATA KULIAH DAN TENGGAT
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(tugas.mataKuliah),

                                  const SizedBox(height: 4),

                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today,
                                        size: 13,
                                        color: Colors.deepPurple,
                                      ),

                                      const SizedBox(width: 5),

                                      Text(
                                        'Tenggat: '
                                        '${tugas.tenggat.day}/'
                                        '${tugas.tenggat.month}/'
                                        '${tugas.tenggat.year}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 5),

                                  Text(
                                    tugas.selesai
                                        ? 'Selesai'
                                        : 'Belum selesai',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: tugas.selesai
                                          ? Colors.green
                                          : Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            isThreeLine: true,

                            // TOMBOL HAPUS
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),

                              onPressed: () {
                                context
                                    .read<TugasProvider>()
                                    .hapusTugas(tugas.id);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Tugas berhasil dihapus.',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // FLOATING ACTION BUTTON
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,

        onPressed: () {
          context.push('/tambah');
        },

        icon: const Icon(Icons.add),
        label: const Text('Tambah Tugas'),
      ),

      // BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          if (index == 1) {
            context.go('/statistik');
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Tugas',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistik',
          ),
        ],
      ),
    );
  }
}
