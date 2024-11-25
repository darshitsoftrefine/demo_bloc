import 'dart:convert';
import 'package:http/http.dart';

import '../../model/user_model.dart';

class UserRepository {

  String userUrl = "https://reqres.in/api/users?page=1";

  Future<List<UserModel>> getUsers() async {
    var response = await get(Uri.parse(userUrl));

    if(response.statusCode == 200){
      final List result = jsonDecode(response.body)['data'];
      print(result);
      return result.map((e) => UserModel.fromJson(e)).toList();
    } else {
      print("Error in displaying data");
      throw Exception("Error");
    }
  }
}