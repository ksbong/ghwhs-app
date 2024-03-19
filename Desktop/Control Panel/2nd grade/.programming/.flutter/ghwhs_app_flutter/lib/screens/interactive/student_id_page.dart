import 'package:flutter/material.dart';
import 'package:ghwhs_app_flutter/components/widgets/school/student_id.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ghwhs_app_flutter/screens/interactive/login_type_page.dart';
import 'package:ghwhs_app_flutter/screens/interactive/student_edit.dart';

FlutterSecureStorage storage = const FlutterSecureStorage();

class StudentIDPage extends StatefulWidget {
  const StudentIDPage({super.key});

  @override
  State<StudentIDPage> createState() => _StudentIDPageState();
}

class _StudentIDPageState extends State<StudentIDPage> {

  bool isLoggedIn = false; // 로그인 상태를 저장할 변수

  @override
  void initState() {
    super.initState();
    checkLoginStatus(); // 앱이 시작될 때 로그인 상태 확인
    fetchDate();
  }

  Future<void> checkLoginStatus() async {
    const storage = FlutterSecureStorage();
    String loggedIn = await storage.read(key: 'isLoggedIn') ?? 'false';
    setState(() {
      isLoggedIn = loggedIn == 'true';
    });
  }

  String isTeacher = 'false';

  void fetchDate() async {
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
                child: isLoggedIn? isTeacher == 'false'
                    ? const IDCard()
                    : const Text(
                  '선생님께는 학생증 기능이 제공되지 않습니다.',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ):const LogInTypePage() )));
  }
}
