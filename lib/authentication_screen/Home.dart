import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profiles'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose whom you wanna date',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            ProfileCard(
              partner: 'Single',
            ),
            SizedBox(height: 20),
            ProfileCard(
              partner: 'Divorced',
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String partner;

  ProfileCard({required this.partner});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilesScreen(partner: partner)),
        );
      },
      child: Container(
        width: 200,
        height: 150,
        decoration: BoxDecoration(
          color: partner == 'Single' ? Colors.blue : Colors.orange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            '${partner[0].toUpperCase()}${partner.substring(1)}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ProfilesScreen extends StatefulWidget {
  final String partner;

  ProfilesScreen({required this.partner});

  @override
  _ProfilesScreenState createState() => _ProfilesScreenState();
}

class _ProfilesScreenState extends State<ProfilesScreen> {
  late Future<List<dynamic>> _profiles;

  @override
  void initState() {
    super.initState();
    _profiles = fetchProfiles();
  }

  Future<List<dynamic>> fetchProfiles() async {
    final response = await http.get(Uri.parse('http://localhost:2001/profiles/${widget.partner}'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load profiles');
    }
  }

  Future<void> viewDetails(String name) async {
    final response = await http.get(Uri.parse('http://localhost:2001/profiles/details/$name'));
    if (response.statusCode == 200) {
      final userDetails = json.decode(response.body);

      // Filter out sensitive fields
      userDetails.remove('_id');
      userDetails.remove('password');
      userDetails.remove('phoneNo');
      userDetails.remove('__v');
      // Format user details
      String formattedDetails = '';
      userDetails.forEach((key, value) {
        formattedDetails += '$key: $value\n';
      });

      // Show user details in a dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('User Details'),
            content: Text(formattedDetails),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
            ],
          );
        },
      );
    } else {
      throw Exception('Failed to load user details');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.partner[0].toUpperCase()}${widget.partner.substring(1)} Profiles'),
      ),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: _profiles,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Text(snapshot.data![index]['name']),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            viewDetails(snapshot.data![index]['name']);
                          },
                          child: Text('View My Details'),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
