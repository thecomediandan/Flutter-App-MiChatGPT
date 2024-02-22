import 'package:flutter/material.dart';
import 'package:flutter_application_chatgpt/views/chat.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.blue,
      theme: ThemeData.dark(),
      //themeMode: ThemeMode.dark,
      title: 'Mi ChatGPT',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Mi ChatGPT'),
          actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.more_vert_sharp))],
        ),
        body: Center(
          child: Chat(),
        ),
      ),
    );
  }
}
