import 'dart:convert';
import 'package:assignment/models/model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<User>> fetchUserData() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return List<User>.from(data.map((json) => User.fromJson(json)));
    } else {
      throw Exception('Unable to fetch data');
    }
  }
}
