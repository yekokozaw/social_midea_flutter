// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_midea_flutter/helper/helper_functions.dart';

import '../components/square_tile.dart';
import '../services/auth_service.dart';
import '../widgets/loading_widget.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  Future signIn() async {
    try {
      _isLoading = true;
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent user from dismissing while loading
        builder: (context) => LoadingWidget(isLoading: _isLoading,),
      );
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
       Navigator.of(context).pop();
       displayMessageToUser(e.message.toString(), context);
      return null;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //hello again
                Text(
                  'Hello again!',
                  style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Welcome back,you\'ve been missed',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 50),
                //email text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email'
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                //password text field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password'
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ForgotPasswordPage();
                            },),
                          );
                      },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 25,),
                //sign in button
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: signIn,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(12)
                      ),
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
                //not a member register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Not a member? '
                    ),
                    GestureDetector(
                      onTap: widget.showRegisterPage,
                      child: Text(
                        'Register Now',
                        style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(child:
                        Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      )),
                      Text(' or Continue with ',style: TextStyle(color: Colors.grey[500]),),
                      Expanded(child:
                        Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ))
                    ],
                  ),
                ),
                SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                        onTap:() => AuthService().signInWithGoogle(),
                        imagePath: 'assets/images/google1.png'
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
