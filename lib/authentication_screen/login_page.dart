import 'package:dating_app/authentication_screen/Home.dart';
import 'package:dating_app/authentication_screen/regiter_page.dart';
import 'package:dating_app/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  bool showProgressBar = false;

  Future<void> loginUser() async {
    setState(() {
      showProgressBar = true;
    });

    final response = await http.post(
      Uri.parse('http://localhost:2001/login'), // Replace with your backend login endpoint
      body: jsonEncode({
        'email': emailTextEditingController.text,
        'password': passwordTextEditingController.text,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    setState(() {
      showProgressBar = false;
    });

    if (response.statusCode == 200) {
      // Successful login, navigate to home page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // Handle login failure
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Invalid email or password'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Image.asset(
                "images/valentine.png",
                width: 450,
              ),
              const Text(
                "Welcome to Our Dating app",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const Text(
                "Please login to enter into app",
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                child: CustomTextField(
                  editingController: emailTextEditingController,
                  labelText: "Enter your Email",
                  iconData: Icons.email_outlined,
                  isObscure: false,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                child: CustomTextField(
                  editingController: passwordTextEditingController,
                  labelText: "Enter your password",
                  iconData: Icons.lock_clock_outlined,
                  isObscure: true,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: loginUser,
                child: Container(
                  width: MediaQuery.of(context).size.width - 36,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: Colors.pinkAccent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an Account?",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const RegisterPage());
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              showProgressBar
                  ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
