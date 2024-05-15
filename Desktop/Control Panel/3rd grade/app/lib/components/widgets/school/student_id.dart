// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, use_key_in_widget_constructors
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import '../../component.dart';
import '../../../screens/interactive/student_id_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

class IDCard extends StatefulWidget {
  final storedName;
  final storedBday;
  final storedID;
  final grade1;
  final grade2;
  final grade3;

  final validYearStart;
  final validYearEnd;

  const IDCard(
      {super.key,
      @required this.storedName,
      @required this.storedBday,
      @required this.storedID,
      @required this.grade1,
      @required this.grade2,
      @required this.grade3,
      @required this.validYearStart,
      @required this.validYearEnd});

  @override
  State createState() => IDCardState();
}

class IDCardState extends State<IDCard> {
  final cong = GestureFlipCardController();

  @override
  Widget build(BuildContext context) {
    return GestureFlipCard(
        enableController: true,
        controller: cong,
        animationDuration: const Duration(milliseconds: 800),
        axis: FlipAxis.vertical,
        frontWidget: Center(
            child: FrontPart(
          name: widget.storedName,
        )),
        backWidget: Center(
            child: BackPart(
          bday: widget.storedBday,
          grade1: widget.grade1,
          grade2: widget.grade2,
          grade3: widget.grade3,
          name: widget.storedName,
          studentID: widget.storedID,
          validYearStart: widget.validYearStart,
          validYearEnd: widget.validYearEnd,
        )));
  }
}

class FrontPart extends StatefulWidget {
  final name;
  const FrontPart({super.key, @required this.name});

  @override
  State<FrontPart> createState() => _FrontPartState();
}

class _FrontPartState extends State<FrontPart> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(10.0)),
        width: 260,
        height: 400,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                Container(
                  height: 40,
                  color: const Color(0xff0f41a3),
                ),
                const Center(
                  child: Text(
                    '학 생 증',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18.0),
                      child: Image.asset(
                        'assets/ghwhs.png',
                        height: 175,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.name,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 22,
            ),
            Stack(
              children: [
                Container(
                  height: 45,
                  decoration: const BoxDecoration(
                      color: Color(0xff0f41a3),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8))),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/logo.png'),
                      Image.asset('assets/name.png')
                    ],
                  ),
                ))
              ],
            ),
          ],
        ));
  }
}

class BackPart extends StatefulWidget {
  final name;
  final validYearStart;
  final validYearEnd;
  final grade1;
  final grade2;
  final grade3;
  final bday;
  final studentID;

  const BackPart(
      {super.key,
      @required this.name,
      @required this.bday,
      @required this.validYearStart,
      @required this.validYearEnd,
      @required this.grade1,
      @required this.grade2,
      @required this.grade3,
      @required this.studentID});

  @override
  State createState() => _BackPartState();
}

class _BackPartState extends State<BackPart> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(10.0)),
        width: 260,
        height: 400,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Opacity(
              opacity: 0.2,
              child: Image.asset(
                'assets/student_id_bg.jpg',
                height: 220,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '성       명: ${widget.name[0] ?? ''} ${widget.name[1] ?? ''} ${widget.name[2] ?? ''}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '생년월일: ${widget.bday}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '유효기간: ${widget.validYearStart}.03.01.~${widget.validYearEnd}.02.28.',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const Text(
                  '위 사람은 본교 학생임을 증명함.',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 25,
                ),
                Table(
                  columnWidths: const {
                    0: FixedColumnWidth(30.0),
                    1: FixedColumnWidth(60.0),
                    2: FixedColumnWidth(60.0),
                    3: FixedColumnWidth(60.0)
                  },
                  border: TableBorder.all(),
                  children: <TableRow>[
                    TableRow(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                          child: buildTableCell('학년'),
                        ),
                        SizedBox(
                          height: 20,
                          child: buildTableCell('1 학년'),
                        ),
                        SizedBox(
                          height: 20,
                          child: buildTableCell('2 학년'),
                        ),
                        SizedBox(
                          height: 20,
                          child: buildTableCell('3 학년'),
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        SizedBox(
                          height: 35,
                          child: buildTableCell('반/번'),
                        ),
                        SizedBox(
                          height: 35,
                          child: buildTableCell(widget.grade1),
                        ),
                        SizedBox(
                          height: 35,
                          child: buildTableCell(widget.grade2),
                        ),
                        SizedBox(
                          height: 35,
                          child: buildTableCell(widget.grade3),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '광 혜 원 고 등 학 교 장',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text('직인 생략'),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '충청북도 진천군 광혜원면 덕성산로 56',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'TEL: 043-535-8433',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                    height: 80,
                    width: 150,
                    child: BarcodeWidget(
                        data: widget.studentID, barcode: Barcode.code128()))
              ],
            )
          ],
        ));
  }
}

Widget buildTableCell(String text) {
  return Container(
    padding: const EdgeInsets.only(bottom: 2),
    child: Center(
      child: Text(
        text,
        style: const TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget studentID(context) {
  return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const StudentIDPage()));
      },
      child: buildComponent(
        70,
        MediaQuery.of(context).size.width,
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.person,
                color: Color(0xff777C89),
                size: 50,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '학생증? 이제 가지고 다니지 마세요',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    '전자 학생증 보러가기',
                    style: TextStyle(color: Color(0xff0075ff)),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, right: 10),
              child: Icon(
                Icons.arrow_forward,
                size: 30,
                color: Colors.white,
              ),
            )
          ],
        ),
      ));
}
