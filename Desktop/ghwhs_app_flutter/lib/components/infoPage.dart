// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../builder/showDialog.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

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
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text('Version'),
            subtitle: Text('1.0-beta'),
          ),
          ListTile(
            title: const Text('개발자 정보'),
            subtitle: const Text('자세히보기'),
            onTap: () => showDevDialog(context),
          ),
          const ListTile(
              title: Text('License'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('이 앱의 저작권은'),
                  Text('광혜원고등학교 환경동아리에 있습니다.'),
                ],
              )),
          const ListTile(
            title: Text(''),
            subtitle: Text(''),
          ),
          const ListTile(
            title: Text(''),
            subtitle: Text(''),
          ),
          ListTile(
            title: const Text(''),
            subtitle: const Text(''),
            onTap: () => showMyDialog(context),
          )
        ],
      ),
    );
  }
}
