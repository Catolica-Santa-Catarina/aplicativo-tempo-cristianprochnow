import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:tempo_template/models/location.dart';

class NetworkHelper {
  String url;

  NetworkHelper(this.url);

  Future getData() async {
    var url = Uri.parse(this.url);
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = jsonDecode(data);

      return decodedData;
    } else {
      stderr.writeln(response);
    }
  }
}