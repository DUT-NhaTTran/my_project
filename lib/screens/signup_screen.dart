import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

import 'package:my_project/reusable_widgets/reusable_widget.dart';

import 'package:my_project/screens/home_screen.dart';

import 'package:my_project/screens/signin_screen.dart';

import 'package:my_project/utils/colors_utils.dart';

class SignUpScreen extends StatefulWidget {

  const SignUpScreen({Key? key}) : super(key: key);

  @override

  _SignUpScreenState createState() => _SignUpScreenState();

}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController _passwordTextController = TextEditingController();

  TextEditingController _emailTextController = TextEditingController();

  TextEditingController _userNameTextController = TextEditingController();

  TextEditingController _addressTextController = TextEditingController();

  TextEditingController _phoneNumberTextController = TextEditingController();

 DatabaseReference _userReference = FirebaseDatabase.instance.ref().child('Accounts');


  @override

  Widget build(BuildContext context) {

    return Scaffold(

      extendBodyBehindAppBar: true,

      appBar: AppBar(

        backgroundColor: Colors.transparent,

        elevation: 0,

        title: const Text(

          "Sign Up",

          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

        ),

      ),

      body: Container(

        width: MediaQuery.of(context).size.width,

        height: MediaQuery.of(context).size.height,

        decoration: BoxDecoration(

          gradient: LinearGradient(

            colors: [

              hexStringToColor("2EB62C"),

              hexStringToColor("57C84D"),

              hexStringToColor("C5E8B7")

            ],

            begin: Alignment.topCenter,

            end: Alignment.bottomCenter,

          ),

        ),

        child: SingleChildScrollView(

          child: Padding(

            padding: EdgeInsets.fromLTRB(20, 120, 20, 0),

            child: Column(

              children: <Widget>[

                const SizedBox(

                  height: 20,

                ),

                reusableTextField(

                  "Enter UserName",

                  Icons.person_outline,

                  false,

                  _userNameTextController,

                ),

                const SizedBox(

                  height: 20,

                ),

                reusableTextField(

                  "Enter Email Id",

                  Icons.person_outline,

                  false,

                  _emailTextController,

                ),

                const SizedBox(

                  height: 20,

                ),

                reusableTextField(

                  "Enter Password",

                  Icons.lock_outlined,

                  true,

                  _passwordTextController,

                ),

                const SizedBox(

                  height: 20,

                ),

                reusableTextField(

                  "Enter Address",

                  Icons.location_on,

                  false,

                  _addressTextController,

                ),

                const SizedBox(

                  height: 20,

                ),

                reusableTextField(

                  "Enter Phone Number",

                  Icons.phone,

                  false,

                  _phoneNumberTextController,

                ),

                const SizedBox(

                  height: 20,

                ),

                firebaseUIButton(context, "Sign Up", () async {

                  String email = _emailTextController.text.trim();

                  String password = _passwordTextController.text.trim();

                  String userName = _userNameTextController.text.trim();

                  String address = _addressTextController.text.trim();

                  String phoneNumber = _phoneNumberTextController.text.trim();

                  if (email.isEmpty ||

                      password.isEmpty ||

                      userName.isEmpty ||

                      address.isEmpty ||

                      phoneNumber.isEmpty) {

                    // Handle case: Missing Information

                    showAlertDialog(

                      context,

                      "Missing Information",

                      "Please enter all required information.",

                    );

                    return;

                  }

                  // Check if email and phone number already exist

                  bool emailExists = await checkIfExists('email', email);

                  bool phoneNumberExists =

                      await checkIfExists('phoneNumber', phoneNumber);

                  if (emailExists) {

                    showAlertDialog(

                      context,

                      "Email Exists",

                      "This email is already registered. Please use a different email.",

                    );

                    return;

                  }

                  if (phoneNumberExists) {

                    showAlertDialog(

                      context,

                      "Phone Number Exists",

                      "This phone number is already registered. Please use a different phone number.",

                    );

                    return;

                  }

                  try {

                    // Register the user and get their UID

                    UserCredential userCredential = await FirebaseAuth.instance

                        .createUserWithEmailAndPassword(

                      email: email,

                      password: password,

                    );

                    // Get the UID of the newly registered user

                    String uid = userCredential.user?.uid ?? "";

                    // Add user information to the "Users" node

                    await _userReference.child(uid).set({

                      'uid': uid,

                      'Email': email,

                      'Name': userName,

                      'Address': address,

                      'PhoneNumber': phoneNumber,

                    });


                    Navigator.pushReplacement(

                      context,

                      MaterialPageRoute(

                        builder: (context) => SignInScreen(),

                      ),

                    );

                  } catch (e) {

                    print("Error signing up: $e");

                    if (e is FirebaseAuthException) {

                      // Handle specific FirebaseAuthException

                      if (e.code == 'email-already-in-use') {

                        // Email is already registered

                        showAlertDialog(

                          context,

                          "Sign Up Failed",

                          "This email is already registered. Please use a different email.",

                        );

                        return;

                      } else if (e.code == 'phone-number-already-in-use') {

                        // Phone number is already registered

                        showAlertDialog(

                          context,

                          "Sign Up Failed",

                          "This phone number is already registered. Please use a different phone number.",

                        );

                        return;

                      }

                    }

                    // Handle generic error

                    showAlertDialog(

                      context,

                      "Sign Up Failed",

                      "An error occurred while signing up. Please try again.",

                    );

                  }

                }),

              ],

            ),

          ),

        ),

      ),

    );

  }
  Future<bool> checkIfExists(String field, String value) async {
  try {
    DataSnapshot dataSnapshot = (await _userReference
        .orderByChild(field)
        .equalTo(value)
        .once()) as DataSnapshot;
    // Ensure dataSnapshot.value is of type Map<dynamic, dynamic>
    if (dataSnapshot.value is Map<dynamic, dynamic>) {
      return dataSnapshot.value != null;
    } else {
      return false;
    }
  } catch (e) {
    print("Error fetching data: $e");
    return false;
  }
}



  showAlertDialog(BuildContext context, String title, String content) {

    showDialog(

      context: context,

      builder: (BuildContext context) {

        return AlertDialog(

          title: Text(title),

          content: Text(content),

          actions: [

            TextButton(

              onPressed: () {

                Navigator.pop(context);

              },

              child: Text("OK"),

            ),

          ],

        );

      },

    );

  }

}