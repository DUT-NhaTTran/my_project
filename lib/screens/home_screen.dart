import 'package:flutter/material.dart';
import 'package:my_project/screens/profile_screen.dart';
import 'package:my_project/screens/buy_screen.dart';
import 'package:my_project/screens/sell_screen.dart';
import 'package:my_project/screens/chat_screen.dart';
import 'package:my_project/screens/info_screen.dart';
import 'package:my_project/screens/user_data_model.dart';

class HomeScreen extends StatelessWidget {
  final UserData userData;

  const HomeScreen({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(userData: userData),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Home",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.yellow,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,

        items: [
          buildNavigationBarItem(Icons.shopping_cart, 'Buy', 0),
          buildNavigationBarItem(Icons.attach_money, 'Sell', 1),
          buildNavigationBarItem(Icons.chat, 'Chat', 2),
          buildNavigationBarItem(Icons.info, 'Info', 3),
        ],
        onTap: (index) {
          navigateToScreen(context, index);
        },
      ),
    );
  }

  BottomNavigationBarItem buildNavigationBarItem(
    IconData icon,
    String label,
    int index,
  ) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label,
    );
  }

  void navigateToScreen(BuildContext context, int index) {
    Widget screen;
    switch (index) {
      case 0:
        screen = BuyScreen();
        break;
      case 1:
        screen = SellScreen();
        break;
      case 2:
        screen = ChatScreen();
        break;
      case 3:
        screen = InfoScreen();
        break;
      default:
        screen = SellScreen(); // Default to BuyScreen
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
