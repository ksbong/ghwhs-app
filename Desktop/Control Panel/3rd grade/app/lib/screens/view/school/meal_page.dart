import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'meal_tomorrow.dart';

class MealPage extends StatefulWidget {
  const MealPage({super.key});

  @override
  State createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {
  var breakFast = '', lunch = '', dinner = '';
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      getMeal();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> getMeal() async {
    DateTime now = DateTime.now().add(const Duration(days: 1));
    String today = DateFormat('yyyyMMdd').format(now);
    String url =
        'https://open.neis.go.kr/hub/mealServiceDietInfo?Type=json&pIndex=1&pSize=100&ATPT_OFCDC_SC_CODE=M10&SD_SCHUL_CODE=8000032&MLSV_YMD=$today';

    DateTime tomorrow = now.add(const Duration(days: 1));
    String tomorrowDate = DateFormat('yyyyMMdd').format(tomorrow);
    String tomorrowURL =
        'https://open.neis.go.kr/hub/mealServiceDietInfo?Type=json&pIndex=1&pSize=100&ATPT_OFCDC_SC_CODE=M10&SD_SCHUL_CODE=8000032&MLSV_YMD=$tomorrowDate';
    final response = await http.get(Uri.parse(url));
    final tomorrowResponse = await http.get(Uri.parse(tomorrowURL));

    String tomorrowYoil = DateFormat('E').format(tomorrow);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      try {
        var root = body['mealServiceDietInfo'][1]['row'];
        try {
          setState(() {
            breakFast = root[0]['DDISH_NM'];
            lunch = root[1]['DDISH_NM'];
            dinner = root[2]['DDISH_NM'];
          });
        } catch (e) {
          try {
            try {
              if (tomorrowResponse.statusCode == 200) {
                final body = json.decode(tomorrowResponse.body);
                var root = body['mealServiceDietInfo'][1]['row'];

                if (tomorrowYoil != 'Fri') {
                  debugPrint(root[0]['DDISH_NM']);
                  debugPrint(root[1]['DDISH_NM']);
                  debugPrint(root[2]['DDISH_NM']);
                }

                setState(() {
                  breakFast = '오늘은 조식이 없습니다.';
                  lunch = root[0]['DDISH_NM'];
                  dinner = root[1]['DDISH_NM'];
                });
              }
            } catch (e) {
              setState(() {
                breakFast = root[0]['DDISH_NM'];
                lunch = root[1]['DDISH_NM'];
                dinner = '오늘은 석식이 없습니다.';
              });
            }

          } catch (e) {
            setState(() {
              breakFast = '오늘은 조식이 없습니다.';
              lunch = root[0]['DDISH_NM'];
              dinner = '오늘은 석식이 없습니다.';
            });
          }
        }
      } catch (e) {
        // print(e);
        setState(() {
          breakFast = '오늘은 조식이 없습니다.';
          lunch = '오늘은 중식이 없습니다.';
          dinner = '오늘은 석식이 없습니다.';
        });
      }
    } else {
      // ignore: avoid_print
      print("Failed: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff181A20),
        appBar: AppBar(
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
            '급식 정보',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff181A20),
          elevation: 0,
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: ListView(
                children: [
                  Center(
                    child: Text(
                      DateFormat('yyyy년MM월dd일').format(DateTime.now()),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        mealCard('조식', breakFast),
                        const SizedBox(
                          height: 40,
                        ),
                        mealCard('중식', lunch),
                        const SizedBox(
                          height: 40,
                        ),
                        mealCard('석식', dinner),
                        ElevatedButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MealPageTomorrow())),
                            child: const Text('내일 급식 미리보기'))
                      ])
                ],
              ),
            )));
  }

  Widget mealCard(String title, String content) {
    getMeal();
    List<String> stringList = content
        .replaceAll(RegExp(r'\d+'), '')
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll('.', '')
        .split("<br/>");
    //List<String> stringList =  ['꼬들꼬들오이지무침' , '애호박볶음' , '배추김치 ', '진한초코 ', '우렁이된장찌개' , '친환경흰쌀밥 '];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        const SizedBox(
          height: 5,
        ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: stringList
                .map((text) => Text(
                      text,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ))
                .toList())
      ],
    );
  }
}
