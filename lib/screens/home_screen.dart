import 'package:flutter/material.dart';
import 'package:my_project/screens/user_data_model.dart';

class HomeScreen extends StatelessWidget {
  final UserData userData;

  const HomeScreen({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome, ${userData.name}!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Email: ${userData.email}"),
            SizedBox(height: 10),
            Text("Address: ${userData.address}"),
            SizedBox(height: 10),
            Text("PhoneNumber: ${userData.phoneNumber}"),
          ],
        ),
      ),
    );
  }
}
