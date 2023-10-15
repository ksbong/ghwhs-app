// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../builder/buildCard.dart';
import 'package:neis/neis.dart';

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy.MM.dd').format(now);
//
// String  = DateFormat('MM.dd').format(date);

String yoil = DateFormat('EEEE').format(now);
String dayOfWeek = yoilPatch[yoil]!;

// ignore: non_constant_identifier_names
List<String> kor_yoils = ['월', '화', '수', '목', '금', '토', '일'];
Map<String, String> yoilPatch = {
  'Monday': '월',
  'Tuesday': '화',
  'Wednesday': '수',
  'Thursday': '목',
  'Friday': '금',
  'Saturday': '토',
  'Sunday': '일'
};

class MealBoard extends StatefulWidget {
  const MealBoard({super.key});
  @override
  State<MealBoard> createState() => _MealBoardState();
}

class _MealBoardState extends State<MealBoard> {
  final _neis = Neis(Region.chungbuk, "8000032", SchoolType.his,
      "cf3f3604777d4131b0e65e666ae9f895");
  List<dynamic> meal = [];

  @override
  void initState() {
    super.initState();
    _neis.getMeals(now.year, now.month).then((value) {
      setState(() {
        meal = value[now.day - 1];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (dayOfWeek == '금') {
      return Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Row(
          children: [
            buildCard(SizedBox(
              width: ((MediaQuery.of(context).size.width) -
                          (MediaQuery.of(context).size.width) / 15) /
                      2 -
                  (MediaQuery.of(context).size.width) / 15,
              height: (MediaQuery.of(context).size.height) / 2.4,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  datePad(context),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text('[중식]'),
                  // Text('${mealData?[1]}'),
                  Text(meal[1])
                ],
              ),
            )),
          ],
        ),
      );
    } else if (dayOfWeek == '월') {
      return Row(
        children: [
          buildCard(SizedBox(
            width: ((MediaQuery.of(context).size.width) -
                        (MediaQuery.of(context).size.width) / 15) /
                    2 -
                (MediaQuery.of(context).size.width) / 15,
            height: (MediaQuery.of(context).size.height) / 2.4,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                datePad(context),
                const SizedBox(
                  height: 15,
                ),
                const Text('[중식]'),
                Text(meal[0]),
                const SizedBox(
                  height: 5,
                ),
                const Text('[석식]'),
                Text(meal[1])
              ],
            ),
          )),
        ],
      );
    } else {
      return Row(
        children: [
          buildCard(SizedBox(
            width: ((MediaQuery.of(context).size.width) -
                        (MediaQuery.of(context).size.width) / 15) /
                    2 -
                (MediaQuery.of(context).size.width) / 15,
            height: (MediaQuery.of(context).size.height) / 2.4,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                datePad(context),
                const SizedBox(
                  height: 15,
                ),
                const Text('[중식]'),
                Text(meal[1]),
                const SizedBox(
                  height: 5,
                ),
                const Text('[석식]'),
                Text(meal[2]),
              ],
            ),
          )),
        ],
      );
    }
  }
}

Widget showLoading(context, text, showProcess) {
  return showProcess == true
      ? Padding(
          padding: const EdgeInsets.only(left: 8),
          child: buildCard(SizedBox(
            width: ((MediaQuery.of(context).size.width) -
                        (MediaQuery.of(context).size.width) / 15) /
                    2 -
                (MediaQuery.of(context).size.width) / 15,
            height: (MediaQuery.of(context).size.height) / 2.4,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("$text"),
              const SizedBox(
                height: 10,
              ),
              const Center(child: CircularProgressIndicator()),
            ]),
          )),
        )
      : Padding(
          padding: const EdgeInsets.only(left: 8),
          child: buildCard(SizedBox(
            width: ((MediaQuery.of(context).size.width) -
                        (MediaQuery.of(context).size.width) / 15) /
                    2 -
                (MediaQuery.of(context).size.width) / 15,
            height: (MediaQuery.of(context).size.height) / 2.4,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("$text"),
              const SizedBox(
                height: 10,
              ),
            ]),
          )),
        );
}

Widget datePad(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      OutlinedButton(
        style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black54,
            side: const BorderSide(width: 2.0, color: Colors.black26),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        child: Padding(
            padding: const EdgeInsets.all(1),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Icon(Icons.calendar_month, size: 1080 / 50),
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(formattedDate),
              ],
            )),
        onPressed: () {},
      )
      // const SizedBox(width: ,),
    ],
  );
}
