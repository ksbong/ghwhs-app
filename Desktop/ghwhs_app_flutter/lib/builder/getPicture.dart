// ignore_for_file: file_names

import 'package:http/http.dart' as http;
import 'dart:convert';

Future getPicture(picName) async {
  final url = Uri.parse(
      'https://firebasestorage.googleapis.com/v0/b/hwandong-1cdba.appspot.com/o/$picName.png');
  late String json;
  var response = await http.get(url);

  if (response.statusCode == 200) {
    json = response.body;
    Map<String, dynamic> data = jsonDecode(json);
    String imgUrl =
        'https://firebasestorage.googleapis.com/v0/b/hwandong-1cdba.appspot.com/o/$picName.png?alt=media&token=${data['downloadTokens']}';

    return imgUrl;
  }
}
