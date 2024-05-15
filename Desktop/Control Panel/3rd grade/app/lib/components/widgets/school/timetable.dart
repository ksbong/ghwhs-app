import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class TimeTable extends StatefulWidget {
  const TimeTable({super.key});

  @override
  State createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  static const storage = FlutterSecureStorage();
  String grade = '1';
  String classNumber = '1';
  var timetable = {};
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchData().then((value) => timeTable(grade, classNumber));
  }

  Future<void> fetchData() async {
    String? bday = await storage.read(key: 'bday');
    String temp = bday?.split('.') as String;
    String tempGrade = (now.year - int.parse(temp[0]) - 16).toString();
    String? classNumber = await storage.read(key: 'grade$tempGrade');
    String tempClassNumber = classNumber!.split('/')[0];
    setState(() {
      grade = tempGrade;
      classNumber = tempClassNumber;
    });
  }

  void timeTable(String grade, String classNum) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff181A20),
        appBar: AppBar(
          backgroundColor: const Color(0xff181A20),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            '앱 정보',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(padding: const EdgeInsets.all(10), child: Text('')));
  }
}
