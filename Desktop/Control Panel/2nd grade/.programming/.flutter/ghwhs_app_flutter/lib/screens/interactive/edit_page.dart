import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});
  @override
  State createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final TextEditingController _nameController = TextEditingController();

  final List<String> grades = ['1학년', '2학년', '3학년'];
  final List<String> classes = ['1반', '2반', '3반', '4반', '5반'];
  final List<String> numbers = [
    '1번',
    '2번',
    '3번',
    '4번',
    '5번',
    '6번',
    '7번',
    '8번',
    '9번',
    '10번',
    '11번',
    '12번',
    '13번',
    '14번',
    '15번',
    '16번',
    '17번',
    '18번',
    '19번',
    '20번',
    '21번',
    '22번',
    '23번',
    '24번',
    '25번',
    '26번'
  ];
  String selectedGrade = '1학년';
  String selectedClass = '1반';
  String selectedNumber = '1번';

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
            '학생증 정보 수정',
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
              TextField(
                controller: _nameController,
                autocorrect: false,
                cursorColor: Colors.white.withOpacity(0.6),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: '이름을 입력하세요.',
                  hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontWeight: FontWeight.normal,
                      fontSize: 15),
                ),
                cursorRadius: const Radius.circular(20),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ));
  }
}
