import 'package:dog_bluetooth_user/bluetooth.dart';
import 'package:dog_bluetooth_user/profile.dart';
import 'package:flutter/material.dart';

import 'dog_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DogScreen(),
                    ),
                  );
                },
                child: const Text("Dog Screen"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () => enableBluetooth(),
                child: const Text("Toggle Bluetooth"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Profile(),
                    ),
                  );
                },
                child: const Text("Profile Screen"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
