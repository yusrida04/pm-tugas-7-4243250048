import 'package:go_router/go_router.dart';

import '../pages/daftar_tugas_page.dart';
import '../pages/tambah_tugas_page.dart';
import '../pages/statistik_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const DaftarTugasPage(),
    ),
    GoRoute(
      path: '/tambah',
      builder: (context, state) => const TambahTugasPage(),
    ),
    GoRoute(
      path: '/statistik',
      builder: (context, state) => const StatistikPage(),
    ),
  ],
);