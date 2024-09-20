import 'dart:convert';

import '../model/user.dart';
import 'package:http/http.dart'as http;


class UserService{
  static const String baseUrl = 'http://192.168.6.207:3000';

  Future<List<User>>getUser()async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      final json = response.body;
      final map = jsonDecode(json);
      final userMap = map['users'] as List<dynamic>;
      final users = userMap.map((e) {
        return User.fromJson(e);
      },).toList();
      return users;
    }else {
      throw Exception('Failed to load users');
    }
  }
}
