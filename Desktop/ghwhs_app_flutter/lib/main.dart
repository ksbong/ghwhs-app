import 'package:flutter/material.dart';
import '../components/sideMenu.dart';
import '../components/poster.dart';
import '../components/fineDust.dart';
import '../components/banner.dart';
import 'components/mealBoard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: '광혜원고등학교',
    debugShowCheckedModeBanner: false,
    home: const MyApp(),
    theme: ThemeData(
        fontFamily: 'Jua',
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.white,
        )),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State createState() => GHWHS();
}

class GHWHS extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // D-day

    return advancedDrawer(
        context,
        Scaffold(
            appBar: AppBar(
              title: Center(
                child: Image.asset(
                  'title_logo.png',
                  scale: 4.6,
                ),
              ),
              backgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  BannerView(),
                  const GuageApp(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const MealBoard(),
                      SizedBox(
                        width: (MediaQuery.of(context).size.width) / 15,
                      ),
                      const PosterPage(),
                    ],
                  ),
                ],
              ),
            )));
  }
}
