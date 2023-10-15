import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future getSNDate() async {
  late int dday;
  final url = Uri.parse(
      'https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%EC%88%98%EB%8A%A5+%EB%82%A0%EC%A7%9C');

  var response = await http.get(url);

  if (response.statusCode == 200) {
    int start = response.body.toString().indexOf('<div class="sn_summary">');
    int end = response.body
        .toString()
        .indexOf('<div class="tab_area _button_scroller">');
    var foo = response.body.toString().substring(start, end).split('>');
    var dateTemp = foo[9].replaceAll('</dd', '');
    var date =
        "${dateTemp.split(' ')[0].replaceAll('년', '')}-${dateTemp.split(' ')[1].replaceAll('월', '')}-${dateTemp.split(' ')[2].replaceAll('일', '')}";

    DateTime date1 = DateTime.now();

    DateTime date2 = DateTime.parse(date);

    dday = date2.difference(date1).inDays;

    return dday;
  }
}

// 지필고사 D-day
final int dday2 = getDday2();

int getDday2() {
  late int dday2;
  DateTime date3 = DateTime.now();
  DateTime date4 = DateTime.parse("2023-10-18");
  dday2 = date4.difference(date3).inDays;
  return dday2;
}

Widget buildDday() {
  return dday2 == 0 ? const Text('Good Luck', style: TextStyle(fontSize: 40)): Text('정기고사 D-$dday2', style: const TextStyle(fontSize: 40));
}
