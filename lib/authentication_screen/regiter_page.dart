import 'dart:convert';
import 'package:dating_app/authentication_screen/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dating_app/authentication_screen/apperance_details.dart';
import 'package:dating_app/widgets/custom_text_field_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController partnerController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController bodyColorController = TextEditingController();
  TextEditingController drinkController = TextEditingController();
  TextEditingController smokeController = TextEditingController();
  TextEditingController haveChildrenController = TextEditingController();
  TextEditingController noOfChildController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController educationController = TextEditingController();

  Future<void> registerUser() async {
    if (formKey.currentState!.validate()) {
      var userData = {
        'email': emailController.text,
        'password': passwordController.text,
        'name': nameController.text,
        'age': ageController.text,
        'phoneNo': phoneNoController.text,
        'city': cityController.text,
        'country': countryController.text,
        'partner': partnerController.text,
        'height' : heightController.text,
        'weight' : weightController.text,
        'bodyColor': bodyColorController.text,
        'drink' : drinkController.text,
        'smoke': smokeController.text,
        'haveChildren' : haveChildrenController.text,
        'noOfChild' : noOfChildController.text,
        'education' : educationController.text,
        'profession' : professionController.text
      };

      var url = Uri.parse('http://localhost:2001/register');
      var response = await http.post(
        url,
        body: json.encode(userData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Loginpage()),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Registration Failed"),
              content: Text("Failed to register user because email is already used"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Create your Account",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50),
                const CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage("images/dating.jpg"),
                  backgroundColor: Colors.black,
                ),
                const SizedBox(height: 30),
                buildTextField('Email', emailController, Icons.email),
                const SizedBox(height: 20),
                buildTextField('Password', passwordController, Icons.lock),
                const SizedBox(height: 20),
                buildTextField('Name', nameController, Icons.person),
                const SizedBox(height: 20),
                buildTextField('Age', ageController, Icons.calendar_today),
                const SizedBox(height: 20),
                buildTextField('Phone Number', phoneNoController, Icons.phone),
                const SizedBox(height: 20),
                buildTextField('City', cityController, Icons.location_city),
                const SizedBox(height: 20),
                buildTextField('Country', countryController, Icons.location_on),
                const SizedBox(height: 20),
                buildTextField('Single or Divorced', partnerController, Icons.group),
                const SizedBox(height: 30),
                buildTextField('Height', heightController, Icons.height),
                const SizedBox(height: 30),
                buildTextField('Weight', weightController, Icons.monitor_weight_outlined),
                const SizedBox(height: 30),
                buildTextField('Color', bodyColorController, Icons.colorize),
                const SizedBox(height: 30),
                buildTextField('Will you Drink?', drinkController, Icons.local_drink_rounded),
                const SizedBox(height: 30),
                buildTextField('Will you Smoke?', smokeController, Icons.smoke_free),
                const SizedBox(height: 30),
                buildTextField('Do you have Children?', haveChildrenController, Icons.child_care),
                const SizedBox(height: 30),
                buildTextField('How many children do you have?', noOfChildController, Icons.group_outlined),
                const SizedBox(height: 30),
                buildTextField('Education', educationController, Icons.book_rounded),
                const SizedBox(height: 30),
                buildTextField('Profession', professionController, Icons.work),

                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: registerUser,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget buildTextField(String label, TextEditingController controller, IconData iconData) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 36,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(iconData),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.cyanAccent), // Aqua border color
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green), // Green border color when focused
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.cyanAccent), // Aqua border color
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is required';
          }
          return null;
        },
      ),
    );
  }

}
