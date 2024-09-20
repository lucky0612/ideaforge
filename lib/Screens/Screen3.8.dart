import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ideaforge/Screens/Screen3.9.dart';

class GenWebsiteScreen extends StatefulWidget {
  final String proddesc;

  GenWebsiteScreen({required this.proddesc});

  @override
  _GenWebsiteScreenState createState() => _GenWebsiteScreenState();
}

class _GenWebsiteScreenState extends State<GenWebsiteScreen> {
  bool _isLoading = false;

  Future<void> _generateWebsite(BuildContext context) async {
    setState(() {
      _isLoading = true; // Start loading animation
    });

    final url = Uri.parse('https://innovent-endpts.onrender.com/generate');
    final headers = {"Content-Type": "application/json"};
    final body = json.encode({"description": widget.proddesc});

    try {
      final response = await http.post(url, headers: headers, body: body);

      setState(() {
        _isLoading = false; // Stop loading animation
      });

      if (response.statusCode == 200) {
        // Successfully generated website, navigate to the new page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DownWebScreen(),
          ),
        );
      } else {
        // Something went wrong
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to generate website.')),
        );
      }
    } catch (error) {
      setState(() {
        _isLoading = false; // Stop loading animation in case of error
      });

      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg2.png', // Replace with your background image
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Glad to see you made it!!',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.0),
                Text(
                  'Unlock powerful tools to create your website and discover collaborators nearby!',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 60.0),
                ElevatedButton(
                  onPressed: () {
                    _generateWebsite(
                        context); // Call the function to generate website
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    backgroundColor: Colors.teal.withOpacity(0.8),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: BorderSide(
                        color: Colors.white.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Generate Website',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Icon(
                        Icons.code,
                        color: Colors.amber, // Golden icon for premium feel
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Logic for exploring idea enthusiasts near you
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    backgroundColor: Colors.purple.withOpacity(0.8),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: BorderSide(
                        color: Colors.white.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Explore Idea Enthusiasts near you',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Icon(
                        Icons.explore,
                        color: Colors.amber, // Golden icon for premium feel
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 60,
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      "Generating website",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
