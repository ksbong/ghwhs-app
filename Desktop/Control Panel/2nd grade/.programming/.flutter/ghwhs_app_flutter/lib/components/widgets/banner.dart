import 'package:flutter/material.dart';
import 'package:ghwhs_app_flutter/components/component.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ghwhs_app_flutter/components/widgets/school/timetable.dart';
import 'package:ghwhs_app_flutter/utils/d_day.dart';

class BannerView extends StatefulWidget {
  const BannerView({super.key});

  @override
  State createState() => _Banner();
}

class _Banner extends State<BannerView> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  late List<Widget> imageList;

  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    imageList = [
      buildComponent(
          150,
          MediaQuery.of(context).size.width,
          Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text(
                  '${now.year + 1}학년도 수능',
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                ),
                Text(
                  'D${getSNDday()}',
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                )
              ]))),
      GestureDetector(
        /**
         *  Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TimeTablePage()))
         */
        //onTap: () => displayNAAlert(context),
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TimeTable())),
        child: buildComponent(
            150,
            MediaQuery.of(context).size.width,
            const Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                  size: 40,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '시간표 보러 가기',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      '오늘 들을 수업은?',
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    )
                  ],
                )
              ],
            ))),
      ),

      // buildComponent(
      //     150,
      //     MediaQuery.of(context).size.width,
      //     Center(
      //         child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         const Text(
      //           '정기고사',
      //           style: TextStyle(color: Colors.white, fontSize: 30),
      //         ),
      //         Text(
      //           'D${getTestDday()}',
      //           style: const TextStyle(color: Colors.white, fontSize: 30),
      //         )
      //       ],
      //     )))
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
            }));
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
                width: 8,
                height: 8,
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
