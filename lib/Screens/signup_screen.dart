import 'package:flutter/material.dart';
import 'package:untitled5/Components/signup_body.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body_Signup(),
    );
  }
}