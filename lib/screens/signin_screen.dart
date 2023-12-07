import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/screens/home_screen.dart';
import 'package:my_project/utils/colors_utils.dart';
import 'package:my_project/reusable_widgets/reusable_widget.dart';
import 'package:my_project/screens/signup_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.2,
              20,
              0,
            ),
            child: Column(
              children: <Widget>[
                logoWidget("assets/images/login-logo.png"),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField(
                    "Enter Username After", Icons.person_outline, false, _emailTextController),
                const SizedBox(
                  height: 30,
                ),
                reusableTextField(
                    "Enter Password After", Icons.lock_outline, true, _passwordTextController),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(context, "Sign In", () {
                  String email = _emailTextController.text.trim();
                  String password = _passwordTextController.text.trim();

                  if (email.isEmpty || password.isEmpty) {
                    // Handle case: Missing Email or Password
                    showAlertDialog(context, "Missing Credentials",
                        "Please enter both email and password.");
                    return;
                  }

                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: email, password: password)
                      .then((value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
}).catchError((error) {
                    // Handle other error cases
                    String errorMessage =
                        "Đăng nhập thất bại. Vui lòng kiểm tra lại tài khoản và mật khẩu.";
                    if (error is FirebaseAuthException) {
                      switch (error.code) {
                        case "invalid-email":
                          errorMessage = "Email không hợp lệ.";
                          break;
                        case "user-not-found":
                        case "wrong-password":
                          errorMessage =
                              "Tài khoản hoặc mật khẩu không đúng.";
                          break;
                        default:
                          errorMessage =
                              "Tài khoản hoặc mật khẩu không đúng";
                      }
                    }
                    showAlertDialog(context, "Login Error", errorMessage);
                  });
                }),
                signUpOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
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