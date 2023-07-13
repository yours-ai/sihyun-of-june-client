import 'package:flutter/material.dart';

void main() {
  runApp(const ProjectJuneApp());
}

class ProjectJuneApp extends StatelessWidget {
  const ProjectJuneApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      title: 'Project June',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hello")),
      body: ElevatedButton(child: Text("Click me"), onPressed: () {}),
    );
  }
}
