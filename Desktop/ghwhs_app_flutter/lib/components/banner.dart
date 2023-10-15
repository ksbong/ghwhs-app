// ignore_for_file: use_key_in_widget_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../components/quizPage.dart';
import '../builder/buildCard.dart';
import '../builder/d_day.dart';

class BannerView extends StatefulWidget {
  @override
  State createState() => _Banner();
}

class _Banner extends State<BannerView> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<Widget> imageList = [];
  @override
  Widget build(BuildContext context) {
    Widget _banner(Widget child) {
      return buildCard(SizedBox(
        width: MediaQuery.of(context).size.width -
            (MediaQuery.of(context).size.width) / 15,
        child: child,
      ));
    }

    imageList = [
      _banner(FutureBuilder(
          future: getSNDate(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('수능 D-${snapshot.data}',
                        style: const TextStyle(fontSize: 40)),
                    const Text(
                      '\n',
                      style: TextStyle(fontSize: 4),
                    ),
                    const Text('전국 수험생들을 응원합니다.')
                  ],
                ))
                : const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Loading..."),
                    SizedBox(
                      height: 10,
                    ),
                    Center(child: CircularProgressIndicator()),
                  ],
                ));
          })),
      _banner(Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildDday(),
              const Text(
                '\n',
                style: TextStyle(fontSize: 4),
              ),
              const Text('광혜원고 학생들을 응원합니다.')
            ],
          ))),
      _banner(Center(
          child: GestureDetector(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => const QuizPage())),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('환경문제 도전하기', style: TextStyle(fontSize: 40)),
                Text(
                  '\n',
                  style: TextStyle(fontSize: 4),
                ),
                Text('환경동아리가 만든 퀴즈')
              ],
            ),
          )))
    ];

    return Stack(
      children: [sliderWidget(), sliderIndicator()],
    );
  }

  Widget sliderWidget() {
    return CarouselSlider(
      carouselController: _controller,
      items: imageList.toList(),
      options: CarouselOptions(
          height: 150,
          viewportFraction: 1.0,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 4),
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          }),
    );
  }

  Widget sliderIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12,
                height: 12,
                margin:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList()),
    );
  }
}
