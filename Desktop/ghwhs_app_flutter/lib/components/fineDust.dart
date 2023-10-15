// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../builder/buildCard.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:http/http.dart' as http;

// 0~15 좋음, 16~35 보통, 36~75 나쁨, 76이상 매우 나쁨
Widget howsFineDust(double fineDust) {
  double fontSize = 30;
  if (0 <= fineDust && fineDust <= 15) {
    return Text(
      '좋음',
      style: TextStyle(fontSize: fontSize, color: Colors.blue),
    );
  } else if (16 <= fineDust && fineDust <= 35) {
    return Text(
      '보통',
      style: TextStyle(fontSize: fontSize, color: Colors.green),
    );
  } else if (36 <= fineDust && fineDust <= 75) {
    return Text(
      '나쁨',
      style: TextStyle(fontSize: fontSize, color: Colors.deepOrange),
    );
  } else if (76 <= fineDust) {
    return Text(
      '매우나쁨',
      style: TextStyle(fontSize: fontSize, color: Colors.red),
    );
  }
  return const Text('미세 먼지 농도\n정보가 잘못 되었습니다.');
}

class GuageApp extends StatefulWidget {
  const GuageApp({super.key});

  @override
  State createState() => _RangePointer();
}

class _RangePointer extends State<GuageApp> {
  Future<double> getFineDust() async {
    final url = Uri.parse(
        'https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=%EC%B6%A9%EC%B2%AD%EB%B6%81%EB%8F%84+%EB%AF%B8%EC%84%B8%EB%A8%BC%EC%A7%80');

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var start = response.body.toString().indexOf('진천');
      var end = response.body.toString().indexOf('괴산');
      var foo = response.body.toString().substring(start, end).split('>');
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

      return double.parse(foo[0]);
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getFineDust(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var fineDust = snapshot.data;
          return snapshot.hasData
              ? buildCard(SizedBox(
            width: MediaQuery.of(context).size.width -
                (MediaQuery.of(context).size.width) / 15,
            height: MediaQuery.of(context).size.height * 2 / 10,
            child: Stack(
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 15),
                    child: Stack(
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text('광혜원고등학교')),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: Row(
                            children: [
                              const Text(
                                '현재 대기상태  ',
                                style: TextStyle(fontSize: 20),
                              ),
                              howsFineDust(fineDust)
                            ],
                          ),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 2),
                    child: _buildRangePointer(fineDust)),
              ],
            ),
          ))
              : buildCard(SizedBox(
              width: (MediaQuery.of(context).size.width) -
                  (MediaQuery.of(context).size.width) / 15,
              height: MediaQuery.of(context).size.height * 2 / 10,
              child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("로딩중인겨~"),
                    SizedBox(
                      height: 10,
                    ),
                    Center(child: CircularProgressIndicator()),
                  ])));
        });
  }

  SfRadialGauge _buildRangePointer(fineDust) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          showLabels: false,
          showTicks: false,
          startAngle: 90,
          endAngle: 90,
          radiusFactor: 0.8,
          axisLineStyle: const AxisLineStyle(
              thicknessUnit: GaugeSizeUnit.factor, thickness: 0.15),
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              angle: 180,
              widget: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      '$fineDust',
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              ),
            ),
          ],
          pointers: <GaugePointer>[
            RangePointer(
              animationType: AnimationType.easeOutBack,
              value: fineDust,
              cornerStyle: CornerStyle.bothCurve,
              enableAnimation: true,
              animationDuration: 1200,
              sizeUnit: GaugeSizeUnit.factor,
              gradient: const SweepGradient(
                  colors: <Color>[Color(0xFF6A6EF6), Color(0xFFD882F5)],
                  stops: <double>[0.25, 0.75]),
              color: const Color(0xFF00A8B5),
              width: 0.15,
            )
          ],
        )
      ],
    );
  }
}
