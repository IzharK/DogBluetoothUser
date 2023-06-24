import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DogScreen extends StatefulWidget {
  const DogScreen({super.key});

  @override
  State<DogScreen> createState() => _DogScreenState();
}

class _DogScreenState extends State<DogScreen> {
  late Image _image;

  void _getRandomDogImage() async {
    var url = Uri.parse('https://dog.ceo/api/breeds/image/random');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var imageUrl = json['message'];
      _image = Image.network(imageUrl);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getRandomDogImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Dog Images'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _image,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _getRandomDogImage,
                child: const Text('Refresh'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
