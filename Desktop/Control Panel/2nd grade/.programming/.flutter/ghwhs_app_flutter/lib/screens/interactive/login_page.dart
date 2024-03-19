import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ghwhs_app_flutter/screens/home_page.dart';
import 'package:ghwhs_app_flutter/screens/interactive/barcode_scan_page.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:motion_toast/motion_toast.dart';

import 'package:shake_animation_widget/shake_animation_widget.dart';

const storage = FlutterSecureStorage();

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool teacher = false;

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

  DateTime selectedDate = DateTime.now();

  String studentID = '학생증을 등록하면 여기에 학생증 코드가 표시됩니다.';

  String bday = '생년월일을 선택하면 여기에 표시됩니다.';

  bool autoPlay = false;
  final TextEditingController _nameController = TextEditingController();

  final ShakeAnimationController _shakeAnimationController1 =
      ShakeAnimationController();
  final ShakeAnimationController _shakeAnimationController2 =
      ShakeAnimationController();

  final ShakeAnimationController _shakeAnimationController3 =
      ShakeAnimationController();

  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      _loadStoredData();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  _loadStoredData() async {
    String? value = await storage.read(key: 'studentID');
    setState(() {
      studentID = value ?? '학생증을 등록하면 여기에 학생증 코드가 표시됩니다.';
    });
  }

  checkLogin() async {
    if (teacher) {
      // 등록자가 선생님일 경우
      await storage.write(key: 'isLoggedIn', value: 'true');
      await storage.write(key: 'teacher', value: 'true');

      // test code
      await storage.write(key: 'name', value: _nameController.text);

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
    } else {
      // 등록자가 학생일 경우
      setState(() {
        autoPlay = true;
      });
      if (_shakeAnimationController1.animationRunging) {
        _shakeAnimationController1.stop();
        _shakeAnimationController2.stop();
      }
      if (_nameController.text == '' ||
          studentID == '학생증을 등록하면 여기에 학생증 코드가 표시됩니다.') {
        if (_nameController.text == '') {
          _shakeAnimationController1.start(shakeCount: 1);
        }
        if (studentID == '학생증을 등록하면 여기에 학생증 코드가 표시됩니다.') {
          Future.delayed(const Duration(milliseconds: 100),
              () => _shakeAnimationController2.start(shakeCount: 1));
        }
        _displayWarningMotionToast('아직 입력되지 않은게 있어요!', '다시 한번 확인해 주세요.');
      } else {
        await storage.write(key: 'name', value: _nameController.text);
        await storage.write(key: 'teacher', value: 'false');

        await storage.write(
            key: 'bday',
            value:
                '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}');

        // await storage.write(key: 'grade', value: selectedGrade);
        // await storage.write(key: 'class', value: selectedClass);
        String grade = selectedGrade.replaceAll('학년', '');
        if (grade == '1') {
          await storage.write(
              key: 'grade1',
              value:
                  '${selectedClass.replaceAll('반', '')}/${selectedNumber.replaceAll('번', '')}');
        } else if (grade == '2') {
          await storage.write(
              key: 'grade2',
              value:
                  '${selectedClass.replaceAll('반', '')}/${selectedNumber.replaceAll('번', '')}');
        } else {
          await storage.write(
              key: 'grade3',
              value:
                  '${selectedClass.replaceAll('반', '')}/${selectedNumber.replaceAll('번', '')}');
        }

        await storage.write(key: 'number', value: selectedNumber);
        await storage.write(key: 'studentID', value: studentID);

        await storage.write(key: 'isLoggedIn', value: 'true');

        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    }
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
          backgroundColor: const Color(0xff181A20),
          elevation: 0,
          title: const Text(
            '학생정보',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ShakeAnimationWidget(
                shakeAnimationController: _shakeAnimationController1,
                shakeAnimationType: ShakeAnimationType.LeftRightShake,
                isForward: false,
                shakeRange: 0.2,
                child: TextField(
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
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  // 학년
                  Flexible(
                    flex: 1,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: const Row(
                          children: [
                            Icon(
                              Icons.list,
                              size: 16,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Select Item',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: grades
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffA3A3A6),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: selectedGrade,
                        onChanged: (String? value) {
                          setState(() {
                            selectedGrade = value!;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 55,
                          width: MediaQuery.of(context).size.width / 3,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xffA3A3A6),
                            ),
                            color: const Color(0xff181A20),
                          ),
                          elevation: 2,
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                          iconSize: 14,
                          iconEnabledColor: Color(0xff6E6A74),
                          iconDisabledColor: Colors.grey,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xff181A20),
                          ),
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(20),
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility:
                                MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),

                  // 반
                  Flexible(
                    flex: 1,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: const Row(
                          children: [
                            Icon(
                              Icons.list,
                              size: 16,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Select Item',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: classes
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffA3A3A6),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: selectedClass,
                        onChanged: (String? value) {
                          setState(() {
                            selectedClass = value!;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 55,
                          width: MediaQuery.of(context).size.width / 3,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xffA3A3A6),
                            ),
                            color: const Color(0xff181A20),
                          ),
                          elevation: 2,
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                          iconSize: 14,
                          iconEnabledColor: Color(0xff6E6A74),
                          iconDisabledColor: Colors.grey,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xff181A20),
                          ),
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(20),
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility:
                                MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),

                  // 번호
                  Flexible(
                    flex: 1,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: const Row(
                          children: [
                            Icon(
                              Icons.list,
                              size: 16,
                              color: Colors.yellow,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: Text(
                                'Select Item',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        items: numbers
                            .map((String item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffA3A3A6),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                            .toList(),
                        value: selectedNumber,
                        onChanged: (String? value) {
                          setState(() {
                            selectedNumber = value!;
                          });
                        },
                        buttonStyleData: ButtonStyleData(
                          height: 55,
                          width: MediaQuery.of(context).size.width / 3,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xffA3A3A6),
                            ),
                            color: const Color(0xff181A20),
                          ),
                          elevation: 2,
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                          iconSize: 14,
                          iconEnabledColor: Color(0xff6E6A74),
                          iconDisabledColor: Colors.grey,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xff181A20),
                          ),
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all<double>(6),
                            thumbVisibility:
                                MaterialStateProperty.all<bool>(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // 생년월일
              const SizedBox(
                height: 20,
              ),

              ShakeAnimationWidget(
                  shakeAnimationController: _shakeAnimationController3,
                  shakeAnimationType: ShakeAnimationType.LeftRightShake,
                  isForward: false,
                  shakeRange: 0.2,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xffA3A3A6)),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 50,
                            child: Center(
                              child: Text(
                                '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
                                style:
                                    const TextStyle(color: Color(0xffA3A3A6)),
                              ),
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 4,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all(
                                    const Size(60, 50))),
                            onPressed: !teacher
                                ? () async {
                                    final DateTime? dateTime =
                                        await showDatePicker(
                                            context: context,
                                            initialDate: selectedDate,
                                            firstDate: DateTime(
                                                DateTime.now().year - 18),
                                            lastDate: DateTime(
                                                DateTime.now().year - 18 + 2));
                                    if (dateTime != null) {
                                      setState(() {
                                        selectedDate = dateTime;
                                      });
                                    }
                                  }
                                : null,
                            child: const Text("생일선택")),
                      )
                    ],
                  )),

              const SizedBox(
                height: 20,
              ),
              ShakeAnimationWidget(
                shakeAnimationController: _shakeAnimationController2,
                shakeAnimationType: ShakeAnimationType.LeftRightShake,
                isForward: false,
                shakeRange: 0.2,
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xffA3A3A6)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 60,
                    child: Center(
                      child: Text(
                        studentID,
                        style: const TextStyle(color: Color(0xffA3A3A6)),
                      ),
                    )),
              ),

              const SizedBox(
                height: 20,
              ),

              // 학생증 등록 feature
              ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width, 45))),
                  onPressed: !teacher
                      ? () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const QrScanPage()));
                        }
                      : null,
                  child: const Text("학생증 등록하기")),
              const SizedBox(
                height: 10,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text(
              //       '선생님이신가요?',
              //       style: TextStyle(
              //           color: Colors.white.withOpacity(0.6),
              //           fontWeight: FontWeight.normal,
              //           fontSize: 15),
              //     ),
              //     const SizedBox(
              //       width: 10,
              //     ),
              //     Checkbox(
              //         value: teacher,
              //         onChanged: (newValue) {
              //           setState(() {
              //             teacher = newValue as bool;
              //           });
              //         })
              //   ],
              // ),
              //
              // const SizedBox(
              //   height: 10,
              // ),

              ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width, 45))),
                  child: const Text('등록하기'),
                  onPressed: () => checkLogin()),
            ],
          ),
        ));
  }

  void _displayWarningMotionToast(String title, String description) {
    MotionToast.warning(
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(description),
      animationCurve: Curves.ease,
      borderRadius: 13,
      animationDuration: const Duration(milliseconds: 1000),
      dismissable: true,
    ).show(context);
  }
}
