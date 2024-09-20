import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ideaforge/Screens/Screen3.6.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UrlDownloadScreen extends StatefulWidget {
  final List<String> urls; // Accepting a list of URLs
  final String userreq;
  final String techasp;
  final String lifeCycle;
  final String proddesc;

  UrlDownloadScreen(
      {required this.urls,
      required this.userreq,
      required this.techasp,
      required this.lifeCycle,
      required this.proddesc});

  @override
  _UrlDownloadScreenState createState() => _UrlDownloadScreenState();
}

class _UrlDownloadScreenState extends State<UrlDownloadScreen> {
  bool _isDownloading = false;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _requestPermissions();
  }

  void _initializeNotifications() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null) {
          final file = File(response.payload!);
          if (await file.exists()) {
            OpenFile.open(file.path);
          }
        }
      },
    );
  }

  Future<void> _requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();

    if (statuses[Permission.storage]?.isDenied ?? true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Storage permission is required to download files.'),
        ),
      );
    } else if (statuses[Permission.manageExternalStorage]?.isDenied ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Manage External Storage permission required.'),
        ),
      );
    }

    if (await Permission.storage.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> _downloadFile(String url, String filename) async {
    setState(() {
      _isDownloading = true; // Set to true when download starts
    });

    await _requestPermissions();

    try {
      if (await Permission.storage.isGranted ||
          await Permission.manageExternalStorage.isGranted) {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          // Save to the private app-specific directory
          final externalDir = await getExternalStorageDirectory();
          final externalFilePath = '${externalDir!.path}/$filename';
          final externalFile = File(externalFilePath);
          await externalFile.writeAsBytes(response.bodyBytes);

          // Save to the public Downloads directory
          final downloadsDir = Directory('/storage/emulated/0/Download');
          if (!await downloadsDir.exists()) {
            await downloadsDir.create(recursive: true);
          }
          final downloadsFilePath = '${downloadsDir.path}/$filename';
          final downloadsFile = File(downloadsFilePath);
          await downloadsFile.writeAsBytes(response.bodyBytes);

          // Show notification after download
          await _showNotification(externalFilePath, filename);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Downloaded $filename.')),
          );
        } else {
          throw Exception('Failed to download file');
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download $filename')),
      );
    } finally {
      setState(() {
        _isDownloading = false; // Ensure this happens after download is done
      });
    }
  }

  Future<void> _postDataAndDownloadPdf(String content, String filename) async {
    setState(() {
      _isDownloading = true;
    });

    await _requestPermissions();

    // Escape content for special characters
    final escapedContent = content
        .replaceAll('"', '\\"') // Escape double quotes
        .replaceAll('\n', '\\n'); // Escape newlines

    print('Checking values for $filename:');
    print('Content: $escapedContent');
    print('Filename: $filename');

    if (escapedContent.isEmpty || filename.isEmpty) {
      print('Error: Content or filename is empty.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error: Content or filename is empty for $filename')),
      );
      return; // Exit early if content or filename is empty
    }

    try {
      if (await Permission.storage.isGranted ||
          await Permission.manageExternalStorage.isGranted) {
        print('Starting to send POST request for $filename');

        final jsonBody = '{"text": "$escapedContent", "filename": "$filename"}';

        print('Request body for $filename: $jsonBody');

        // Make POST request to the API
        final response = await http.post(
          Uri.parse('https://texttopdf-r8d3.onrender.com/generate-pdf'),
          headers: {"Content-Type": "application/json"},
          body: jsonBody,
        );

        print('Response status code for $filename: ${response.statusCode}');
        print('Response body for $filename: ${response.body}');

        if (response.statusCode == 200) {
          print('Download successful for $filename, starting to save file.');

          // Save to the private app-specific directory
          final externalDir = await getExternalStorageDirectory();
          final externalFilePath = '${externalDir!.path}/$filename.pdf';
          final externalFile = File(externalFilePath);
          await externalFile.writeAsBytes(response.bodyBytes);

          print('File saved successfully for $filename at $externalFilePath');

          // Show notification after download
          await _showNotification(externalFilePath, filename);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Downloaded $filename.pdf')),
          );
        } else {
          print(
              'Failed to download $filename, status code: ${response.statusCode}');
          throw Exception('Failed to download $filename');
        }
      } else {
        print('Permissions not granted to download $filename.');
        throw Exception('Permissions not granted');
      }
    } catch (e) {
      print('Error occurred while downloading $filename: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download $filename')),
      );
    }
    setState(() {
      _isDownloading = false;
    });
  }

  Future<void> _showNotification(String filePath, String filename) async {
    var androidDetails = AndroidNotificationDetails(
      'channel_id',
      'Downloads',
      channelDescription: 'File Download Notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      playSound: true,
      icon: 'ic_notification',
    );

    var platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Download complete',
      '$filename downloaded',
      platformDetails,
      payload: filePath,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg2.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        const Text(
                          'Download UI',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        ElevatedButton(
                          onPressed: () =>
                              _downloadFile(widget.urls[0], 'image_1.png'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50),
                            backgroundColor: Colors.white.withOpacity(0.0),
                            padding: EdgeInsets.symmetric(vertical: 16.0),
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.download, // The download icon
                                color: Colors.white,
                              ),
                              SizedBox(
                                  width:
                                      8), // Space between the icon and the text
                              const Text(
                                'Sample 1',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () =>
                              _downloadFile(widget.urls[1], 'image_2.png'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50),
                            backgroundColor: Colors.white.withOpacity(0.0),
                            padding: EdgeInsets.symmetric(vertical: 16.0),
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.download, // The download icon
                                color: Colors.white,
                              ),
                              SizedBox(
                                  width:
                                      8), // Space between the icon and the text
                              const Text(
                                'Sample 2',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 30.0),
                        Text(
                          'Download Documents',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 30.0),

                        // Button for downloading userreq
                        ElevatedButton(
                          onPressed: () async {
                            await _postDataAndDownloadPdf(
                                widget.userreq, 'User Requirements');
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50),
                            backgroundColor: Colors.white.withOpacity(0.0),
                            padding: EdgeInsets.symmetric(vertical: 16.0),
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.download, // The download icon
                                color: Colors.white,
                              ),
                              SizedBox(
                                  width:
                                      8), // Space between the icon and the text
                              const Text(
                                'User Requirements',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.0),

                        // Button for downloading techasp
                        ElevatedButton(
                          onPressed: () async {
                            await _postDataAndDownloadPdf(
                                widget.techasp, 'Technical Aspects');
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50),
                            backgroundColor: Colors.white.withOpacity(0.0),
                            padding: EdgeInsets.symmetric(vertical: 16.0),
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.download, // The download icon
                                color: Colors.white,
                              ),
                              SizedBox(
                                  width:
                                      8), // Space between the icon and the text
                              const Text(
                                'Technical Aspects',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.0),

                        // Button for downloading lifeCycle
                        ElevatedButton(
                          onPressed: () async {
                            await _postDataAndDownloadPdf(
                                widget.lifeCycle, 'Life Cycle');
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50),
                            backgroundColor: Colors.white.withOpacity(0.0),
                            padding: EdgeInsets.symmetric(vertical: 16.0),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.download, // The download icon
                                color: Colors.white,
                              ),
                              SizedBox(
                                  width:
                                      8), // Space between the icon and the text
                              const Text(
                                'Download Lifecycle',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            PremiumScreen(proddesc: widget.proddesc),
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      backgroundColor: Colors.teal.withOpacity(0.8),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        side: BorderSide(
                          color: Colors.white.withOpacity(0.5),
                          width: 1.5,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Continue to Premium',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
          if (_isDownloading)
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
                      "Downloading",
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
}
