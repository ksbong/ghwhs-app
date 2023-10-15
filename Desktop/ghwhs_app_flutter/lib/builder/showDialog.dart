// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../builder/getPicture.dart';

Future<void> showMyDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('이스터에그를 찾으셨군요! ㅊㅊ'),
        content: SingleChildScrollView(
            child: FutureBuilder(
              future: getPicture('easter_egg'),
              builder: (context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? Image.network(snapshot.data)
                    : const CircularProgressIndicator();
              },
            )),
        actions: <Widget>[
          TextButton(
            child: const Text('창닫기'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> showDevDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('개발자 정보'),
        content: SingleChildScrollView(
            child: Column(
              children: [
                // Image.asset('ghwhs.png'),
                FutureBuilder(
                  future: getPicture('ghwhs_logo'),
                  builder: (context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? Image.network(
                      snapshot.data,
                      scale: 2.5,
                    )
                        : const CircularProgressIndicator();
                  },
                ),
                const ListTile(
                  title: Text('프로그래밍'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('광혜원고등학교 2022 입학생 김상봉'),
                      Text('광혜원고등학교 2022 입학생 배진우: D-day부분')
                    ],
                  ),
                ),
                const ListTile(
                  title: Text('디자인'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('광혜원고등학교 2022 입학생 김하영'),
                      Text('광혜원고등학교 2022 입학생 정수찬')
                    ],
                  ),
                )
              ],
            )),
        actions: <Widget>[
          TextButton(
            child: const Text('창닫기'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
