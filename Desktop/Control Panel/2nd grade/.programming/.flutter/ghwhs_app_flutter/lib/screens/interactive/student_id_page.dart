import 'package:flutter/material.dart';
import 'package:ghwhs_app_flutter/components/widgets/school/student_id.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ghwhs_app_flutter/screens/interactive/login_type_page.dart';
import 'package:ghwhs_app_flutter/screens/interactive/student_edit.dart';

import 'dart:async';

FlutterSecureStorage storage = const FlutterSecureStorage();

class StudentIDPage extends StatefulWidget {
  const StudentIDPage({super.key});

  @override
  State<StudentIDPage> createState() => _StudentIDPageState();
}

class _StudentIDPageState extends State<StudentIDPage> {
  bool isLoggedIn = false; // 로그인 상태를 저장할 변수

  String bDay = '';

  late Timer timer;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      _loadData();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void _loadData() {
    // 앱이 시작될 때 로그인 상태 확인
    fetchDataTeacher();
    setInit();
    setGrade();
    fetchData();
  }

  String name = '';

  String grade1 = '/';
  String grade2 = '/';
  String grade3 = '/';

  String validYearStart = '';
  String validYearEnd = '';

  String studentID = 'S12345';

  void setValidDate(String? birth) {
    if (birth != null) {
      List temp = birth.split('.');

      setState(() {
        validYearStart = (int.parse(temp[0]) + 16).toString();
        validYearEnd = (int.parse(temp[0]) + 16 + 3).toString();
      });
    }
  }

  void setGrade() async {
    String? temp1 = await storage.read(key: 'grade1');
    String? temp2 = await storage.read(key: 'grade2');
    String? temp3 = await storage.read(key: 'grade3');

    setState(() {
      grade1 = '$temp1';
      grade2 = '$temp2';
      grade3 = '$temp3';
    });
  }

  void fetchData() async {
    String? storedName = await storage.read(key: 'name');
    List<String> tempList = [];

    String? storedBday = await storage.read(key: 'bday');

    String? storedID = await storage.read(key: 'studentID');

    if (storedName != null) {
      for (int i = 0; i < storedName.length; i++) {
        tempList.add(storedName[i]);
      }

      setState(() {
        name = tempList as String;
      });
    }
    if (storedBday != null) {
      setState(() {
        bDay = storedBday;
      });
    }

    if (storedID != null) {
      setState(() {
        studentID = storedID;
      });
    }

    setValidDate(bDay);
  }

  Future<void> setInit() async {
    String? teacher = await storage.read(key: 'teacher');
    if (teacher == 'false') {
      String? storedName = await storage.read(key: 'name');
      setState(() {
        name = storedName ?? "No name";
      });
    } else {
      String? storedName = await storage.read(key: 'name');
      setState(() {
        name = storedName ?? 'No name';
      });
    }
  }

  Future<void> checkLoginStatus() async {
    const storage = FlutterSecureStorage();
    String loggedIn = await storage.read(key: 'isLoggedIn') ?? 'false';
    setState(() {
      isLoggedIn = loggedIn == 'true';
    });
  }

  String isTeacher = 'false';

  void fetchDataTeacher() async {
    String? storedStateT = await storage.read(key: 'teacher');

    setState(() {
      isTeacher = storedStateT ?? 'false';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            '모바일 학생증',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff181A20),
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StudentIDEditPage())),
              child: const Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        backgroundColor: const Color(0xff181A20),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
                child: isLoggedIn
                    ? isTeacher == 'false'
                        ? IDCard(
                            storedName: name,
                            storedBday: bDay,
                            grade1: grade1,
                            grade2: grade2,
                            grade3: grade3,
                            storedID: studentID,
                            validYearStart: validYearStart,
                            validYearEnd: validYearEnd,
                          )
                        : const Text(
                            '선생님께는 학생증 기능이 제공되지 않습니다.',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                    : const LogInTypePage())));
  }
}
