import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ideaforge/Screens/Screen3.5.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
//import 'package:ideaforge/Screens/Screen4.dart';
import 'dart:convert';

class ChooseTypeScreen extends StatefulWidget {
  final String productDesc;
  final String domain;
  final String userreq;
  final String techasp;
  final String lifeCycle;

  ChooseTypeScreen(
      {required this.productDesc,
      required this.domain,
      required this.userreq,
      required this.techasp,
      required this.lifeCycle});

  @override
  _ChooseTypeScreenState createState() => _ChooseTypeScreenState();
}

class _ChooseTypeScreenState extends State<ChooseTypeScreen> {
  bool _isLoading = false;

  // This method handles the API call to imagen
  Future<void> _handleSubmit() async {
    setState(() {
      _isLoading = true;
    });

    List<String> urls = [];

    final response = await http.post(
      Uri.parse('https://innovent-endpts.onrender.com/imagen'),
      body: {
        'description': widget.productDesc,
        'domain': widget.domain,
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      urls = List<String>.from(jsonResponse['images']);
    } else {
      // Handle error here, show an error message
    }

    setState(() {
      _isLoading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UrlDownloadScreen(
          urls: urls,
          userreq: widget.userreq,
          techasp: widget.techasp,
          lifeCycle: widget.lifeCycle,
          proddesc: widget.productDesc,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
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
          // Main content with full screen coverage
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 50),
                        // Dynamic Heading based on domain
                        Text(
                          widget.domain.toLowerCase() == "software technology"
                              ? 'Generate UI Images'
                              : 'Generate Relevant Viewables',
                          style: TextStyle(
                            fontSize: 27.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                            height:
                                20.0), // Added gap between heading and description

                        // Descriptive text based on the condition
                        Text(
                          widget.domain.toLowerCase() == "software technology"
                              ? 'We bring you expertly customized and meticulously tailored UI designs, crafted to perfectly match your unique style and preferences. Explore a vast range of design options, each created to deliver a personalized, seamless, and visually stunning experience, just for you.'
                              : 'We bring you expertly customized and meticulously tailored viewable designs, crafted to perfectly match your unique style and preferences. Explore a vast range of design options, each created to deliver a personalized, seamless, and visually stunning experience, just for you.',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white
                                .withOpacity(0.7), // Slightly translucent text
                          ),
                        ),
                        SizedBox(height: 150.0),
                        // Submit button
                        ElevatedButton(
                          onPressed: _handleSubmit,
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(100),
                            backgroundColor: Colors.white.withOpacity(0.0),
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              side: BorderSide(
                                color: Colors.white.withOpacity(0.5),
                                width: 1.5,
                              ),
                            ),
                            elevation: 5,
                            shadowColor: Colors.white.withOpacity(0.3),
                          ),
                          child: const Text(
                            'Generate',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
                    SizedBox(height: 16.0),
                    Text(
                      "Fetching your results",
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
