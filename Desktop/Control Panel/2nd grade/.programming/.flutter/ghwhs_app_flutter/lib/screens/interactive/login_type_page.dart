import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ghwhs_app_flutter/screens/home_page.dart';
import 'package:ghwhs_app_flutter/screens/interactive/login_page.dart';

FlutterSecureStorage storage = const FlutterSecureStorage();

class LogInTypePage extends StatefulWidget {
  const LogInTypePage({super.key});

  @override
  State createState()=> _LogInTypePageState();
}

class _LogInTypePageState extends State<LogInTypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff181A20),
        // appBar: AppBar(
        //   backgroundColor: const Color(0xff181A20),
        //   elevation: 0,
        //   title: const Text(
        //     '로그인 타입',
        //     style: TextStyle(color: Colors.white),
        //   ),
        //   centerTitle: true,
        // ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('로그인 유형을 선택해 주세요',style: TextStyle(color: Colors.white),),
           const SizedBox(height: 10,),

           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               ElevatedButton(onPressed: ()=>showTeacherLogInDialog(context) , child: const Text('선생님')),
               const SizedBox(width: 10,),
               ElevatedButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> const LogInPage())), child: const Text('학생'))
             ],
           ),],
        )
    );
  }
}

Future<void> showTeacherLogInDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('잠깐!'),
        content: const SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  title: Text('주의사항'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('선생님은 기본적인 로그인 절차를 거치지 않습니다.'),
                      Text('학생증 기능이 제공되지 않습니다.')
                    ],
                  ),
                ),
              ],
            )),
        actions: <Widget>[
          TextButton(
            child: const Text('선생님으로 로그인'),
            onPressed: () async {
              // 등록자가 선생님일 경우
              await storage.write(key: 'isLoggedIn', value: 'true');
              await storage.write(key: 'teacher', value: 'true');

              // test code
              await storage.write(key: 'name', value: 'teacher');

              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
            },
          ),
        ],
      );
    },
  );
}
