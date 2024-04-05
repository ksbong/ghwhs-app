import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  String version = '2.1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff181A20),
        appBar: AppBar(
          backgroundColor: const Color(0xff181A20),
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
            '앱 정보',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              ListTile(
                title: const Text(
                  '앱 버전',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  version,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 149, 156, 149)),
                ),
              ),
              ListTile(
                onTap: () => showDevDialog(context),
                title: const Text(
                  '개발자 정보',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: const Text(
                  '자세히 보기',
                  style: TextStyle(color: Color.fromARGB(255, 149, 156, 149)),
                ),
              ),
              const ListTile(
                title: Text(
                  'License',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  '이 앱의 저작권은 광혜원고등학교에 있습니다.',
                  style: TextStyle(color: Color.fromARGB(255, 149, 156, 149)),
                ),
              )
            ],
          ),
        ));
  }
}

Future<void> showDevDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('개발자 정보'),
        content: SingleChildScrollView(
            child: Column(
          children: [
            ListTile(
              title: const Text('프로그래밍'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _a('2022 입학생  김상봉', 'https://www.instagram.com/sanggnob/'),
                  // _a('2022 입학생 배진우',
                  //     'https://www.instagram.com/shipjinwoo_/')
                  // _a('2022 입학생 김민승 (일부)',
                  //     'https://www.instagram.com/kimxins_/')
                ],
              ),
            ),
            ListTile(
              title: const Text('디자인'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _a('2022 입학생  정수찬 (v2.0)',
                      'https://www.instagram.com/wjd._sxh06/'),
                  _a('2022 입학생  김하영 (v1.0)',
                      'https://www.instagram.com/khy.006/')
                ],
              ),
            ),
          ],
        )),
        actions: <Widget>[
          TextButton(
            child: const Text('창닫기'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Widget _a(String title, String url) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title),
      IconButton(
        onPressed: () => launchUrl(Uri.parse(url)),
        icon: const Icon(FontAwesomeIcons.instagram),
      ),
    ],
  );
}
