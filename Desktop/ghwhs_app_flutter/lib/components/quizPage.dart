// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../builder/getPicture.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'assets/title_logo.png',
            scale: 4.6,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
          child: FutureBuilder(
              future: getPicture('question'),
              builder: (context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? Image.network(snapshot.data)
                    : const CircularProgressIndicator();
              })),
    );
  }
}
