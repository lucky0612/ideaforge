import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';

class IdeasNearYouPage extends StatefulWidget {
  @override
  _IdeasNearYouPageState createState() => _IdeasNearYouPageState();
}

class _IdeasNearYouPageState extends State<IdeasNearYouPage> {
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
  bool _isLoading = false;
  bool _hasError = false;

  // Mapping of domains to JPG asset image names
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
                          SizedBox(height: 10),
                          Text(
                            "Ideas Near You", // Title added here
                            style: TextStyle(
                              fontSize: 28,
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
    );
  }

  Widget _buildDomainDropdown() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15), // Curved edges
        color: Colors.transparent, // Transparent background
        border: Border.all(
          color:
              Colors.white.withOpacity(0.8), // White border with some opacity
          width: 2, // Width of the border
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedDomain,
          icon: Icon(Icons.arrow_downward, color: Colors.white),
          dropdownColor: Color.fromARGB(255, 21, 13, 136)
              .withOpacity(0.6), // Slightly opaque dropdown background
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
