import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/user.dart';

class UserService {
  static const String baseUrl = 'http://192.168.6.207:3000';

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      final json = response.body;
      final map = jsonDecode(json);
      final usersMap = map['users'] as List<dynamic>;
      final users = usersMap.map(
        (e) {
          return User.fromJson(e);
        },
      ).toList();
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User> createUser(User user) async {
    final map = user.toJson();
    final json = jsonEncode(map);
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      body: json,
      headers: {
        'content -Type': "application/json",
      },
    );
    if (response.statusCode == 201) {
      final json = response.body;
      final map = jsonDecode(json);
      final user = User.fromJson(map);
      return user;
    } else {
      throw Exception('Failed to create user');
    }
  }

// Implement methods for update and delete operations similarly
}
