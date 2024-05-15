import 'package:flutter/material.dart';
import 'package:flutter_beep/flutter_beep.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:motion_toast/motion_toast.dart';

const storage = FlutterSecureStorage();

class QrScanPage extends StatefulWidget {
  const QrScanPage({super.key});

  @override
  State createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  String? _qrInfo = '스캔하세요';
  bool _canVibrate = true;
  // ignore: unused_field
  bool _camState = false;

  bool _isFunctionExecuted = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isFunctionExecuted = false;
    });
    _init();
  }

  /// 초기화 함수
  _init() async {
    bool canVibrate = await Vibrate.canVibrate;
    setState(() {
      // QR 코드 스캔 관련
      _camState = true;

      // 진동 관련
      _canVibrate = canVibrate;
      _canVibrate
          ? debugPrint('This device can vibrate')
          : debugPrint('This device cannot vibrate');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  _notIDCard() {
    if (!_isFunctionExecuted) {
      FlutterBeep.beep();
      if (_canVibrate) Vibrate.feedback(FeedbackType.heavy);
      _displayErrorMotionToast('학생증 맞나요?', '학생증이 아닌 것 같아요...');

      setState(() {
        _isFunctionExecuted = true;
      });
    }
  }

  /// QR/Bar Code 스캔 성공시 호출
  _qrCallback(String? code) async {
    if (code?[0] == 'S') {
      setState(() {
        // 동일한걸 계속 읽을 경우 한번만 소리/진동 실행..
        if (code != _qrInfo) {
          FlutterBeep.beep(); // 비프음
          if (_canVibrate) Vibrate.feedback(FeedbackType.heavy); // 진동
        }
        _camState = false;
        _qrInfo = code;
      });
    } else {
      _notIDCard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff181A20),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            '학생증 바코드 인식',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff181A20),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 500,
              width: 500,
              child: QRBarScannerCamera(
                // 에러 발생시..
                onError: (context, error) => Text(
                  error.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
                // QR 이 읽혔을 경우
                qrCodeCallback: (code) {
                  _qrCallback(code);
                },
              ),
            ),

            /// 사이즈 자동 조절을 위해 FittedBox 사용
            FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  _qrInfo!,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )),
            ElevatedButton(
              onPressed: () {
                _registID(_qrInfo);
                Navigator.pop(context);
              },
              child: const Text('확인'),
            ),
          ],
        ));
  }

  void _registID(String? id) async {
    await storage.write(key: 'studentID', value: id);
  }

  void _displayErrorMotionToast(String title, String description) {
    MotionToast.error(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      description: Text(description),
      position: MotionToastPosition.top,
      barrierColor: Colors.black.withOpacity(0.3),
      width: 300,
      height: 80,
      dismissable: true,
    ).show(context);
  }
}
