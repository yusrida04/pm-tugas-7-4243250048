import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../providers/tugas_provider.dart';

class StatistikPage extends StatelessWidget {
  const StatistikPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TugasProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FF),

      appBar: AppBar(
        title: const Text('Statistik Tugas'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ringkasan Aktivitas',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Pantau perkembangan tugas kuliahmu.',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  child: statistikCard(
                    'Total Tugas',
                    provider.jumlahTotal.toString(),
                    Icons.assignment,
                    Colors.deepPurple,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: statistikCard(
                    'Selesai',
                    provider.jumlahSelesai.toString(),
                    Icons.check_circle,
                    Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            statistikCard(
              'Tugas Aktif',
              provider.jumlahAktif.toString(),
              Icons.pending_actions,
              Colors.orange,
            ),

            const SizedBox(height: 30),

            const Text(
              'Persentase Penyelesaian',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    '${provider.persentase.toStringAsFixed(1)}%',
                    style: const TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),

                  const SizedBox(height: 15),

                  LinearProgressIndicator(
                    value: provider.persentase / 100,
                    minHeight: 12,
                    borderRadius: BorderRadius.circular(10),
                    backgroundColor: Colors.deepPurple.shade50,
                    color: Colors.deepPurple,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    '${provider.jumlahSelesai} dari '
                    '${provider.jumlahTotal} tugas telah diselesaikan.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.deepPurple,
        onTap: (index) {
          if (index == 0) {
            context.go('/');
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

  Widget statistikCard(
    String judul,
    String jumlah,
    IconData icon,
    Color warna,
  ) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: warna, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 5),
                Text(
                  jumlah,
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}