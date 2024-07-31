import 'package:flutter/material.dart';
import 'package:ideaforge/Screens/Screen1.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                color: Colors.grey[900],
                elevation: 5,
                child: Container(
                  width: 300,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.asset('assets/images/Image1.png')),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Efficient Workflow',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'GenAI Product Development simplifies your product journey with AI-powered solutions tailored to your needs.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              _buildButton(context, 'Login', _buildLoginBottomSheet),
              const SizedBox(height: 10.0),
              _buildButton(context, 'Signup', _buildSignupBottomSheet),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Function onPressed) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () => onPressed(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[800],
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  void _buildLoginBottomSheet(BuildContext context) {
    _showBottomSheet(
      context,
      [
        _buildTextField('Email ID', TextInputType.emailAddress),
        const SizedBox(height: 10.0),
        _buildTextField('Password', TextInputType.visiblePassword,
            obscureText: true),
        const SizedBox(height: 20.0),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[800],
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProductDescriptionScreen(),
                ),
              );
            },
            child: const Text(
              'Submit',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  void _buildSignupBottomSheet(BuildContext context) {
    _showBottomSheet(
      context,
      [
        _buildTextField('Email ID', TextInputType.emailAddress),
        const SizedBox(height: 10.0),
        _buildTextField('Password', TextInputType.visiblePassword,
            obscureText: true),
        const SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            // Add signup action here
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context, List<Widget> children) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      backgroundColor: Colors.grey[900],
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
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
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.white70),
        ),
        fillColor: Colors.grey[800],
        filled: true,
      ),
      style: const TextStyle(color: Colors.white),
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
  }
}
