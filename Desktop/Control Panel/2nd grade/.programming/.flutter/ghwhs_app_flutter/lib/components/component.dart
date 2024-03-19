import 'package:flutter/material.dart';

Widget buildComponent(double height, double width, Widget content) {
  return Card(
    elevation: 1.5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: const BorderSide(
      color: Color(0xff232529),
    )),
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff232529),
        ),
        color: const Color(0xff232529),
        borderRadius: BorderRadius.circular(20),
      ),
      child: content,
    ),
  );
}
