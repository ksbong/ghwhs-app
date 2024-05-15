import 'package:flutter/material.dart';
import 'package:ghwhs_app_flutter/utils/na_alert.dart';
import '../../component.dart';

Widget envPoster(context) {
  return GestureDetector(
      onTap: () {
        displayNAAlert(context);
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const EnvPosterPage()));
      },
      child: buildComponent(
          120,
          MediaQuery.of(context).size.width,
          Stack(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 22, bottom: 15),
                    child: Text(
                      '환경포스터',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20, right: 10, top: 10),
                    child: Icon(
                      Icons.arrow_forward,
                      size: 30,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, top: 30),
                child: Row(
                  children: [
                    SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          'assets/earth.png',
                          fit: BoxFit.fill,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '지구를 살려요!',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '환경포스터 보러가기',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )));
}
