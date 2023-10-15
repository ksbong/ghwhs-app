// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/infoPage.dart';
import '../builder/getPicture.dart';

Widget advancedDrawer(context, child) {
  final advancedDrawerController = AdvancedDrawerController();

  //https://firebasestorage.googleapis.com/v0/b/hwandong-1cdba.appspot.com/o/ghwhs_logo.png?alt=media&token=58067a75-6a14-48f7-9d6e-b88a78e39d87
  return AdvancedDrawer(
    backdrop: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue,
                Colors.white,
              ])),
    ),
    controller: advancedDrawerController,
    animationCurve: Curves.easeInOut,
    animationDuration: const Duration(milliseconds: 300),
    animateChildDecoration: true,
    rtlOpening: false,
    disabledGestures: false,
    childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16))),
    child: child,
    drawer: SafeArea(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(top: 24.0, bottom: 64.0),
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: FutureBuilder(
                  future: getPicture('ghwhs_logo'),
                  builder: (context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? Image.network(
                      snapshot.data,
                      fit: BoxFit.fill,
                    )
                        : const CircularProgressIndicator();
                  },
                )
              //Image.asset('ghwhs.png', fit: BoxFit.fill,)
            ),
            ListTile(
              onTap: () => launchUrl(
                  Uri.parse('https://school.cbe.go.kr/ghw-h/M010705/')),
              leading: const Icon(Icons.calendar_today),
              title: const Text('학사일정 바로가기'),
            ),
            ListTile(
              onTap: () => launchUrl(
                  Uri.parse('https://school.cbe.go.kr/ghw-h/M01100318/')),
              leading: const Icon(Icons.school),
              title: const Text('학습자료실'),
            ),
            ListTile(
              onTap: () => launchUrl(
                  Uri.parse('https://www.youtube.com/@user-ds5mn2lz4v')),
              leading: const Icon(EvaIcons.video),
              title: const Text('광혜원고 유튜브'),
            ),
            ListTile(
              onTap: () =>
                  launchUrl(Uri.parse('https://www.instagram.com/ghwhs.sc/')),
              leading: const Icon(Icons.photo_camera),
              title: const Text('학생회 인스타'),
            ),
            ListTile(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const InfoPage())),
              leading: const Icon(Icons.info_outline),
              title: const Text('앱 정보'),
            )
          ],
        ),
      ),
    ),
  );
}
