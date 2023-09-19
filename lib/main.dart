import 'package:flutter/material.dart';
import 'package:secomp2023/modules/tarefa/pages/tarefa_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarefas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 221, 202, 253)),
        useMaterial3: true,
      ),
      home: const TarefaListPage(),
    );
  }
}
