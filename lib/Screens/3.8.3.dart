import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './3.8.1.dart';
import 'dart:convert';
import 'dart:ui';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  String? _selectedDomain;
  List<String> _domains = [
    "Software Technology",
    "Healthcare and Biotech",
    "Renewable Energy",
    "Financial Services",
    "Advanced Manufacturing",
    "Artificial Intelligence and Robotics"
  ];

  List<dynamic> _exploreData = [];
  bool _showCongratsMessage = true;
  bool _isLoading = false;
  bool _hasError = false;

  // Updated mapping of domains to JPG asset image names
  Map<String, String> domainImageMap = {
    "Software Technology": 'assets/images/S.png',
    "Healthcare and Biotech": 'assets/images/HB.jpg',
    "Renewable Energy": 'assets/images/RE.png',
    "Financial Services": 'assets/images/fs.png',
    "Advanced Manufacturing": 'assets/images/AM.png',
    "Artificial Intelligence and Robotics": 'assets/images/AI.png',
  };

  final String _latitude = '12.9716';
  final String _longitude = '77.5946';

  @override
  void initState() {
    super.initState();
    _selectedDomain = "Software Technology";
    _fetchData(_selectedDomain!);
  }

  Future<void> _fetchData(String domain) async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    final String apiUrl =
        "https://geofencingendpts.onrender.com/ideas-nearby?latitude=$_latitude&longitude=$_longitude&domain=$domain";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          _exploreData = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
        print("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/s4.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Main content over the background
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: constraints.maxHeight == double.infinity
                      ? const NeverScrollableScrollPhysics()
                      : const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (_showCongratsMessage) _buildCongratsMessage(),
                          SizedBox(height: 30),
                          Text(
                            "EXPLORE",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          _buildDomainDropdown(),
                          SizedBox(height: 20),
                          _isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : _hasError
                                  ? _buildErrorMessage()
                                  : _exploreData.isNotEmpty
                                      ? _buildExploreCards()
                                      : Text(
                                          "No ideas available for this domain.",
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate back to the HomeScreen
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HomeScreen(proddesc: "some stuff")));
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.home),
      ),
    );
  }

  Widget _buildCongratsMessage() {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                "CONGRATULATIONS!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Your Idea has been successfully posted! Sit and explore other ideas while we find a match for yours.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _showCongratsMessage = false; // Dismiss message
              });
            },
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDomainDropdown() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
        border: Border.all(
          color: Colors.white.withOpacity(0.8),
          width: 2,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedDomain,
          icon: Icon(Icons.arrow_downward, color: Colors.white),
          dropdownColor: Color.fromARGB(255, 21, 13, 136).withOpacity(0.6),
          elevation: 16,
          style: TextStyle(color: Colors.white),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                _selectedDomain = newValue;
                _exploreData.clear();
              });
              _fetchData(newValue);
            }
          },
          items: _domains.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildExploreCards() {
    return Column(
      children: _exploreData.map((item) {
        String? domainImage = domainImageMap[_selectedDomain ?? ''];
        return _buildCard(
          item['title'],
          item['description'],
          item['requirements'],
          item['duration'],
          domainImage!, // Passing the domain image to the card
        );
      }).toList(),
    );
  }

  Widget _buildCard(String title, String description, String requirements,
      String duration, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(0, 5),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    imagePath,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 60, // Adjust the height of the blur effect
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(
                                  0.8), // Increased opacity for better text contrast
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  color: Colors.black.withOpacity(
                      0.3), // Slightly darker background for improved readability
                  child: ListTile(
                    contentPadding: EdgeInsets.all(
                        25), // Increased padding for more breathing room
                    title: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20, // Slightly larger font size for title
                        fontWeight: FontWeight.bold,
                        color: Colors
                            .white, // Solid white color for improved contrast
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height:
                                10), // Increased spacing between title and description
                        Text(
                          description,
                          style: TextStyle(
                            fontSize:
                                15, // Slightly larger font size for better readability
                            color:
                                Colors.white70, // Softer white for description
                          ),
                        ),
                        SizedBox(
                            height: 15), // Added more space between sections
                        Text(
                          "Requirements: $requirements",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold, // Bolder for emphasis
                            color: Colors
                                .white, // Solid white for clear readability
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Duration: $duration",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold, // Bolder for emphasis
                            color: Colors
                                .white, // Solid white for clear readability
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return Text(
      "Failed to load data. Please try again.",
      style: TextStyle(color: Colors.redAccent),
    );
  }
}
