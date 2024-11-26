import 'dart:convert';
import 'package:http/http.dart' as http;

import '../user_model/user_model.dart';

class UserRepository {

  Future getUsers(int pageNumber) async {
    final String userUrl = "https://reqres.in/api/users?page=$pageNumber";
    var response = await http.get(Uri.parse(userUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      try {
        final List<Data> data = [];
        var result = jsonDecode(response.body);
        for (var i = 0; i < result['data'].length; i++) {
          final entry = result['data'][i];
          data.add(Data.fromJson(entry));
        }
        return data;
      } catch(e) {
        return Exception(e.toString());
      }
    }
  }
}