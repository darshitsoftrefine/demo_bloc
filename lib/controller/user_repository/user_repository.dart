import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../model/user_model.dart';

class UserRepository {

  final String userUrl = "https://reqres.in/api/users?page=1";

  Future<List<UserModel>> getUsers() async {
    var response = await http.get(Uri.parse(userUrl),
      headers:  <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if(response.statusCode == 200){
      List result = jsonDecode(response.body)['data'];
      debugPrint(result.toString());
      return result.map((userData) => UserModel.fromJson(userData)).toList();
    } else {
      debugPrint("Error in displaying data");
      throw Exception("Error");
    }
  }
}