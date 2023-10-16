import 'dart:convert';

import 'package:covid/model/wroldstate.dart';
import 'package:covid/url.dart';
import 'package:http/http.dart' as http;

class SateService {
  Future<WorldStateModel> fetchworldstaterocrd() async {
    final respone = await http.get(Uri.parse(AppUrl.worldstateurl));
    if (respone.statusCode == 200) {
      var json = jsonDecode(respone.body);
      return WorldStateModel.fromJson(json as Map<String, dynamic>);
    } else {
      throw Exception("error");
    }
  }

  Future<List<dynamic>> fetchcontries() async {
    var data;
    final respone = await http.get(Uri.parse(AppUrl.countriesList));

    if (respone.statusCode == 200) {
      data = jsonDecode(respone.body);
      return data;
    } else {
      throw Exception("error");
    }
  }
}
