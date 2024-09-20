import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ideaforge/Screens/Screen3.dart';

class DocumentationScreen extends StatefulWidget {
  final String userRequirements;
  final String technicalAspects;
  final String lifeCycle;
  final String userId;
  final String productDesc;
  final String domain;

  DocumentationScreen({
    required this.userRequirements,
    required this.technicalAspects,
    required this.lifeCycle,
    required this.userId,
    required this.productDesc,
    required this.domain,
  });

  @override
  _DocumentationScreenState createState() => _DocumentationScreenState();
}

class _DocumentationScreenState extends State<DocumentationScreen> {
  final TextEditingController _addChangesController = TextEditingController();
  final TextEditingController _productDescController = TextEditingController();
  bool _isLoading = false;

  // Mutable variables for holding document content
  late String _userRequirements;
  late String _technicalAspects;
  late String _lifeCycle;
  late String _productDesc;

  // Variables to track which sliders are selected
  bool _reviseRequirements = false;
  bool _reviseTechnical = false;
  bool _reviseLifecycle = false;

  @override
  void initState() {
    super.initState();
    // Initialize the mutable state variables with widget values
    _userRequirements = widget.userRequirements;
    _technicalAspects = widget.technicalAspects;
    _lifeCycle = widget.lifeCycle;
    _productDesc = widget.productDesc; // Initialize productDesc
  }

  Future<void> _reviseDocuments() async {
    // Check if no sliders are selected
    if (!_reviseRequirements && !_reviseTechnical && !_reviseLifecycle) {
      _showErrorDialog('Please select at least one option to revise.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final revisionPrompt = _addChangesController.text;

    if (revisionPrompt.isEmpty) {
      _showErrorDialog('Please provide revision details.');
      setState(() {
        _isLoading = false;
      });
      return;
    }

    // Update productDesc if the user enters something in the regenerate field
    if (_productDescController.text.isNotEmpty) {
      _productDesc = _productDescController.text;
    }

    // Revise User Requirements if selected
    if (_reviseRequirements) {
      await _reviseDocument('requirements');
      setState(() {}); // Update the UI with revised content
    }

    // Revise Technical Aspects if selected
    if (_reviseTechnical) {
      await _reviseDocument('technical');
      setState(() {}); // Update the UI with revised content
    }

    // Revise Life Cycle if selected
    if (_reviseLifecycle) {
      await _reviseDocument('lifecycle');
      setState(() {}); // Update the UI with revised content
    }

    setState(() {
      _isLoading = false;
    });

    _showSuccessDialog(
        'All selected documents have been successfully revised.');
  }

  Future<void> _reviseDocument(String type) async {
    final apiUrl =
        'https://product-vision-api.onrender.com/api/revise-document/$type/${widget.userId}';

    final payload = {
      "revisionPrompt": _addChangesController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        setState(() {
          if (type == 'requirements') {
            _userRequirements = responseData['document']
                .replaceAll('*', '')
                .replaceAll('#', '');
          } else if (type == 'technical') {
            _technicalAspects = responseData['document']
                .replaceAll('*', '')
                .replaceAll('#', '');
          } else if (type == 'lifecycle') {
            _lifeCycle = responseData['document']
                .replaceAll('*', '')
                .replaceAll('#', '');
          }
        });
      } else {
        _showErrorDialog(
            'Failed to revise $type document. Status: ${response.statusCode}');
      }
    } catch (e) {
      _showErrorDialog('An error occurred while revising $type document: $e');
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // This ensures the Stack fills the screen
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg2.png', // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          // Main content
          Container(
            height: MediaQuery.of(context).size.height, // Ensure full height
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    const Text(
                      ' Documentation',
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    // Descriptive text
                    const Text(
                      '  This is what we have generated for you!',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _buildExpansionTile(
                      title: 'User Requirements',
                      content: Text(
                        _userRequirements,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    _buildExpansionTile(
                      title: 'Technical Aspects',
                      content: Text(
                        _technicalAspects,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    _buildExpansionTile(
                      title: 'Life Cycle',
                      content: Text(
                        _lifeCycle,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    _buildCard(
                      title: 'Not Satisfied?',
                      child: Column(
                        children: [
                          SwitchListTile(
                            title: Text('Revise User Requirements',
                                style: TextStyle(color: Colors.white)),
                            activeColor: Colors.teal,
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.grey[300],
                            value: _reviseRequirements,
                            onChanged: (value) {
                              setState(() {
                                _reviseRequirements = value;
                              });
                            },
                          ),
                          SwitchListTile(
                            title: Text('Revise Technical Aspects',
                                style: TextStyle(color: Colors.white)),
                            activeColor: Colors.teal,
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.grey[300],
                            value: _reviseTechnical,
                            onChanged: (value) {
                              setState(() {
                                _reviseTechnical = value;
                              });
                            },
                          ),
                          SwitchListTile(
                            title: Text('Revise Life Cycle',
                                style: TextStyle(color: Colors.white)),
                            activeColor: Colors.teal,
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.grey[300],
                            value: _reviseLifecycle,
                            onChanged: (value) {
                              setState(() {
                                _reviseLifecycle = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: _addChangesController,
                            decoration: InputDecoration(
                              hintText: 'Add revision details',
                              hintStyle: TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 20.0),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _reviseDocuments,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.2),
                                padding: EdgeInsets.symmetric(vertical: 14.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(
                                    color: Colors.white.withOpacity(0.5),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              child: Text('Regenerate',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      '   Satisfied?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        SizedBox(width: 8.0),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChooseTypeScreen(
                                        productDesc:
                                            _productDesc, // Pass the updated or unchanged productDesc
                                        domain: widget.domain,
                                        userreq: _userRequirements,
                                        techasp: _technicalAspects,
                                        lifeCycle: _lifeCycle,
                                      )));
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(50),
                              backgroundColor: Colors.white.withOpacity(0.2),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                side: BorderSide(
                                  color: Colors.white.withOpacity(0.5),
                                  width: 1.5,
                                ),
                              ),
                            ),
                            child: Text(
                              'Continue',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                    LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 60,
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      "Refreshing content...",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Card(
      color: Colors.white.withOpacity(0.2), // Transparent background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
            SizedBox(height: 8.0),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildExpansionTile({
    required String title,
    required Widget content,
  }) {
    return Card(
      color: Colors.white.withOpacity(0.2), // Transparent and glossy
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                secondary: Colors.white,
              ),
        ),
        child: ExpansionTile(
          title: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0),
          ),
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}
