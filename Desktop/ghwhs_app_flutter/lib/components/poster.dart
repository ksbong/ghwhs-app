import 'package:flutter/material.dart';
import '../builder/buildCard.dart';
import '../components/mealBoard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// https://firebasestorage.googleapis.com/v0/b/hwandong-1cdba.appspot.com/o/poster%2{파일 이름.확장자} => json 정보
// https://firebasestorage.googleapis.com/v0/b/hwandong-1cdba.appspot.com/o/poster%2{파일 이름.확장자}?alt=media&token={다운로드 토큰}

Future getPoster() async {
  final url = Uri.parse(
      'https://firebasestorage.googleapis.com/v0/b/hwandong-1cdba.appspot.com/o/poster%2Fposter.png');
  late String json;
  var response = await http.get(url);

  if (response.statusCode == 200) {
    json = response.body;
    Map<String, dynamic> data = jsonDecode(json);
    String imgUrl =
        'https://firebasestorage.googleapis.com/v0/b/hwandong-1cdba.appspot.com/o/poster%2Fposter.png?alt=media&token=${data['downloadTokens']}';

    return imgUrl;
  }
}

class PosterPage extends StatefulWidget {
  const PosterPage({super.key});

  @override
  State<PosterPage> createState() => _PosterPageState();
}

class _PosterPageState extends State<PosterPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPoster(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? buildCard(SizedBox(
              width: ((MediaQuery.of(context).size.width) -
                  (MediaQuery.of(context).size.width) / 15) /
                  2 -
                  (MediaQuery.of(context).size.width) / 15,
              height: (MediaQuery.of(context).size.height) / 2.4,
              child: Image.network(snapshot.data)))
              : showLoading(context, "로딩중인겨~", true);
        });
  }
}
