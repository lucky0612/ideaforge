import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ideaforge/Screens/Screen4.dart';
import 'dart:convert';

class ChooseTypeScreen extends StatefulWidget {
  @override
  _ChooseTypeScreenState createState() => _ChooseTypeScreenState();
}

class _ChooseTypeScreenState extends State<ChooseTypeScreen> {
  bool _isUiUxDesign = false;
  bool _isPrototype = false;
  bool _isLoading = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _overviewController = TextEditingController();
  final TextEditingController _colourSchemeController = TextEditingController();
  final TextEditingController _featuresController = TextEditingController();
  final TextEditingController _layoutController = TextEditingController();

  void _handleSubmit() async {
    setState(() {
      _isLoading = true;
    });

    List<String> urls = [];
    String message = '';
    String viewUrl = '';
    String downloadUrl = '';

    if (_isUiUxDesign) {
      final response = await http.post(
        Uri.parse('https://utility-end-pts-1.onrender.com/imagen'),
        body: {
          'description': _overviewController.text,
        },
      );

      print('UI/UX design response status: ${response.statusCode}');
      print('UI/UX design response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        urls = List<String>.from(jsonResponse['images']);
      } else {
        // Handle error
      }
    }

    if (_isPrototype) {
      final response = await http.post(
        Uri.parse('https://utility-end-pts-1.onrender.com/generate'),
        body: {
          'title': _titleController.text,
          'description': _overviewController.text,
          'colourScheme': _colourSchemeController.text,
          'features': _featuresController.text,
          'layoutPreferences': _layoutController.text,
        },
      );

      print('Prototype response status: ${response.statusCode}');
      print('Prototype response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        message = jsonResponse['message'];
        viewUrl = jsonResponse['viewUrl'];
        downloadUrl = jsonResponse['downloadUrl'];
      } else {
        // Handle error
      }
    }

    setState(() {
      _isLoading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OutputScreen(
          urls: urls,
          message: message,
          viewUrl: viewUrl,
          downloadUrl: downloadUrl,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CHOOSE TYPE'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSwitchListTile(
                    'UI/UX design',
                    _isUiUxDesign,
                    (bool value) {
                      setState(() {
                        _isUiUxDesign = value;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  _buildSwitchListTile(
                    'PROTOTYPE',
                    _isPrototype,
                    (bool value) {
                      setState(() {
                        _isPrototype = value;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Add Details:',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                  SizedBox(height: 8.0),
                  _buildTextField(
                      hintText: 'Title', controller: _titleController),
                  SizedBox(height: 8.0),
                  _buildTextField(
                      hintText: 'Overview', controller: _overviewController),
                  SizedBox(height: 8.0),
                  _buildTextField(
                      hintText: 'Colour Scheme',
                      controller: _colourSchemeController),
                  SizedBox(height: 8.0),
                  _buildTextField(
                      hintText: 'Features', controller: _featuresController),
                  SizedBox(height: 8.0),
                  _buildTextField(
                      hintText: 'Layout', controller: _layoutController),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _handleSubmit,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'Submit',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LoadingAnimationWidget.dotsTriangle(
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

  Widget _buildSwitchListTile(
      String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.white,
      activeTrackColor: Colors.grey[800],
      inactiveThumbColor: Colors.grey,
      inactiveTrackColor: Colors.grey[600],
      tileColor: Colors.black38,
      dense: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  Widget _buildTextField(
      {required String hintText, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
