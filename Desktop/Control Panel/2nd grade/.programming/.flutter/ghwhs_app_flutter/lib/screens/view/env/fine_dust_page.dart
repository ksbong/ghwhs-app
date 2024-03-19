import 'package:flutter/material.dart';
import 'package:ghwhs_app_flutter/components/component.dart';

import 'package:http/http.dart' as http;

class FineDustPage extends StatefulWidget {
  const FineDustPage({super.key});

  @override
  State createState() => _FineDustPageState();
}

class _FineDustPageState extends State<FineDustPage> {
  Future getFineDust() async {
    String databaseURL =
        'https://hwandong-1cdba-default-rtdb.asia-southeast1.firebasedatabase.app';

    String fineDustURL =
        'https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%EC%B6%A9%EC%B2%AD%EB%B6%81%EB%8F%84+%EB%AF%B8%EC%84%B8%EB%A8%BC%EC%A7%80';

    // Make a GET request to fetch data
    final response = await http.get(Uri.parse('$databaseURL/미세먼지.json'));
    final responseFineDust = await http.get(Uri.parse(fineDustURL));

    if (response.statusCode == 200) {
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

      return [response.body, double.parse(foo[0])];
    }

    return [0, 0];
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
          '미세먼지',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xff181A20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            buildComponent(
                150,
                MediaQuery.of(context).size.width,
                FutureBuilder(
                    future: getFineDust(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? Center(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('우리학교: ${snapshot.data[0]}㎍/㎥',
                                    style: const TextStyle(
                                        fontSize: 25, color: Colors.white)),
                                const SizedBox(height: 10,),
                                Text(
                                  '우리지역: ${snapshot.data[1]}㎍/㎥',
                                  style: const TextStyle(
                                      fontSize: 25, color: Colors.white),
                                )
                              ],
                            ))
                          : const Center(
                              child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Loading...",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(child: CircularProgressIndicator()),
                              ],
                            ));
                    }))
          ],
        ),
      ),
    );
  }
}
