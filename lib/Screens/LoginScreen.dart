import 'package:flutter/material.dart';
import 'package:ideaforge/Screens/3.8.1.dart';
import 'package:ideaforge/Screens/Screen1.dart'; // Replace this with your next screen's import

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Getting the screen dimensions dynamically
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg1.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width:
                        constraints.maxWidth * 0.9, // 90% width of the screen
                    height: screenHeight *
                        0.5, // Adjust this to fit the screen height
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        Positioned(
                          top: screenHeight * 0.05, // 5% spacing from top
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            color: Colors.grey[200]?.withOpacity(0.4),
                            elevation: 5,
                            child: Container(
                              width: constraints.maxWidth *
                                  0.8, // 80% width of the screen
                              padding: EdgeInsets.only(
                                top: screenHeight * 0.08,
                                left: screenWidth * 0.05,
                                right: screenWidth * 0.05,
                                bottom: screenHeight * 0.03,
                              ),
                              child: Column(
                                children: <Widget>[
                                  _buildTextField(
                                    'Username',
                                    TextInputType.text,
                                  ),
                                  const SizedBox(height: 16.0),
                                  _buildTextField(
                                    'Password',
                                    TextInputType.visiblePassword,
                                    obscureText: true,
                                  ),
                                  const SizedBox(height: 24.0),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      _buildButton(context, 'Sign Up', () {}),
                                      _buildButton(context, 'Sign In', () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ProductDescriptionScreen(),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // The icon above the card
                        Positioned(
                          top: 0.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.asset(
                              'assets/images/icon.png',
                              width:
                                  screenWidth * 0.2, // 20% width of the screen
                              height: screenWidth *
                                  0.2, // Maintain square shape for the icon
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Function onPressed) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3, // Responsive button width
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white.withOpacity(0.2),
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: BorderSide(
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          elevation: 5,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextInputType keyboardType,
      {bool obscureText = false}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
      ),
      style: const TextStyle(color: Colors.white),
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}
