import 'package:flutter/material.dart';
import 'package:my_project/screens/user_data_model.dart';

class ProfileScreen extends StatelessWidget {
  final UserData userData;

  const ProfileScreen({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text(
                  userData.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  "Welcome to your profile!",
                  style: TextStyle(fontSize: 14),
                ),
                leading: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  userData.email,
                  style: TextStyle(fontSize: 14),
                ),
                leading: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text(
                  "Address",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  userData.address,
                  style: TextStyle(fontSize: 14),
                ),
                leading: Icon(Icons.location_on),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              child: ListTile(
                title: Text(
                  "Phone Number",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  userData.phoneNumber,
                  style: TextStyle(fontSize: 14),
                ),
                leading: Icon(Icons.phone),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
