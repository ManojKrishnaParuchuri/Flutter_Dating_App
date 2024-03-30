import 'dart:convert';
import 'package:dating_app/authentication_screen/regiter_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dating_app/authentication_screen/more_details.dart'; // Import the MoreDetails page
import 'package:dating_app/widgets/custom_text_field_widget.dart';

class AppearanceDetails extends StatefulWidget {
  const AppearanceDetails({Key? key}) : super(key: key);

  @override
  State<AppearanceDetails> createState() => _AppearanceDetailsState();
}

class _AppearanceDetailsState extends State<AppearanceDetails> {
  TextEditingController heightTextEditingController = TextEditingController();
  TextEditingController weightTextEditingController = TextEditingController();
  TextEditingController bodyColorTextEditingController = TextEditingController();
  TextEditingController drinkTextEditingController = TextEditingController();
  TextEditingController smokeTextEditingController = TextEditingController();
  TextEditingController maritalStatusTextEditingController = TextEditingController();
  TextEditingController haveChildrenTextEditingController = TextEditingController();
  TextEditingController noOfChildTextEditingController = TextEditingController();
  TextEditingController professionTextEditingController = TextEditingController();
  TextEditingController educationTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Fill more details",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                "Fill your details perfectly you cannot come back again and change anything",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                child: CustomTextField(
                  editingController: heightTextEditingController,
                  labelText: "Enter your Height in Number",
                  iconData: Icons.height,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                child: CustomTextField(
                  editingController: weightTextEditingController,
                  labelText: "Enter your Weight in Number",
                  iconData: Icons.line_weight,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                child: CustomTextField(
                  editingController: bodyColorTextEditingController,
                  labelText: "Enter your Color",
                  iconData: Icons.colorize,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                child: CustomTextField(
                  editingController: drinkTextEditingController,
                  labelText: "Will you drink?",
                  iconData: Icons.wine_bar,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                child: CustomTextField(
                  editingController: smokeTextEditingController,
                  labelText: "Will you Smoke?",
                  iconData: Icons.smoke_free,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                child: CustomTextField(
                  editingController: maritalStatusTextEditingController,
                  labelText: "Enter your Marital Status",
                  iconData: Icons.group,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                child: CustomTextField(
                  editingController: haveChildrenTextEditingController,
                  labelText: "Do you have Children in Number",
                  iconData: Icons.child_friendly,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                child: CustomTextField(
                  editingController: noOfChildTextEditingController,
                  labelText: "No of Children do you have? (Number)",
                  iconData: Icons.child_care,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                child: CustomTextField(
                  editingController: educationTextEditingController,
                  labelText: "Enter your Education",
                  iconData: Icons.height,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                child: CustomTextField(
                  editingController: professionTextEditingController,
                  labelText: "Enter your Profession",
                  iconData: Icons.work,
                  isObscure: false,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: Colors.pinkAccent,
                        padding: EdgeInsets.all(12),
                      ),
                      onPressed: () {
                        // Implement logic to save appearance details to MongoDB
                        saveAppearanceDetails();
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveAppearanceDetails() async {
    var appearanceData = {
      'height': heightTextEditingController.text,
      'weight': weightTextEditingController.text,
      'bodyColor': bodyColorTextEditingController.text,
      'drink': drinkTextEditingController.text,
      'smoke': smokeTextEditingController.text,
      'maritalStatus': maritalStatusTextEditingController.text,
      'haveChildren': haveChildrenTextEditingController.text,
      'noOfChild': noOfChildTextEditingController.text,
      'profession': professionTextEditingController.text,
      'education': educationTextEditingController.text,
    };

    var url = Uri.parse('http://localhost:2001/appearance');
    var response = await http.post(
      url,
      body: json.encode(appearanceData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      // Successfully saved appearance details
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MoreDetails()), // Navigate to MoreDetails page
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to save appearance details."),
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
