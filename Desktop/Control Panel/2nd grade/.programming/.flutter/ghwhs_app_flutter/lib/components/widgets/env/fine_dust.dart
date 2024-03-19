import 'package:flutter/material.dart';
import 'package:ghwhs_app_flutter/screens/view/env/fine_dust_page.dart';
import '../../component.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class FineDust extends StatefulWidget {
  const FineDust({super.key});

  @override
  State createState() => _FineDustState();
}

class _FineDustState extends State<FineDust> {
  late Timer timer;
  String fineDust = '0';
  DateTime currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 2), (Timer t) {
      fetchData();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FineDustPage(),
            )),
        child: buildComponent(
            120,
            MediaQuery.of(context).size.width,
            Stack(
              children: [
                // Padding(
                //     padding:
                //     const EdgeInsets.only(right: 10, left: 20, top: 10),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //       children: [
                //         const Text(
                //           '미세먼지',
                //           style: TextStyle(
                //               color: Colors.white,
                //               fontSize: 18,
                //               fontWeight: FontWeight.bold),
                //         ),
                //         SizedBox(
                //           width: MediaQuery.of(context).size.width / 2,
                //         ),
                //         const Icon(
                //           Icons.arrow_forward,
                //           size: 30,
                //           color: Colors.white,
                //         )
                //       ],
                //     )),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 22, bottom: 15),
                      child: Text(
                        '미세먼지',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20, right: 10, top: 10),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 30,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            renderFineDust(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                '${currentTime.hour < 12 ? 'AM' : 'PM'}${currentTime.hour < 12 ? currentTime.hour : currentTime.hour - 12}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              '현재 미세먼지 농도는',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                int.parse(fineDust) <= 30
                                    ? const Text(
                                        '\'좋음\'',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      )
                                    : int.parse(fineDust) > 30 &&
                                            int.parse(fineDust) <= 80
                                        ? const Text(
                                            '\'보통\'',
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          )
                                        : int.parse(fineDust) > 80 &&
                                                int.parse(fineDust) <= 150
                                            ? const Text(
                                                '\'나쁨\'',
                                                style: TextStyle(
                                                    color: Colors.orangeAccent,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            : const Text(
                                                '\'매우나쁨\'',
                                                style: TextStyle(
                                                    color: Colors.deepOrange,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                const Text(
                                  '이에요',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            )));
  }

  Widget renderFineDust() {
    fetchData();
    return Text(
      fineDust,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 50,
      ),
    );
  }

  Future<void> fetchData() async {

    String fineDustURL =
        'https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%EC%B6%A9%EC%B2%AD%EB%B6%81%EB%8F%84+%EB%AF%B8%EC%84%B8%EB%A8%BC%EC%A7%80';

    //String databaseURL =
    //    'https://hwandong-1cdba-default-rtdb.asia-southeast1.firebasedatabase.app';

    // Make a GET request to fetch data
    // final response = await http.get(Uri.parse('$databaseURL/미세먼지.json'));
    //
    // if (response.statusCode == 200) {
    //   // Parse the response body
    //   // print(response.body);
    //   // print(response.body.runtimeType);
    //
    //   setState(() {
    //     if (response.body.length == 1) {
    //       fineDust = "0${response.body}";
    //     } else {
    //       fineDust = response.body;
    //     }
    //     currentTime = DateTime.now();
    //   });
    // } else {
    //   // Handle errors
    //   debugPrint('Failed to fetch data: ${response.statusCode}');
    // }
    final responseFineDust = await http.get(Uri.parse(fineDustURL));

    if (responseFineDust.statusCode == 200) {
      var start = responseFineDust.body.toString().indexOf('진천');
      var end = responseFineDust.body.toString().indexOf('괴산');
      var foo =
      responseFineDust.body.toString().substring(start, end).split('>');
      for (int i = 0; i < foo.length; i++) {
        if (foo[i].contains('<span')) foo.removeAt(i);
      }
      for (int i = 0; i < foo.length; i++) {
        if (foo[i].contains('</span')) foo.removeAt(i);
      }
      for (int i = 0; i < foo.length; i++) {
        if (foo[i].contains('<em')) foo.removeAt(i);
      }
      for (int i = 0; i < foo.length; i++) {
        if (foo[i].contains('<a')) foo.removeAt(i);
      }
      for (int i = 0; i < foo.length; i++) {
        if (foo[i].contains('class')) foo.removeAt(i);
      }
      for (int i = 0; i < foo.length; i++) {
        if (foo[i].contains('href')) foo.removeAt(i);
      }
      for (int i = 0; i < foo.length; i++) {
        if (foo[i].contains('</span')) foo.removeAt(i);
      }
      for (int i = 0; i < foo.length; i++) {
        if (foo[i].contains('</a')) foo.removeAt(i);
      }
      foo[0] = foo[0].toString().substring(0, foo[0].indexOf('<'));


      if(foo[0].length == 1){
        setState(() {

          fineDust = "0${foo[0]}";});

      } else {
        setState(() {
          fineDust = foo[0];
        });
      }
      setState(() {
        currentTime = DateTime.now();
      });

    }
  }
}
