import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:ideaforge/Screens/3.8.1.dart';
=======
>>>>>>> origin/master
import 'package:ideaforge/Screens/Screen1.dart'; // Replace this with your next screen's import

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    // Getting the screen dimensions dynamically
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
=======
    // Getting the screen height dynamically
    final screenHeight = MediaQuery.of(context).size.height;
>>>>>>> origin/master

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
<<<<<<< HEAD
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
=======
              child: Container(
                height:
                    screenHeight * 0.4, // Provide a fixed height for the Stack
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    // The Card widget
                    Positioned(
                      top: screenHeight *
                          0.05, // Dynamic spacing (5% of screen height)
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        color: Colors.grey[200]?.withOpacity(0.4),
                        elevation: 5,
                        child: Container(
                          width: 320,
                          padding: EdgeInsets.only(
                            top: screenHeight *
                                0.08, // Space for the icon (8% of screen height)
                            left: 24.0,
                            right: 24.0,
                            bottom: 24.0,
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
                                  _buildButton(context, 'Sign Up', () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ProductDescriptionScreen(), // Navigate to your screen
                                      ),
                                    );
                                  }),
                                  _buildButton(context, 'Sign In', () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ProductDescriptionScreen(), // Navigate to your screen
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
                      top:
                          0.0, // Keep this value, so it's aligned with the top of the card
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.asset(
                          'assets/images/icon.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                  ],
                ),
>>>>>>> origin/master
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Function onPressed) {
    return SizedBox(
<<<<<<< HEAD
      width: MediaQuery.of(context).size.width * 0.3, // Responsive button width
=======
      width: 120,
>>>>>>> origin/master
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
