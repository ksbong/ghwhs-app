// neis API Key: cf3f3604777d4131b0e65e666ae9f895
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class GHWTimeTable extends StatefulWidget {
  const GHWTimeTable({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GHWTimeTableState createState() => _GHWTimeTableState();
}

class _GHWTimeTableState extends State<GHWTimeTable> {
  final TextEditingController _schoolGradeController = TextEditingController();
  final TextEditingController _schoolClassController = TextEditingController();

  List<Map<String, dynamic>> _timetableData = [];

  Future<void> _getTimetable() async {
    const schoolCode = 'M10';
    const schoolType = '8000032';
    final schoolGrade = _schoolGradeController.text;
    final schoolClass = _schoolClassController.text;

    const apiUrl = 'https://open.neis.go.kr/hub/hisTimetable';
    const apiKey = 'cf3f3604777d4131b0e65e666ae9f895';

    DateTime now = DateTime.now();
    String today = DateFormat('yyyyMMdd').format(now);

    final response = await http.get(
      Uri.parse(
          '$apiUrl?key=$apiKey&Type=json&pIndex=1&pSize=5&ATPT_OFCDC_SC_CODE=$schoolCode&SD_SCHUL_CODE=$schoolType&ALL_TI_YMD=$today&GRADE=$schoolGrade&CLASS_NM=$schoolClass'),
    );

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      final items = decodedData['hisTimetable']['row'] as List;

      items.sort((a, b) => b['PERIO'].compareTo(a['PERIO']));

      debugPrint(items.toString());
      setState(() {
        _timetableData = items.cast<Map<String, dynamic>>();
      });
    } else {
      debugPrint('시간표를 불러오는 데 실패했습니다!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GHW Timetable'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _schoolGradeController,
              decoration: const InputDecoration(labelText: '학년'),
            ),
            TextField(
              controller: _schoolClassController,
              decoration: const InputDecoration(labelText: '반'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getTimetable,
              child: const Text('시간표 불러오기'),
            ),
            const SizedBox(height: 16),
            const Text('시간표 정보:'),
            Expanded(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('교시')),
                  DataColumn(label: Text('과목명')),
                ],
                rows: _timetableData.map((timetable) {
                  return DataRow(
                    cells: [
                      DataCell(Text(timetable['PERIO'].toString())),
                      DataCell(Text(timetable['ITRT_CNTNT'].toString())),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
