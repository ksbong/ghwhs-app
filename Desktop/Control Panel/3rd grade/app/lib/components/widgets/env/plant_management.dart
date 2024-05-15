import 'package:flutter/material.dart';
import 'package:ghwhs_app_flutter/utils/na_alert.dart';
import '../../component.dart';
// import 'package:http/http.dart' as http;

class PlantManage extends StatefulWidget {
  const PlantManage({super.key});

  @override
  State createState() => _PlantManageState();
}

class _PlantManageState extends State<PlantManage> {
  // @override
  // void initState() {
  //   super.initState();
  //   timer = Timer.periodic(const Duration(seconds: 2), (Timer t) {
  //     fetchData();
  //   });
  // }

  // @override
  // void dispose() {
  //   timer.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => displayNAAlert(context),
        child: buildComponent(
            120,
            MediaQuery.of(context).size.width,
            Stack(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 22, bottom: 15),
                      child: Text(
                        '화분관리',
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
                  padding: const EdgeInsets.only(left: 25, top: 30),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                            'assets/plant.png',
                            fit: BoxFit.fill,
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '화분을 가꾸어요!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '화분 상태 보러가기',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            )));
  }

  // Widget renderFineDust() {
  //   // fetchData();
  //   return Text(
  //     fineDust,
  //     style: const TextStyle(
  //       color: Colors.white,
  //       fontSize: 50,
  //     ),
  //   );
  // }

  Future<void> fetchData() async {
    // String databaseURL =
    //     'https://hwandong-1cdba-default-rtdb.asia-southeast1.firebasedatabase.app';

    // // Make a GET request to fetch data
    // final response = await http.get(Uri.parse('$databaseURL/미세먼지.json'));

    // if (response.statusCode == 200) {
    //   // Parse the response body
    //   // print(response.body);
    //   // print(response.body.runtimeType);

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
  }
}
