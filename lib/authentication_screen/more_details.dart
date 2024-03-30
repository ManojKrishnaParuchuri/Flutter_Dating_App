import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dating_app/authentication_screen/login_page.dart';
import 'package:dating_app/widgets/custom_text_field_widget.dart';

class MoreDetails extends StatefulWidget {
  const MoreDetails({Key? key}) : super(key: key);

  @override
  State<MoreDetails> createState() => _MoreDetailsState();
}

class _MoreDetailsState extends State<MoreDetails> {
  TextEditingController willingToRelocateController = TextEditingController();
  TextEditingController typeOfRelationController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController religionController = TextEditingController();

  Future<void> saveDetailsToDB() async {
    // Extract data from text controllers
    var detailsData = {
      'willingToRelocate': willingToRelocateController.text,
      'typeOfRelation': typeOfRelationController.text,
      'nationality': nationalityController.text,
      'language': languageController.text,
      'religion': religionController.text,
    };

    // Send HTTP POST request to backend API
    var url = Uri.parse('http://localhost:2001/moredetails');
    var response = await http.post(
      url,
      body: json.encode(detailsData),
      headers: {'Content-Type': 'application/json'},
    );

    // Check if request was successful
    if (response.statusCode == 201) {
      // If successful, navigate to login page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Loginpage()),
      );
    } else {
      // If not successful, show an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Failed to save details."),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 30),
              const Text(
                "Require more details",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),
              const Text(
                "Fill your details perfectly you cannot come back again and change anything",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              buildTextField('Willing to Relocate?', willingToRelocateController, Icons.place),
              SizedBox(height: 30),
              buildTextField('Enter what type of Relation do you want?', typeOfRelationController, Icons.type_specimen),
              SizedBox(height: 30),
              buildTextField('Enter your Nation', nationalityController, Icons.flag),
              SizedBox(height: 30),
              buildTextField('Your Preferred Language', languageController, Icons.language),
              SizedBox(height: 30),
              buildTextField('Enter your Religion', religionController, Icons.temple_hindu),
              SizedBox(height: 30),
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
                      onPressed: saveDetailsToDB,
                      child: const Text(
                        'Submit',
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
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller, IconData iconData) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 36,
      child: CustomTextField(
        editingController: controller,
        labelText: label,
        iconData: iconData,
        isObscure: false,
      ),
    );
  }
}
