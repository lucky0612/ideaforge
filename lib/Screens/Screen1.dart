import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:ideaforge/Screens/Screen2.dart';

class ProductDescriptionScreen extends StatefulWidget {
  const ProductDescriptionScreen({super.key});

  @override
  _ProductDescriptionScreenState createState() =>
      _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {
  // Variables to take input from the user
<<<<<<< HEAD
  TextEditingController _descriptionController = TextEditingController();
=======
  final TextEditingController _descriptionController = TextEditingController();
>>>>>>> origin/master

  bool _isLoading = false;

  // Variables to store API responses
  String _userRequirements = '';
  String _technicalAspects = '';
  String _lifeCycle = '';

  // State variable for selected domain
  String? _selectedDomain;

  // List of domain options
  final List<String> _domainOptions = [
    "Software Technology",
    "Healthcare and Biotech",
    "Renewable Energy",
    "Financial Services",
    "Advanced Manufacturing",
    "Artificial Intelligence and Robotics"
  ];

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitData() async {
    FocusScope.of(context).unfocus(); // Hide the keyboard
<<<<<<< HEAD
    var description = _descriptionController.text;
=======
    final description = _descriptionController.text;
>>>>>>> origin/master

    if (description.isEmpty) {
      _showErrorDialog('Please fill in the product description.');
      return;
    }

    if (_selectedDomain == null) {
      _showErrorDialog('Please select a domain.');
      return;
    }

    setState(() {
      _isLoading = true; // Start loading animation
    });

    final payload = {
      'idea': description,
      'domain': _selectedDomain,
    };

    final apiUrl = 'https://product-vision-api.onrender.com/api/user-input';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        final userId = responseData['id'];

        // Now fetch the required documentation
        await _fetchDocumentation(userId);

        // Navigate to the next page once all APIs are successfully fetched
        setState(() {
          _isLoading = false;
        });

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DocumentationScreen(
            userRequirements: _userRequirements,
            technicalAspects: _technicalAspects,
            lifeCycle: _lifeCycle,
            userId: userId,
            productDesc: description,
            domain: _selectedDomain!,
          ),
        ));
      } else {
        setState(() {
          _isLoading = false; // Stop loading
        });
        _showErrorDialog(
            'Failed to submit data. Status: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false; // Stop loading on error
      });
      _showErrorDialog('An error occurred. Error: $e');
    }
  }

  // Method to fetch the documentation using three APIs
  Future<void> _fetchDocumentation(String userId) async {
    final baseUrl =
        'https://product-vision-api.onrender.com/api/generate-document';

    try {
      final requirementsResponse = await http.get(
        Uri.parse('$baseUrl/requirements/$userId'),
      );
      final technicalResponse = await http.get(
        Uri.parse('$baseUrl/technical/$userId'),
      );
      final lifecycleResponse = await http.get(
        Uri.parse('$baseUrl/lifecycle/$userId'),
      );

      if (requirementsResponse.statusCode == 200 &&
          technicalResponse.statusCode == 200 &&
          lifecycleResponse.statusCode == 200) {
        // Remove * and # from the fetched data and save to state variables
        _userRequirements = jsonDecode(requirementsResponse.body)['document']
            .replaceAll('*', '')
            .replaceAll('#', '');

        _technicalAspects = jsonDecode(technicalResponse.body)['document']
            .replaceAll('*', '')
            .replaceAll('#', '');

        _lifeCycle = jsonDecode(lifecycleResponse.body)['document']
            .replaceAll('*', '')
            .replaceAll('#', '');
      } else {
        _showErrorDialog('Failed to fetch documentation. Status codes: '
            '${requirementsResponse.statusCode}, '
            '${technicalResponse.statusCode}, '
            '${lifecycleResponse.statusCode}');
      }
    } catch (e) {
      _showErrorDialog('An error occurred while fetching data. Error: $e');
    }
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
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg2.png', // Background image
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 70),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Describe your ',
                        style: TextStyle(
                          fontSize: 27.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Product',
                        style: TextStyle(
                          fontSize: 27.0,
                          color: Colors.orange, // Orange color for "Product"
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40.0),
                _buildTextField('Product Description', _descriptionController,
                    maxLines: 3),
                SizedBox(
                  height: 20,
                ),
                _buildDropdownField('   Domain', _domainOptions),
                const SizedBox(height: 20.0),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitData,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                        'Continue',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
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

  // Widget for TextField
  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[400]),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.5),
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.white, // White color for enabled border
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.white, // White color for focused border
              width: 2.0,
            ),
          ),
        ),
        style: const TextStyle(color: Colors.white),
        maxLines: maxLines,
      ),
    );
  }

  // Widget for Dropdown
  Widget _buildDropdownField(String label, List<String> options) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white.withOpacity(0.2),
        border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedDomain,
        hint: Text(
          label,
          style: TextStyle(color: Colors.grey[400]),
        ),
        items: options.map((String domain) {
          return DropdownMenuItem<String>(
            value: domain,
            child: Text(domain),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedDomain = value;
          });
        },
        dropdownColor: Colors.black.withOpacity(0.9),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
