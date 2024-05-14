import 'package:assignment/api/api_service.dart';
import 'package:assignment/models/model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  late List<User> _users = [];
  late List<User> _searchedUser = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final List<User> users = await _apiService.fetchUserData();
      setState(() {
        _users = users;
        _searchedUser = users;
      });
    } catch (e) {
      print('Error fetching user data $e');
    }
  }

  void _searchUser(String query) {
    setState(() {
      
      _searchedUser = _users
          .where(
              (user) => user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              onChanged: _searchUser,
              decoration: const InputDecoration(
                  hintText: 'Search user', fillColor: Colors.amber),
            ),
          ))
        ],
      ),
      body: ListView.builder(
          itemCount: _searchedUser.length,
          itemBuilder: (context, index) {
            final user = _searchedUser[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 207, 231, 250)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.name,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                    ),
                    Text(user.userName),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sort();
        },
        child: const Icon(Icons.arrow_upward, weight: 29),
      ),
    );
  }

  void sort() {
    setState(() {
      _users.sort(
        (a, b) => a.name.compareTo(b.name),
      );
    });
  }
}
