import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../model/user_model.dart';

class UserRepository {

  String userUrl = "https://reqres.in/api/users?page=1";

  Future<List<UserModel>> getUsers() async {
    var response = await get(Uri.parse(userUrl));

    if(response.statusCode == 200){
      final List result = jsonDecode(response.body)['data'];
      debugPrint(result.toString());
      return result.map((e) => UserModel.fromJson(e)).toList();
    } else {
      debugPrint("Error in displaying data");
      throw Exception("Error");
    }
  }
}