// ignore_for_file: file_names

import 'package:flutter/material.dart';
// 카드 자동 생성

Widget buildCard(Widget child) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    color: Colors.white,
    elevation: 5,
    shadowColor: Colors.grey,
    child: child,
  );
}
