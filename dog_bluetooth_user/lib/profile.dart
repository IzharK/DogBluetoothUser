import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  final http.Client? httpClient;
  const Profile({this.httpClient, Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String name = '';
  String location = '';
  String email = '';
  String dob = '';
  int daysRegistered = 0;
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    fetchRandomUser();
  }

  Future<void> fetchRandomUser() async {
    final response = await http.get(Uri.parse('https://randomuser.me/api/'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final user = jsonData['results'][0];
      setState(() {
        name = '${user['name']['first']} ${user['name']['last']}';
        location =
            '${user['location']['city']}, ${user['location']['country']}';
        email = user['email'];
        dob = user['dob']['date'];
        daysRegistered = DateTime.now()
            .difference(DateTime.parse(user['registered']['date']))
            .inDays;
        imageUrl = user['picture']['large'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random User Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageUrl.isNotEmpty)
              CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
                radius: 150,
              ),
            const SizedBox(height: 16),
            Text(
              'Name: $name',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Location: $location',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Email: $email',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Date of Birth: $dob',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Number of days since registered: $daysRegistered',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
