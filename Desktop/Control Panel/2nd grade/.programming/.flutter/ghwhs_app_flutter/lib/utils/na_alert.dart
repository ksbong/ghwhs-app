import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

void displayNAAlert(BuildContext context) {
  MotionToast.info(
    title: const Text('알림'),
    description: const Text('아직 지원하지 않은 기능입니다!'),
    dismissable: true,
  ).show(context);
}
