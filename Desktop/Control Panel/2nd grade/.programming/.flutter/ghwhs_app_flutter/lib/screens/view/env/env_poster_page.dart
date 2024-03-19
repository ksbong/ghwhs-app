import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EnvPosterPage extends StatefulWidget {
  const EnvPosterPage({super.key});

  @override
  State createState() => _EnvPosterState();
}

class _EnvPosterState extends State<EnvPosterPage> {
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
      debugPrint(imgUrl);
      return imgUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff181A20),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            '환경포스터',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff181A20),
          elevation: 0,
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder(
              future: getPoster(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Expanded(
                        child: Image.network(
                        snapshot.data,
                        fit: BoxFit.cover,
                      ))
                    : const CircularProgressIndicator();
              },
            )));
  }
}
