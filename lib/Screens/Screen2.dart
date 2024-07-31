import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ideaforge/Screens/Screen3.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:permission_handler/permission_handler.dart';

class DocumentationScreen extends StatefulWidget {
  final String userId;

  DocumentationScreen({required this.userId});

  @override
  _DocumentationScreenState createState() => _DocumentationScreenState();
}

class _DocumentationScreenState extends State<DocumentationScreen> {
  final TextEditingController _addChangesController = TextEditingController();

  String _userRequirements = '';
  String _technicalAspects = '';
  String _lifeCycle = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDocumentation();
  }

  Future<void> _fetchDocumentation() async {
    final userId = widget.userId;
    try {
      final requirementsResponse = await http.get(
        Uri.parse(
            'https://product-vision-api.onrender.com/api/generate-requirements/$userId'),
      );
      final technicalResponse = await http.get(
        Uri.parse(
            'https://product-vision-api.onrender.com/api/generate-technical/$userId'),
      );
      final lifecycleResponse = await http.get(
        Uri.parse(
            'https://product-vision-api.onrender.com/api/generate-lifecycle/$userId'),
      );

      if (requirementsResponse.statusCode == 200 &&
          technicalResponse.statusCode == 200 &&
          lifecycleResponse.statusCode == 200) {
        setState(() {
          _userRequirements = jsonDecode(requirementsResponse.body)['document'];
          _technicalAspects = jsonDecode(technicalResponse.body)['document'];
          _lifeCycle = jsonDecode(lifecycleResponse.body)['document'];
          _isLoading = false;
        });
      } else {
        _showErrorDialog('Failed to fetch data. Please try again.');
      }
    } catch (e) {
      _showErrorDialog('An error occurred. Please try again.');
    }
  }

  Future<void> _requestPermissions() async {
    if (await Permission.storage.request().isGranted) {
      _generatePdf();
    } else {
      _showErrorDialog(
          'Storage permission is required to download documentation.');
    }
  }

  Future<void> _generatePdf() async {
    final pdf = pw.Document();

    // Ensure that the content is not empty
    String userRequirements =
        _userRequirements.isNotEmpty ? _userRequirements : 'No data available';
    String technicalAspects =
        _technicalAspects.isNotEmpty ? _technicalAspects : 'No data available';
    String lifeCycle = _lifeCycle.isNotEmpty ? _lifeCycle : 'No data available';

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('User Requirements',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text(userRequirements),
            pw.SizedBox(height: 20),
            pw.Text('Technical Aspects',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text(technicalAspects),
            pw.SizedBox(height: 20),
            pw.Text('Life Cycle',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text(lifeCycle),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
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
      appBar: AppBar(
        title: Text('DOCUMENTATION'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          TextField(
                            controller: _addChangesController,
                            decoration: InputDecoration(
                              hintText: 'Add changes',
                              hintStyle: TextStyle(color: Colors.white54),
                              filled: true,
                              fillColor: Colors.grey[800],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 8.0),
                          ElevatedButton(
                            onPressed: () {
                              // Handle regenerate logic using widget.userId if needed
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(221, 5, 4, 4),
                            ),
                            child: Text('Regenerate'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Satisfied?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _requestPermissions,
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(50),
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                            child: Text(
                              'Download Documentation',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ChooseTypeScreen()));
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(50),
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                            ),
                            child: Text(
                              'Continue',
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
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Card(
      color: Colors.black54,
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
      color: Colors.black38,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent, // To remove the divider color
          colorScheme: Theme.of(context).colorScheme.copyWith(
                secondary: Colors.white, // Set the accent color to white
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
