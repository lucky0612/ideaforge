import 'package:flutter/material.dart';
import 'package:ideaforge/Screens/LoginScreen.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  String _displayedText = "> Hello I am Ideaforge";
  int _index = 0;
  bool _isErasing = false;

  late Timer _typingTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    _startTyping();
    _navigateToLoginScreen();
  }

  @override
  void dispose() {
    _controller.dispose();
    _typingTimer.cancel();
    super.dispose();
  }

  void _navigateToLoginScreen() async {
    await Future.delayed(const Duration(seconds: 10),
        () {}); // Extended duration for both text animations
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  // Start typing and erasing logic
  void _startTyping() {
    _typingTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (!_isErasing) {
          // Typing phase
          if (_index < "> Hello I am Ideaforge".length) {
            _index++;
            _displayedText = "> Hello I am Ideaforge".substring(0, _index);
          } else {
            // Once typing is done, start erasing after a brief pause
            Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                _isErasing = true;
              });
            });
          }
        } else {
          // Erasing phase
          if (_index > 1) {
            // Keep at least "> " when erasing
            _index--;
            _displayedText = "> Hello I am Ideaforge".substring(0, _index);
          } else {
            // Once erasing is done, type new text
            _isErasing = false;
            _index = 0;
            _startTypingSecondText();
            timer.cancel();
          }
        }
      });
    });
  }

  // Typing second text
  void _startTypingSecondText() {
    _typingTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (_index < "> I turn your ideas into reality".length) {
          _index++;
          _displayedText =
              "> I turn your ideas into reality".substring(0, _index);
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        // Background image
        Positioned.fill(
          child: Image.asset(
            'assets/images/bg1.png',
            fit: BoxFit.cover,
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black
                .withOpacity(0.5), // Adjust opacity for desired darkness
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo at the top with fading animation
            FadeTransition(
              opacity: _animation,
              child: Padding(
                padding: const EdgeInsets.only(top: 250.0),
                child: Image.asset(
                  'assets/images/image2.png',
                  width: 200, // Adjust the size of the logo
                  height: 200,
                ),
              ),
            ),
            const SizedBox(height: 50), // Space between logo and text
            Expanded(
              child: Center(
                child: Text(
                  _displayedText,
                  style: const TextStyle(
<<<<<<< HEAD
                    fontSize: 20.0,
=======
                    fontSize: 24.0,
>>>>>>> origin/master
                    fontFamily:
                        'Monospace', // Use a monospace font for terminal-like effect
                    color: Colors.white, // Aesthetic white color for text
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
