import 'package:flutter/material.dart';
import 'package:ideaforge/Screens/3.8.2.dart';
import 'package:ideaforge/Screens/3.8.4.dart';

class HomeScreen extends StatelessWidget {
  final String proddesc; // String to hold the product description

  // Constructor accepting proddesc
  HomeScreen({required this.proddesc});

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
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // First Button: "Post your Idea"
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: CustomButton(
                    text: 'Post your Idea',
                    icon: Icons.lightbulb, // Icon representing an idea
                    proddesc: proddesc, // Passing the proddesc to CustomButton
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => IdeaFormScreen(
                                proddesc: proddesc,
                              )));
                    },
                  ),
                ),
                // Second Button: "Find Ideas Near You"
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: CustomButton(
                    text: 'Find Ideas Near You',
                    icon: Icons.search, // Icon representing search
                    proddesc: proddesc, // Passing the proddesc to CustomButton
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => IdeasNearYouPage()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final String proddesc; // New string field for the product description
  final VoidCallback onPressed;

  CustomButton({
    required this.text,
    required this.icon,
    required this.proddesc, // Constructor accepting proddesc
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80, // Increased height for larger button
      width: 320, // Adjusted width for a better layout
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            Color(0xFF6A11CB),
            Color(0xFF2575FC)
          ], // Gradient colors for a premium feel
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38, // Slightly darker shadow for better contrast
            offset: Offset(6, 6), // More defined 3D shadow
            blurRadius: 12, // More blur for smooth shadow effect
          ),
          BoxShadow(
            color:
                Colors.white.withOpacity(0.2), // Softer highlight on top left
            offset: Offset(-3, -3),
            blurRadius: 8,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0, // Disable default elevation
          backgroundColor:
              Colors.transparent, // Transparent to let gradient show
          shadowColor: Colors.transparent, // No shadow (handled by boxShadow)
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon, // Use the passed icon
              size: 40,
              color: Colors.white, // Icon color
            ),
            SizedBox(width: 20), // More space between icon and text
            Text(
              text,
              style: TextStyle(
                fontSize: 20, // Slightly larger font for a more luxurious feel
                fontWeight: FontWeight.w600, // Bold font for premium feel
                color: Colors.white, // Text color
              ),
            ),
            // You can display proddesc somewhere if needed
          ],
        ),
      ),
    );
  }
}
