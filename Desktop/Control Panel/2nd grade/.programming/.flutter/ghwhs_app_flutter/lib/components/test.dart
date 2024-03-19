import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';


Future<void> _getTimetable() async {
  const schoolCode = 'M10';
  const schoolType = '8000032';
  final schoolGrade = '3';
  final schoolClass = '4';

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

    print(items.cast<Map<String, dynamic>>());
  } else {
    print('시간표를 불러오는 데 실패했습니다!');
  }
}


void main() async {
  _getTimetable();
  }
