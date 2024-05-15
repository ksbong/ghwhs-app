import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

void timeTable() async {
  String grade = '3';
  String classNum = '4';
  DateTime now = DateTime.now();

  String today = DateFormat('yyyyMMdd').format(now);
  String key = 'cf3f3604777d4131b0e65e666ae9f895';

  Map<String, String> timeTable = {};

  var response = await http.get(Uri.parse(
      'https://open.neis.go.kr/hub/hisTimetable?key=$key&Type=json&pIndex=1&pSize=100&ATPT_OFCDC_SC_CODE=M10&SD_SCHUL_CODE=8000032&GRADE=$grade&CLRM_NM=$classNum&ALL_TI_YMD=$today'));
  var responseJson = jsonDecode(response.body);

  try {
    var content = responseJson['hisTimetable'][1]['row'] as List;
    for (int i = 0; i < content.length; i++) {
      timeTable[content[i]['PERIO']] = content[i]['ITRT_CNTNT'];
    }
  } catch (e) {
    debugPrint('Failed to get TimeTable');
  }
  debugPrint(timeTable as String?);
}
