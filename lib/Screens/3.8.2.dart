import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ideaforge/Screens/3.8.3.dart';

class IdeaFormScreen extends StatefulWidget {
  final String proddesc;

  IdeaFormScreen({required this.proddesc});

  @override
  _IdeaFormScreenState createState() => _IdeaFormScreenState();
}

class _IdeaFormScreenState extends State<IdeaFormScreen> {
  // Hardcoded latitude and longitude for Bangalore
  final String _latitude = '12.9716';
  final String _longitude = '77.5946';

  final List<String> _stackItems = [];
  final TextEditingController _stackController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _descriptionController.text = widget.proddesc;

    // Force a rebuild to update the UI and display hardcoded latitude and longitude
    setState(() {});
  }

  @override
  void dispose() {
    // Dispose of all controllers when no longer needed
    _stackController.dispose();
    _descriptionController.dispose();
    _titleController.dispose();
    _emailController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  Future<void> _submitIdea() async {
    final String apiUrl = "https://geofencingendpts.onrender.com/ideas";

    // Print the request payload to debug
    final Map<String, dynamic> requestData = {
      "title": _titleController.text,
      "description": _descriptionController.text,
      "requirements": _stackItems.join(","), // Comma-separated stack items
      "duration":
          _durationController.text, // Directly passing the duration string
      "latitude": _latitude, // Hardcoded latitude of Bangalore
      "longitude": _longitude, // Hardcoded longitude of Bangalore
      "domain": "Software Technology"
    };

    print("Request Data: $requestData"); // Debug: Print the request payload

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestData),
      );

      // Debug: Print the response status and body
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        print("Idea submitted successfully!");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ExplorePage()));
      } else {
        print("Failed to submit idea. Status code: ${response.statusCode}");
      }
    } catch (e) {
      // Debug: Print any exception that might occur
      print("Error submitting idea: $e");
    }
  }

  void _addStackItem() {
    String stackItem = _stackController.text;
    if (stackItem.isNotEmpty) {
      setState(() {
        _stackItems.add(stackItem);
        _stackController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/s4.png',
              fit: BoxFit.cover,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'POST YOUR AMAZING IDEA!',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Post your previously generated idea by\nfilling out these additional details real quick!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    CustomTextField(
                        label: 'PROJECT NAME',
                        hintText: 'Give your project a catchy name!',
                        controller: _titleController),
                    SizedBox(height: 20),
                    CustomTextField(
                        label: 'DESCRIPTION',
                        hintText: 'Tell us all about it',
                        controller: _descriptionController),
                    SizedBox(height: 20),
                    CustomTextField(
                        label: 'DURATION',
                        hintText: 'Enter estimated duration (e.g. 3 days)',
                        controller: _durationController),
                    SizedBox(height: 20),
                    CustomTextField(
                      label: 'STACK',
                      hintText: 'Enter tech stack',
                      suffixIcon: Icons.add,
                      controller: _stackController,
                      onSuffixIconPressed: _addStackItem,
                    ),
                    if (_stackItems.isNotEmpty) ...[
                      SizedBox(height: 20),
                      Text(
                        'Added Stack:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: _stackItems
                            .map((item) => Chip(
                                  label: Text(item,
                                      style: TextStyle(color: Colors.white)),
                                  backgroundColor: Colors.blueAccent,
                                  deleteIcon:
                                      Icon(Icons.close, color: Colors.white),
                                  onDeleted: () {
                                    setState(() {
                                      _stackItems.remove(item);
                                    });
                                  },
                                ))
                            .toList(),
                      ),
                    ],
                    SizedBox(height: 20),
                    CustomTextField(
                        label: 'EMAIL',
                        hintText: 'This will be your point of contact',
                        controller: _emailController),
                    SizedBox(height: 40),
                    // Display Latitude, Longitude and Current Location
                    Text(
                      'Your current location:',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Latitude: $_latitude',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Longitude: $_longitude',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    SizedBox(height: 40),
                    Center(
                      child: ElevatedButton(
                        onPressed: _submitIdea,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                          padding: EdgeInsets.symmetric(
                            horizontal: 100,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          shadowColor: Colors.black38,
                          elevation: 10,
                        ),
                        child: Text(
                          'POST',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Text Field widget to avoid repetition
class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final VoidCallback? onSuffixIconPressed;

  CustomTextField({
    required this.label,
    required this.hintText,
    this.suffixIcon,
    this.controller,
    this.onSuffixIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.1),
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (suffixIcon != null)
                GestureDetector(
                  onTap: onSuffixIconPressed,
                  child: Icon(suffixIcon, color: Colors.white),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
