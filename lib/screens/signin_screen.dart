import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/screens/home_screen.dart';
import 'package:my_project/utils/colors_utils.dart';
import 'package:my_project/reusable_widgets/reusable_widget.dart';
import 'package:my_project/screens/signup_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key?key}):super(key:key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController=TextEditingController();
  TextEditingController _emailTextController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors:[
            hexStringToColor("CB2893"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4")
            ],begin:Alignment.topCenter, end:Alignment.bottomCenter)),
            child:SingleChildScrollView(
              child: Padding(
                padding:EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height*0.2, 20, 0),
                child:Column(
                    children:<Widget> [
                      logoWidget("assets/images/login-logo.png"),
                      const SizedBox(
                        height:30,
                      ),
                      reusableTextField("Enter Username", Icons.person_outline, false, _emailTextController),
                      const SizedBox(
                         height:30,
                      ),
                      reusableTextField("Enter Password", Icons.lock_outline, true, _passwordTextController),
                      const SizedBox(
                         height:20,
                      ),
                      firebaseUIButton(context, "Sign In", () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                signUpOption()
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
        const Text("Don't have account?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
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
}