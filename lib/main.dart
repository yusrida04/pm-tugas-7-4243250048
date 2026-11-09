import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/tugas_provider.dart';
import 'routes/app_router.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TugasProvider(),
      child: const StudyTaskApp(),
    ),
  );
}

class StudyTaskApp extends StatelessWidget {
  const StudyTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'StudyTask',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      routerConfig: appRouter,
    );
  }
}