import 'package:flutter/material.dart';

import 'dart:async';

import 'package:in_app_update/in_app_update.dart';

import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:ghwhs_app_flutter/components/widgets/banner.dart';
import 'package:ghwhs_app_flutter/components/widgets/env/env_poster.dart';
import 'package:ghwhs_app_flutter/components/widgets/env/fine_dust.dart';
import 'package:ghwhs_app_flutter/components/widgets/school/meal_board.dart';
import 'package:ghwhs_app_flutter/components/widgets/school/student_id.dart';
import 'package:ghwhs_app_flutter/components/widgets/env/plant_management.dart';
import 'view/info_page.dart';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _advancedDrawerController = AdvancedDrawerController();

  @override
  void initState() {
    super.initState();
    checkForUpdate();
  }

  Future<void> checkForUpdate() async {
    debugPrint('checking for Update');
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        if (info.updateAvailability == UpdateAvailability.updateAvailable) {
          debugPrint('update available');
          update();
        }
      });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  void update() async {
    debugPrint('Updating');
    await InAppUpdate.startFlexibleUpdate();
    InAppUpdate.completeFlexibleUpdate().then((_) {}).catchError((e) {
      debugPrint(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color(0xff232529),
              Color(0xff181A20),
            ])),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16))),
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
                    color: Colors.black26, shape: BoxShape.circle),
                child: Image.asset('assets/ghwhs.png', fit: BoxFit.fill,),
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
      child: Scaffold(
          backgroundColor: const Color(0xff181A20),
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: SafeArea(
                child: Container(
                  decoration: const BoxDecoration(color: Color(0xff181A20)),
                  child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/ghwhs.png'),
                              Image.asset('assets/ghwhs_title.png')
                            ],
                          ),
                          Positioned(
                            left: 10.0,
                            child: IconButton(
                              icon: const Icon(
                                Icons.menu,
                                size: 40,
                              ), // You can change the icon
                              onPressed: () {
                                // Handle button press
                                // For example, you can open the drawer
                                _advancedDrawerController.showDrawer();
                              },
                            ),
                          ),
                          // if we need icon button for side drawer
                        ],
                      )),
                ),
              )),
          body: Center(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                studentID(context),
                const SizedBox(
                  height: 10,
                ),
                const BannerView(),
                const SizedBox(
                  height: 10,
                ),
                const FineDust(),
                const SizedBox(
                  height: 10,
                ),
                const MealBoard(),
                const SizedBox(
                  height: 10,
                ),
                const PlantManage(),
                const SizedBox(
                  height: 10,
                ),
                envPoster(context),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ))),
    );
  }
}
